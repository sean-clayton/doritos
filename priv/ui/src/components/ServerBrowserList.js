import styled from "react-emotion";

const ServerBrowserList = styled("div")`
  grid-area: servers;
  display: grid;
  grid-auto-rows: min-content;
  overflow-y: scroll;
  -webkit-overflow-scrolling: touch;
  max-height: 100%;
`;

export default ServerBrowserList;
