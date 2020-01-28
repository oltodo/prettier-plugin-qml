"use strict";

const { parse: parseQml } = require("@oltodo/qml-parser");

module.exports = code => {
  return parseQml(code);
};
