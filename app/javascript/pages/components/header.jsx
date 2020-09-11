import React, { Component } from 'react';
import Logo from 'images/mapc-logo.svg';
import 'styles/header.scss';


export default class Header extends Component {
  constructor(props) {
    super(props);
    this.el = document.createElement('div');
  }

  render() {
    return (
      <header className="header">
        <img src={Logo} className="header__image" alt="Metropolitan Area Planning Council"/>
        <h1 className="header__title">
          <span className="header__title--bold">ArtSpaces<span className="header__title--mobile-remove">: </span></span><span className="header__title--mobile-remove">Metro Boston's Art Space Directory</span>
        </h1>
      </header>
    );
  }
}
