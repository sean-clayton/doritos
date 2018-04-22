import React from "react";
import styled from "react-emotion";
import { NonIdealState, Card } from "@blueprintjs/core";
import { IconNames } from "@blueprintjs/icons";

const Wrapper = styled(Card)`
  display: grid;
  grid-area: server-info;
  height: fit-content;
`;

const Info = ({ server }) => (
  <article>
    <h1>{server.name}</h1>
    <h2>
      {server.numPlayers >= server.maxPlayers
        ? "FULL"
        : `${server.numPlayers}/${server.maxPlayers} Players`}
    </h2>
  </article>
);

class ServerInfo extends React.Component {
  render() {
    const { server } = this.props;
    return (
      <Wrapper elevation={2}>
        {!server ? (
          <NonIdealState
            title="Pick a Server"
            description="To see more information about a server, select one from the list."
            visual={IconNames.SEARCH_AROUND}
          />
        ) : (
          <Info server={server} />
        )}
      </Wrapper>
    );
  }
}

export default ServerInfo;
