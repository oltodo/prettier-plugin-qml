"use strict";

const { execSync } = require("child_process");
const _ = require("lodash");
const {
  __debug: { parse }
} = require("prettier");

const escapeString = str => str.replace(/("|`)/g, "\\$1");

function createError(message, loc) {
  // Construct an error similar to the ones thrown by Babel.
  const error = new SyntaxError(
    message + " (" + loc.start.line + ":" + loc.start.column + ")"
  );
  error.loc = loc;
  return error;
}

function checkJavascriptValue(node) {
  try {
    parse(node.value, { parser: "babel" });
  } catch (err) {
    if (err instanceof SyntaxError) {
      const { loc } = err;

      if (loc.start.line === 1) {
        loc.start.column += node.loc.start.column;
      }

      loc.start.line += node.loc.start.line - 1;

      const [message] = err.message.split(/ \(\d+:\d+\)/);

      throw createError(message, loc);
    } else {
      throw err;
    }
  }
}

function checkJavascriptNodes(node) {
  if (node.kind === "JavascriptValue" || node.kind === "JavascriptBlock") {
    checkJavascriptValue(node);
  }

  if (_.get(node, ["value", "kind"])) {
    checkJavascriptNodes(node.value);
  }

  if (node.children && node.children.length > 0) {
    node.children.forEach(checkJavascriptNodes);
  }
}

module.exports = text => {
  const bin = require.resolve("@oltodo/qml-parser");

  const result = execSync(`${bin} "${escapeString(text)}"`);
  const ast = JSON.parse(result);

  if (ast === null) {
    return {};
  }

  checkJavascriptNodes(ast);

  return ast;
};
