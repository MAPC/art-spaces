import React, { useState } from 'react';
import ReactMapGL, { Source, Layer } from 'react-map-gl';
import 'styles/map.scss';
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

  const [viewport, setViewport] = useState({
    latitude: 42.3601,
    longitude: -71.0589,
    zoom: 10,
    pitch: 45,
    bearing: -17.6,
    antialias: true,
  });

  const [dataLayer, setDataLayer] = useState({
    id: 'art-site-points',
    type: 'circle',
    source: 'points',
    paint: {
      'circle-color': '#f00',
      'circle-radius': 4,
    },
  });

  const [buildingLayer, setBuildingLayer] = useState({
    id: '3d-buildings',
    source: 'composite',
    'source-layer': 'building',
    filter: ['==', 'extrude', 'true'],
    type: 'fill-extrusion',
    minzoom: 15,
    paint: {
      'fill-extrusion-color': '#aaa',

      // use an 'interpolate' expression to add a smooth transition effect to the
      // buildings as the user zooms in
      'fill-extrusion-height': [
        'interpolate',
        ['linear'],
        ['zoom'],
        15,
        0,
        15.05,
        ['get', 'height'],
      ],
      'fill-extrusion-base': [
        'interpolate',
        ['linear'],
        ['zoom'],
        15,
        0,
        15.05,
        ['get', 'min_height'],
      ],
      'fill-extrusion-opacity': 0.6,
    },
  });

  if (loading) return 'Loading...';
  if (error) return `Error! ${error.message}`;

  return (
    <ReactMapGL
      {...viewport}
      width="100vw"
      height="100vh"
      onViewportChange={(viewport) => setViewport(viewport)}
      mapboxApiAccessToken="pk.eyJ1IjoiaWhpbGwiLCJhIjoiY2tlYnFoNjdtMDA2azJ3czQ5YWc1Z2xscyJ9.eewR1WFmO1-JleG79PqIEA"
      mapStyle="mapbox://styles/mapbox/light-v10"
      onClick={(event) => {
        console.log(event.features);
      }}
    >
      <Source type="geojson" data={data.sites} id="art-sites">
        <Layer {...dataLayer} />
      </Source>
      <Layer {...buildingLayer} />
    </ReactMapGL>
  );
};

export default Map;
