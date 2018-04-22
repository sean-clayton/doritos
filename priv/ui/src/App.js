import React from "react";
import styled, { injectGlobal } from "react-emotion";
import { palette } from "color-palette";
import bg from "images/bg.jpg";

injectGlobal`
  ::-moz-selection {
    background-color: #b3d4fc;
    color: black;
    text-shadow: none;
  }
  ::selection {
    background-color: #b3d4fc;
    color: black;
    text-shadow: none;
  }
  :root {
    background-color: ${palette.sapphire["100"]
      .darken(1)
      .desaturate(1.33)
      .hex()};
    color: white;
    font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', system-ui, Roboto, 'Helvetica Neue', sans-serif;
  }
  html, body {
    padding: 0;
    margin: 0;
    min-height: 100vh;
    width: 100%;
  }
  h1, h2, h3, h4, h5, h6 {
    text-transform: uppercase;
    font-weight: 700;
  }
`;

const AppContainer = styled("main")`
  padding: 1rem;
  min-height: 100vh;
  width: 100%;
  box-sizing: border-box;

  &:after {
    content: "";
    position: fixed;
    z-index: -1;
    filter: blur(8px);
    opacity: 0.05;
    top: 0;
    bottom: 0;
    left: 0;
    right: 0;
    background-image: url(${bg});
    background-repeat: no-repeat;
    background-size: cover;
  }
`;

class App extends React.Component {
  render() {
    return (
      <AppContainer>
        <h1>Dorito Server Browser</h1>
        <p>It's pretty cool</p>
      </AppContainer>
    );
  }
}

export default App;
