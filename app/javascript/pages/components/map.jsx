import React, { Component } from 'react';
import ReactMapGL from 'react-map-gl';
import '../../styles/map.scss';

export default class Map extends Component {

  state = {
    viewport: {
      latitude: 42.3601,
      longitude: -71.0589,
      zoom: 10
    }
  };

  render() {
    return (
      <ReactMapGL
        {...this.state.viewport}
        width="100vw"
        height="100vh"
        onViewportChange={(viewport) => this.setState({viewport})}
        mapboxApiAccessToken={process.env.MAPBOX_API_TOKEN}
      />
    );
  }
}
