import React from "react";
import styled from "react-emotion";
import ServerSearchForm from "./ServerSearchForm";
import ServerBrowserList from "./ServerBrowserList";
import ServerBrowserListItem from "./ServerBrowserListItem";
import ServerInfo from "./ServerInfo";

const ServerBrowserLayout = styled("div")`
  flex: 1;
  display: grid;
  height: 100%;
  grid-gap: 1rem;
  grid-template-areas:
    "search-form server-info"
    "servers server-info"
    "servers .";
  grid-template-columns: 1fr 1fr;
  grid-template-rows: min-content min-content 1fr;
  position: relative;
`;

class ServerBrowser extends React.Component {
  state = {
    selectedServer: null
  };
  selectServer = server => {
    this.setState({
      selectedServer: server
    });
  };
  deselectServer = () => {
    this.setState({
      selectedServer: null
    });
  };
  render() {
    return (
      <ServerBrowserLayout>
        <ServerSearchForm />
        <ServerBrowserList>
          {this.props.servers.map(server => (
            <ServerBrowserListItem
              key={server.ip}
              deselectServer={this.deselectServer}
              selectServer={this.selectServer}
              server={server}
            />
          ))}
        </ServerBrowserList>
        <ServerInfo server={this.state.selectedServer} />
      </ServerBrowserLayout>
    );
  }
}

export default ServerBrowser;
