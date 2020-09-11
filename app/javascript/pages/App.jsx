import React from 'react';
import Map from './components/map';

import { ApolloProvider } from '@apollo/client';
import { ApolloClient, InMemoryCache } from '@apollo/client';

const client = new ApolloClient({
  uri: location.href + '/graphql',
  cache: new InMemoryCache(),
  headers : { 'X-CSRF-TOKEN': document.querySelector('meta[name=csrf-token]').content
  }
});

const App = () => (
  <>
    <ApolloProvider client={client}>
      <Map />
    </ApolloProvider>
  </>
);

export default App;
