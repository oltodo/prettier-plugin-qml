const express = require("express");
const prettier = require("prettier");

const router = express.Router();

/* GET home page. */
router.post("/", function(req, res, next) {
  const { code } = req.body;

  const options = {
    parser: "qml",
    plugins: ["./plugins/prettier-plugin-qml"]
  };

  const formattedCode = prettier.format(code, options);

  const doc = prettier.__debug.formatDoc(
    prettier.__debug.printToDoc(code, options),
    { parser: "babel" }
  );

  res.json({ code: formattedCode, doc });
});

module.exports = router;
