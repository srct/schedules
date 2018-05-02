import * as React from 'react';
import Section from '../section';
import SectionList from './SectionList';
import Search from './Search';

interface State {
    currentSchedule: Section[];
}

class App extends React.Component<any, State> {
    constructor(props: any) {
        super(props);
        this.state = { currentSchedule: [] };

        this.addSectionToCurrentScheduleIfUnique = this.addSectionToCurrentScheduleIfUnique.bind(this);
        this.generateSchedule = this.generateSchedule.bind(this);
    }

    addSectionToCurrentScheduleIfUnique(section: Section) {
        if (!this.state.currentSchedule.find(sectionInSchedule => section === sectionInSchedule)) {
            this.setState({
                currentSchedule: [...this.state.currentSchedule, section],
            });
        }
    }

    generateSchedule() {
        fetch('http://localhost:3000/api/generate', {
            method: 'POST',
            body: JSON.stringify(this.state.currentSchedule),
            headers: {
                'Content-Type': 'text/plain',
            },
        })
            .then(response => response.text())
            .then(text => console.log(text));
    }

    render() {
        return (
            <div>
                <h1>Schedules</h1>
                <Search addSearchResultCallback={this.addSectionToCurrentScheduleIfUnique} />
                <SectionList sections={this.state.currentSchedule} />
                <button onClick={this.generateSchedule}>Generate Schedule</button>
            </div>
        );
    }
}
export default App;
