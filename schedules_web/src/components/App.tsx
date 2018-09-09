import * as React from 'react';
import { Container } from 'reactstrap';
import Schedule from '../containers/Schedule';
import Search from '../containers/Search';
import Header from './Header';

require('../css/core.css');

/**
 * The root component for the app
 */
const App = () => (
    <div>
        <Container>
            <Schedule />
            <Header />
            <Search />
        </Container>
    </div>
);

export default App;
