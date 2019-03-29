import React, { Component } from "react";
import AceEditor from "react-ace";
import styled, { createGlobalStyle } from "styled-components";
import ky from "ky";
import raw from "raw.macro";
import debounce from "lodash/debounce";

import "brace/theme/monokai";
import "brace/mode/javascript";

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

const defaultValue = raw("./defaultValue.qml");

class App extends Component {
  state = {
    code: defaultValue,
    doc: "",
    formattedCode: ""
  };

  componentDidMount() {
    this.reformat(this.state.code);
  }

  handleChange(code) {
    this.setState({ code });
    this.reformat(code);
  }

  reformat = debounce(async code => {
    console.log("test");
    const res = await ky
      .post("http://localhost:3001", { json: { code } })
      .json();

    this.setState(() => ({
      doc: res.doc,
      formattedCode: res.code
    }));
  }, 500);

  render() {
    const { code, doc, formattedCode } = this.state;

    return (
      <Wrapper>
        <GlobalStyle />
        <ColumnLeft>
          <AceEditor
            theme="monokai"
            mode="text"
            onChange={this.handleChange.bind(this)}
            name="editor"
            width="100%"
            height="100vh"
            defaultValue={defaultValue}
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
            editorProps={{ $blockScrolling: true }}
          />
        </ColumnRight>
      </Wrapper>
    );
  }
}

export default App;
