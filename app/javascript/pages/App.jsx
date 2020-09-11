import React from 'react';
import Map from './components/map';

import { ApolloProvider } from '@apollo/client';
import { ApolloClient, InMemoryCache } from '@apollo/client';

const client = new ApolloClient({
  uri: 'http://localhost:3000/graphql',
  cache: new InMemoryCache()
});

const App = () => (
  <>
    <ApolloProvider client={client}>
      <Map />
    </ApolloProvider>
  </>
);

export default App;
