"use strict";

const { parseFile: parseQml } = require("@oltodo/qml-parser");

module.exports = (code, _, { filepath }) => {
  return parseQml(filepath);
};
