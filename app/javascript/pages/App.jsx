import React from 'react';
import {
  BrowserRouter as Router,
  Switch,
  Route,
  Link
} from "react-router-dom";
import { ApolloProvider, ApolloClient, InMemoryCache } from '@apollo/client';
import Map from './components/map';
import About from './components/about'
import Header from './components/header';

const client = new ApolloClient({
  uri: location.href + '/graphql',
  cache: new InMemoryCache(),
  headers: { 'X-CSRF-TOKEN': document.querySelector('meta[name=csrf-token]').content }
});

const App = () => (
  <Router>
      <Header />
      <Switch>
        <Route path="/about">
          <About />
        </Route>
        <Route path="/">
          <ApolloProvider client={client}>
            <Map />
          </ApolloProvider>
        </Route>
      </Switch>
  </Router>
);

export default App;
