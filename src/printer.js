"use strict";

const _ = require("lodash");
const {
  getSupportInfo,
  doc: {
    builders: {
      breakParent,
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
  util: { isNextLineEmpty }
} = require("prettier");

const comments = require("./comments");
const { insertPragma } = require("./pragma");

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

      return printLines(path, options, print);
    }

    case "Import": {
      return concat([
        join(" ", [
          "import",
          node.identifier || concat(['"', node.path.trim(), '"']),
          node.version || "",
          trim,
          (node.as && join(" ", ["as", node.as])) || ""
        ]),
        hardline
      ]);
    }

    case "ObjectDefinition": {
      if (!node.children) {
        return concat([node.identifier, " {}"]);
      }

      let body;

      if (_.every(node.children, { kind: "Attribute" })) {
        body = group(
          concat([
            indent(
              join(
                ifBreak("", ";"),
                path.map(item => concat([line, print(item)]), "children")
              )
            ),
            line
          ])
        );
      } else {
        body = concat([
          indent(
            concat(
              path.map(
                item =>
                  concat([
                    hardline,
                    print(item),
                    printNextEmptyLine(path, options)
                  ]),
                "children"
              )
            )
          ),
          hardline
        ]);
      }

      return concat([node.identifier, " {", body, "}", breakParent]);
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
      return concat([
        join(" ", [
          ...(node.default ? ["default"] : []),
          ...(node.readonly ? ["readonly"] : []),
          "property",
          concat([
            ...(node.typeModifier ? [node.typeModifier, "<"] : []),
            node.type,
            ...(node.typeModifier ? [">"] : [])
          ]),
          node.identifier,
          ...(node.value
            ? [concat([trim, ": ", path.call(print, "value")])]
            : [])
        ])
      ]);
    }

    case "Attribute": {
      return concat([node.identifier, ": ", path.call(print, "value")]);
    }

    case "ArrayBinding": {
      return group(
        concat([
          "[",
          group(
            concat([
              indent(
                join(
                  ",",
                  path.map(item => concat([softline, print(item)]), "children")
                )
              ),
              softline
            ])
          ),
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

  if (node.kind === "JavascriptBlock") {
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

  if (text[0] === "{") {
    const blockContent = _.trim(text, "{}");
    const code = getJavascriptCodeBlockValue(blockContent, textToDoc);

    // @todo: ensure that something is clearly returning
    return markAsRoot(
      concat(["{", indent(concat([hardline, code])), hardline, "}"])
    );
  }

  const inline = getJavascriptCodeBlockValue(text, textToDoc);
  const block = getJavascriptCodeBlockValue(`return ${text}`, textToDoc);

  return markAsRoot(
    conditionalGroup([
      stripTrailingSemiColon(inline),
      concat(["{", indent(concat([hardline, block])), hardline, "}"])
    ])
  );
}

function getJavascriptCodeBlockValue(text, textToDoc) {
  const { languages } = getSupportInfo();
  const {
    parsers: [parser]
  } = _.find(languages, { name: "JavaScript" });

  const doc = textToDoc(text, { parser });

  return stripTrailingHardline(doc);
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
