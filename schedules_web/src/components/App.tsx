import * as React from 'react';
import Schedule from '../containers/Schedule';
import Search from '../containers/Search';
import Header from './Header';

const App = () => (
    <div>
        <Header />
        <Search />
        <Schedule />
    </div>
);

export default App;
