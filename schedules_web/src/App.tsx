import './App.css';
import * as React from 'react';
import {Convert} from './Models/Section';

import logo from './logo.svg';

/* interface Props {}*/

/* interface State {*/
/* sections: Section[]*/
/* }*/

class App extends React.Component {

    constructor(props: any) {
        super(props);
        this.state = { sections: [] };
        this.loadSections();
    }

    public render() {
        return (
            <div className="App">
                <header className="App-header">
                    <img src={logo} className="App-logo" alt="logo" />
                    <h1 className="App-title">Welcome to React</h1>
                </header>
                <p className="App-intro">
                    To get started, edit <code>src/App.tsx</code> and save to reload.
                </p>
            </div>
        );
    }

    private loadSections() {
        fetch('http://localhost:3001/api/courses/1/sections')
            .then(response => response.json())
            .then(obj => {
                let sections = Convert.toSection(JSON.stringify(obj));
                console.log(sections);
            });
    }
}

export default App;
