import * as React from 'react';
import Section from '../section';
import SectionList from './SectionList';
import Search from './Search';
import * as FileSaver from 'file-saver';

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
        const crns = this.state.currentSchedule.map(section => section.crn);
        fetch('http://localhost:3000/api/generate', {
            method: 'POST',
            body: JSON.stringify(crns),
            headers: {
                'Content-Type': 'text/plain',
            },
        })
            .then(response => response.text())
            .then(text => {
                const blob = new Blob([text], { type: 'text/plain;charset=utf-9' });
                FileSaver.saveAs(blob, 'GMU Fall 2018.ics');
            });
    }

    render() {
        return (
            <div>
                <h1>Schedules</h1>
                <h2>Search</h2>
                <Search addSearchResultCallback={this.addSectionToCurrentScheduleIfUnique} />
                <h2>Your schedule</h2>
                <SectionList sections={this.state.currentSchedule} />
                <button onClick={this.generateSchedule}>Generate Schedule</button>
            </div>
        );
    }
}
export default App;
