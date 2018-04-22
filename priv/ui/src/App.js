/* global dew */
import React from "react";
import styled, { injectGlobal } from "react-emotion";
import { Tooltip, Icon, Intent } from "@blueprintjs/core";
import { IconNames } from "@blueprintjs/icons";
import { palette } from "color-palette";
import { servers } from "fake-data";
import ServerBrowser from "components/ServerBrowser";
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
    background-image: linear-gradient(to bottom, rgba(0,0,0,0), rgba(0,0,0,0.75));
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
    font-weight: 700;
  }
`;

const AppContainer = styled("main")`
  padding: 1rem;
  min-height: 100vh;
  width: 100%;
  box-sizing: border-box;
  display: flex;
  flex-direction: column;

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

const DewConnectedIndicatorWrapper = styled("div")`
  position: absolute;
  top: 1rem;
  right: 1rem;
`;

const DewConnectedIndicator = ({ connected }) => (
  <DewConnectedIndicatorWrapper>
    <Tooltip
      intent={connected ? Intent.SUCCESS : Intent.DANGER}
      content={
        connected
          ? "Connected to El Dewrito"
          : "Could not connect to El Dewrito"
      }
    >
      <Icon
        icon={connected ? IconNames.TICK_CIRCLE : IconNames.OFFLINE}
        intent={connected ? Intent.SUCCESS : Intent.DANGER}
      />
    </Tooltip>
  </DewConnectedIndicatorWrapper>
);

class App extends React.Component {
  state = {
    dewLoaded: false
  };
  componentDidMount() {
    try {
      this.setState({
        dewLoaded: window.dew !== undefined || dew !== undefined
      });
    } catch (e) {
      // Swallow exception
    }
  }
  render() {
    return (
      <AppContainer className="pt-dark">
        <DewConnectedIndicator connected={this.state.dewLoaded} />
        <h1>Dorito Server Browser</h1>
        <ServerBrowser servers={servers} />
      </AppContainer>
    );
  }
}

export default App;
