"use strict";

const _ = require("lodash");
const {
  getSupportInfo,
  doc: {
    builders: {
      concat,
      conditionalGroup,
      group,
      hardline,
      ifBreak,
      indent,
      join,
      line,
      markAsRoot,
      softline,
      trim
    },
    utils: { stripTrailingHardline }
  },
  util: { isNextLineEmpty, hasNewlineInRange }
} = require("prettier");

const comments = require("./comments");
const { insertPragma } = require("./pragma");

function genericPrint(path, options, print) {
  const node = path.getValue();

  /* istanbul ignore if */
  if (!node) {
    return "";
  }

  if (typeof node === "string") {
    return node;
  }

  switch (node.kind) {
    case "Program": {
      if (node.children.length === 0) {
        return "";
      }

      return concat([printLines(path, options, print), hardline]);
    }

    case "Pragma": {
      return concat([join(" ", ["pragma", node.type]), hardline]);
    }

    case "Import": {
      const quote = options.singleQuote ? "'" : '"';

      return concat([
        join(" ", [
          "import",
          node.identifier || concat([quote, node.path.trim(), quote]),
          node.version || "",
          trim,
          (node.as && join(" ", ["as", node.as])) || ""
        ]),
        hardline
      ]);
    }

    case "ObjectDefinition": {
      const parts = [];

      parts.push(node.identifier);

      if (node.on) {
        parts.push(" on ");
        parts.push(node.on);
      }

      if (!node.children) {
        return concat([...parts, " {}"]);
      }

      const shouldBreak =
        !_.every(node.children, { kind: "Attribute" }) ||
        hasNewlineInRange(
          options.originalText,
          options.locStart(node),
          options.locStart(node.children[0])
        );

      const isLast = index => index === node.children.length - 1;

      const getContent = shouldBreak =>
        group(
          concat([
            ...parts,
            " {",
            indent(
              concat([
                line,
                group(
                  join(
                    concat([ifBreak("", ";"), line]),
                    path.map(
                      (item, index) =>
                        concat([
                          print(item),
                          !isLast(index)
                            ? printNextEmptyLine(path, options)
                            : ""
                        ]),
                      "children"
                    )
                  ),
                  { shouldBreak }
                )
              ])
            ),
            line,
            "}"
          ]),
          { shouldBreak }
        );

      return conditionalGroup([getContent(shouldBreak), getContent(true)]);
    }

    case "ObjectIdentifier": {
      return `id: ${node.value}`;
    }

    case "Signal": {
      if (!node.parameters) {
        return concat(["signal ", node.identifier]);
      }

      return concat([
        "signal ",
        group(
          concat([
            node.identifier,
            "(",
            group(
              concat([
                indent(
                  concat(
                    node.parameters.map(
                      (item, index) =>
                        concat([
                          softline,
                          item.type,
                          " ",
                          item.identifier,
                          ...(index < node.parameters.length - 1 ? [", "] : [])
                        ]),
                      "parameters"
                    )
                  )
                ),
                softline
              ])
            ),
            ")"
          ])
        )
      ]);
    }

    case "Property": {
      const parts = [
        ...(node.default ? ["default"] : []),
        ...(node.readonly ? ["readonly"] : []),
        "property",
        concat([
          ...(node.typeModifier ? [node.typeModifier, "<"] : []),
          node.type,
          ...(node.typeModifier ? [">"] : [])
        ])
      ];

      if (!node.value || node.value.kind !== "ArrayBinding") {
        parts.push(concat([node.identifier, node.value ? ":" : ""]));
      }

      if (!node.value) {
        return join(" ", parts);
      }

      const value = path.call(print, "value");

      return group(concat([join(" ", parts), " ", value]));
    }

    case "Attribute": {
      let value;

      if (isValueEmpty(node)) {
        value = "{}";
      } else {
        value = path.call(print, "value");
      }

      return group(concat([node.identifier, ": ", value]));
    }

    case "ArrayBinding": {
      return group(
        concat([
          node.identifier,
          ": [",
          group(
            indent(
              concat([
                hardline,
                join(
                  concat([",", hardline]),
                  path.map(item => print(item), "children")
                )
              ])
            )
          ),
          hardline,
          "]"
        ])
      );
    }
  }

  // eslint-disable-next-line
  console.error(`${node.kind} not implemented`, node);

  return "";
}

function embed(path, print, textToDoc, options) {
  const node = path.getValue();

  if (node.kind === "Function") {
    return embedFunction(path, print, textToDoc, options);
  }

  if (node.kind === "JavascriptBlock" || node.kind === "JavascriptValue") {
    return embedBlock(path, print, textToDoc, options);
  }

  return null;
}

function embedFunction(path, print, textToDoc, options) {
  const node = path.getValue();

  const text = options.originalText.slice(
    node.loc.start.offset,
    node.loc.end.offset
  );

  const doc = getJavascriptCodeBlockValue(text, textToDoc);

  return markAsRoot(doc);
}

function embedBlock(path, print, textToDoc, options) {
  const node = path.getValue();

  const text = options.originalText.slice(
    node.loc.start.offset,
    node.loc.end.offset
  );

  if (node.kind === "JavascriptBlock") {
    const blockContent = _.trim(text, "{}");

    if (_.trim(blockContent) === "") {
      return "{}";
    }

    const code = getJavascriptCodeBlockValue(blockContent, textToDoc);

    // @todo: ensure that something is clearly returning
    return group(
      concat(["{", indent(concat([hardline, code])), hardline, "}"])
    );
  }

  // boolean
  if (text === "true" || text === "false") {
    return text;
  }

  // signed integers or floats
  if (/^-?[0-9.]+$/.test(text)) {
    return text;
  }

  // identifiers
  if (/^[\w.]+$/.test(text)) {
    return text;
  }

  // regular strings
  if (/^("|')[^"']*("|')$/.test(text)) {
    const delimiter = options.singleQuote ? "'" : '"';
    return `${delimiter}${_.trim(text, `'"`)}${delimiter}`;
  }

  let content;

  if (text[0] === "{") {
    content = getJsonCodeBlockValue(text, textToDoc, options.singleQuote);
  } else {
    content = getJavascriptCodeBlockValue(text, textToDoc);
  }

  return markAsRoot(stripTrailingSemiColon(content));
}

function printLines(path, options, print, childrenAttribute = "children") {
  const parts = [];

  path.map(childPath => {
    const printed = concat([
      print(childPath),
      printNextEmptyLine(path, options)
    ]);

    parts.push(printed);
  }, childrenAttribute);

  return concat(parts);
}

function printNextEmptyLine(path, options) {
  const node = path.getValue();

  if (isNextLineEmpty(options.originalText, node, options)) {
    return hardline;
  }

  return "";
}

function getJavascriptCodeBlockValue(text, textToDoc) {
  const { languages } = getSupportInfo();
  const {
    parsers: [parser]
  } = _.find(languages, { name: "JavaScript" });

  const doc = textToDoc(text, { parser });

  return stripTrailingHardline(doc);
}

function getJsonCodeBlockValue(text, textToDoc, singleQuote) {
  const { languages } = getSupportInfo();
  const {
    parsers: [parser]
  } = _.find(languages, { name: "JSON" });

  let doc = textToDoc(text, { parser });

  if (singleQuote) {
    doc = toSingleQuote(doc);
  }

  return stripTrailingHardline(doc);
}

function toSingleQuote(doc) {
  if (doc.parts) {
    doc.parts = _.map(doc.parts, toSingleQuote);
  }

  if (doc.contents) {
    doc.contents = toSingleQuote(doc.contents);
  }

  if (
    _.isString(doc) &&
    _.startsWith(doc, '"') &&
    _.endsWith(doc, '"') &&
    doc.indexOf("'") === -1
  ) {
    return `'${_.trim(doc, '"')}'`;
  }

  return doc;
}

function stripTrailingSemiColon(doc) {
  if (doc.parts) {
    const index = _.indexOf(doc.parts, ";");

    if (index === -1) {
      doc.parts = _.map(doc.parts, stripTrailingSemiColon);
    } else {
      doc.parts = _.slice(doc.parts, 0, index);
    }
  }

  return doc;
}

function isValueEmpty(node) {
  if (!node.value) {
    return true;
  }

  if (node.value.kind === "JavascriptValue" && node.value.value === ";") {
    return true;
  }

  return false;
}

module.exports = {
  print: genericPrint,
  embed,
  insertPragma,
  // massageAstNode: clean,
  getCommentChildNodes: comments.getCommentChildNodes,
  canAttachComment: comments.canAttachComment,
  isBlockComment: comments.isBlockComment,
  handleComments: {
    ownLine: comments.handleOwnLineComment,
    endOfLine: comments.handleEndOfLineComment,
    remaining: comments.handleRemainingComment
  },
  printComment(commentPath) {
    const comment = commentPath.getValue();

    switch (comment.kind) {
      case "CommentBlock": {
        // for now, don't touch single line block comments
        if (!comment.value.includes("\n")) {
          return comment.value;
        }

        const lines = comment.value.split(/\r?\n/g);
        // if this is a block comment, handle indentation
        if (
          lines.slice(1, lines.length - 1).every(line => line.trim()[0] === "*")
        ) {
          return join(
            hardline,
            lines.map(
              (line, index) =>
                (index > 0 ? " " : "") +
                (index < lines.length - 1 ? line.trim() : line.trimLeft())
            )
          );
        }

        // otherwise we can't be sure about indentation, so just print as is
        return comment.value;
      }
      case "CommentLine": {
        return comment.value.trimRight();
      }
      /* istanbul ignore next */
      default:
        throw new Error(`Not a comment: ${JSON.stringify(comment)}`);
    }
  },
  hasPrettierIgnore(path) {
    const node = path.getNode();
    return (
      node &&
      node.comments &&
      node.comments.length > 0 &&
      node.comments.some(comment => comment.value.includes("prettier-ignore"))
    );
  }
};
