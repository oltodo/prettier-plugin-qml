"use strict";

const { parseFile } = require("@nbazille/qml-parser");

module.exports = (code, _, { filepath }) => {
  return parseFile(filepath);
};
