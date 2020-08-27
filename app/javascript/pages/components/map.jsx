import React, { Component } from 'react';
import ReactMapGL from 'react-map-gl';
import '../../styles/map.scss';
import { useQuery, gql } from '@apollo/client';

const SITES = gql`
  query GetSites {
    sites {
      siteName
      location
    }
  }
`;

export default class Map extends Component {
  state = {
    viewport: {
      latitude: 42.3601,
      longitude: -71.0589,
      zoom: 10
    }
  };

  componentDidMount() {
    const { loading, error, data } = useQuery(SITES);
  }


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
