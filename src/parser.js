"use strict";

const { parse } = require("@nbazille/qml-parser");

module.exports = (code) => {
  return parse(code);
};
