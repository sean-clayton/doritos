import React from "react";
import styled, { css } from "react-emotion";
import { Card } from "@blueprintjs/core";
import { palette } from "color-palette";

const Wrapper = styled(Card)`
  display: grid;
  margin-bottom: 0.5rem;

  &:focus {
    outline: 3px solid ${palette.cobalt["500"]};
  }
`;

const ServerBrowserListItem = ({ selectServer, server }) => (
  <Wrapper
    interactive
    onClick={() => {
      selectServer(server);
    }}
  >
    <h3
      className={css`
        margin-top: 0;
      `}
    >
      {server.name}
    </h3>
    <p>
      <strong>Players: </strong>
      {server.numPlayers}/{server.maxPlayers}
    </p>
  </Wrapper>
);

export default ServerBrowserListItem;
