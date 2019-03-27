"use strict";

const parse = require("./parser");
const printer = require("./printer");
const options = require("./options");
const { hasPragma } = require("./pragma");

const languages = [
  {
    name: "QML",
    parsers: ["qml"],
    tmScope: "source.qml",
    aceMode: "text",
    codemirrorMode: "qml",
    extensions: [".qml", ".qbs"],
    vscodeLanguageIds: ["qml"],
    linguistLanguageId: 305
  }
];

const loc = prop => node => {
  return node.loc && node.loc[prop] && node.loc[prop].offset;
};

const parsers = {
  qml: {
    parse,
    astFormat: "qml",
    locStart: loc("start"),
    locEnd: loc("end"),
    hasPragma
  }
};

const printers = {
  qml: printer
};

module.exports = {
  languages,
  printers,
  parsers,
  options,
  defaultOptions: {
    tabWidth: 4,
    trailingComma: "none",
    singleQuote: true
  }
};
