"use strict";

const { execSync } = require("child_process");

const escapeString = str => str.replace(/"/g, '\\"');

const parse = text => {
  const bin = require.resolve("@oltodo/qml-parser");

  let result = execSync(`${bin} "${escapeString(text)}"`);
  result = JSON.parse(result);

  if (result === null) {
    return {};
  }

  return result;
};

module.exports = parse;
