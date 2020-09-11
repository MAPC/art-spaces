import React, { useState } from 'react';
import ReactMapGL, {Source, Layer} from 'react-map-gl';
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
  const { loading, error, data } = useQuery(SITES);

  const [viewport, setViewport] = useState(
    {
      latitude: 42.3601,
      longitude: -71.0589,
      zoom: 10
    });


  const [dataLayer, setDataLayer] = useState({
      id: 'my-layer',
      type: 'circle',
      source: 'points',
      paint: {
          'circle-color': '#f00',
          'circle-radius': 4
      }
  })

  if (loading) return 'Loading...';
  if (error) return `Error! ${error.message}`;

  return (
    <ReactMapGL
      {...viewport}
      width="100vw"
      height="100vh"
      onViewportChange={(viewport) => setViewport(viewport)}
      mapboxApiAccessToken={process.env.MAPBOX_API_TOKEN}
      mapStyle="mapbox://styles/mapbox/light-v10"
    >
      <Source type="geojson" data={data.sites}>
        <Layer {...dataLayer} />
      </Source>
    </ReactMapGL>
  )
}

export default Map;
