import * as React from 'react';
import { Container } from 'reactstrap';
import Search from '../containers/Search';
import Header from './Header';

require('../css/core.css');

const App = () => (
    <div>
        <Container>
            <Header />
            <Search />
            {/* <Schedule /> */}
        </Container>
    </div>
);

export default App;
