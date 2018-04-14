import React, { Component } from 'react';
import Search from './Search.js';
import Schedule from './Schedule.js';

class App extends Component {
    constructor(props) {
        super(props);
        this.state = {
            sections: [],
        };

        this.addToSchedule = this.addToSchedule.bind(this);
    }

    addToSchedule(event, section) {
        if (this.state.sections !== undefined && !this.state.sections.includes(section)) {
            this.setState({
                sections: [...this.state.sections, section],
            });
        }
    }

    render() {
        return (
            <div className="App">
                <h1>Schedules</h1>
                <Search addToSchedule={this.addToSchedule} />
                <Schedule sections={this.state.sections} />
            </div>
        );
    }
}

export default App;
