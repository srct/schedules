import React, { Component } from 'react';
import Search from './Search.js';
import Schedule from './Schedule.js';

class App extends Component {
    constructor(props) {
        super(props);
        this.state = {
            sections: [],
        };

        this.addSectionToScheduleIfUnique = this.addSectionToScheduleIfUnique.bind(this);
        this.isSectionInSchedule = this.isSectionInSchedule.bind(this);
    }

    addSectionToScheduleIfUnique(section) {
        if (!this.isSectionInSchedule(section)) {
            this.setState({ sections: [...this.state.sections, section] });
        }
    }

    isSectionInSchedule(section) {
        return this.state.sections !== undefined && this.state.sections.includes(section);
    }

    render() {
        return (
            <div className="App">
                <h1>Schedules</h1>
                <Search addToSchedule={this.addSectionToScheduleIfUnique} />
                <Schedule sections={this.state.sections} />
            </div>
        );
    }
}

export default App;
