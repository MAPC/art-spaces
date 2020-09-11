import React, { useState } from 'react';
import ReactMapGL from 'react-map-gl';
import '../../styles/map.scss';
import { useQuery, gql } from '@apollo/client';

const SITES = gql`
  query GetSites {
    sites {
      type
      features {
        type
        geometry
        properties
      }
    }
  }
`;

const Map = () => {
  const [viewport, setViewport] = useState(
    {
      latitude: 42.3601,
      longitude: -71.0589,
      zoom: 10
    });

  const { loading, error, data } = useQuery(SITES);

  if (loading) return 'Loading...';
  if (error) return `Error! ${error.message}`;

  return (
    <ReactMapGL
      {...viewport}
      width="100vw"
      height="100vh"
      onViewportChange={(viewport) => setViewport(viewport)}
      mapboxApiAccessToken={process.env.MAPBOX_API_TOKEN}
    />
  )
}

export default Map;
