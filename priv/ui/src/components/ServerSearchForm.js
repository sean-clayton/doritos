import React from "react";
import { css } from "react-emotion";

class ServerSearchForm extends React.Component {
  render() {
    return (
      <form
        className={css`
          grid-area: search-form;
        `}
      >
        <p>Search</p>
      </form>
    );
  }
}

export default ServerSearchForm;
