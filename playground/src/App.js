import React, { useState, useEffect } from "react";
import AceEditor from "react-ace";
import styled, { createGlobalStyle } from "styled-components";
import ky from "ky";
import raw from "raw.macro";
import useLocalStorage from "react-use-localstorage";
import { useDebounce } from "use-debounce";

import "brace/theme/monokai";
import "brace/mode/javascript";

const defaultValue = raw("./defaultValue.qml");

const GlobalStyle = createGlobalStyle`
  body {
    background: #272721;
    margin: 0;
  }
`;

const Wrapper = styled.div`
  display: flex;
  width: 100vw;
  height: 100vh;
`;

const Column = styled.div`
  width: calc(100vw / 3);
`;

const ColumnLeft = styled(Column)``;

const ColumnMiddle = styled(Column)`
  border: rgba(255, 255, 255, 0.1) solid;
  border-width: 0 1px;
`;

const ColumnRight = styled(Column)``;

let controller = new AbortController();

const fetchFormattedCode = code => {
  controller = new AbortController();

  return ky
    .post("http://localhost:3001", {
      json: { code },
      signal: controller.signal,
      timeout: 10000
    })
    .json();
};

function App() {
  const [codeLocalStorage, setCodeLocalStorage] = useLocalStorage(
    "code",
    defaultValue
  );
  const [code, setCode] = useState(codeLocalStorage);
  const [doc, setDoc] = useState("");
  const [formattedCode, setFormattedCode] = useState("");
  const [debouncedCode] = useDebounce(code, 500);

  useEffect(() => {
    (async () => {
      controller.abort();

      const res = await fetchFormattedCode(code);

      setDoc(res.doc);
      setFormattedCode(res.code);
    })();
  }, [debouncedCode]);

  return (
    <Wrapper>
      <GlobalStyle />
      <ColumnLeft>
        <AceEditor
          theme="monokai"
          mode="text"
          onChange={newCode => {
            setCodeLocalStorage(newCode);
            setCode(newCode);
          }}
          onLoad={() => setCode(code)}
          name="editor"
          width="100%"
          height="100vh"
          value={code}
          editorProps={{ $blockScrolling: true }}
        />
      </ColumnLeft>
      <ColumnMiddle>
        <AceEditor
          theme="monokai"
          mode="javascript"
          name="editor"
          width="100%"
          height="100vh"
          value={doc}
          highlightActiveLine={false}
          showGutter={false}
          showPrintMargin={false}
          readOnly
          editorProps={{ $blockScrolling: true }}
        />
      </ColumnMiddle>
      <ColumnRight>
        <AceEditor
          theme="monokai"
          mode="text"
          name="editor"
          width="100%"
          height="100vh"
          value={formattedCode}
          highlightActiveLine={false}
          showGutter={false}
          showPrintMargin={false}
          readOnly
          editorProps={{ $blockScrolling: true }}
        />
      </ColumnRight>
    </Wrapper>
  );
}

export default App;
