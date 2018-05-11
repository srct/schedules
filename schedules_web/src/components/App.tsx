import * as FileSaver from 'file-saver';
import * as React from 'react';
import Section from '../section';
import Search from './Search';
import SectionList from './SectionList';

interface State {
    currentSchedule: Section[];
}

class App extends React.Component<any, State> {
    constructor(props: any) {
        super(props);
        this.state = { currentSchedule: [] };
    }

    render() {
        return (
            <div>
                <h1>Schedules</h1>
                <h2>Search</h2>
                <Search addSearchResultCallback={this.addSectionToCurrentScheduleIfUnique} />
                <h2>Your schedule</h2>
                <SectionList
                    sections={this.state.currentSchedule}
                    buttonText="Remove from schedule"
                    selectSectionCallback={this.removeFromSchedule}
                />
                <button onClick={this.generateSchedule}>Generate Schedule</button>
            </div>
        );
    }

    addSectionToCurrentScheduleIfUnique = (section: Section) => {
        if (!this.isSectionInSchedule(section)) {
            this.setState({
                currentSchedule: [...this.state.currentSchedule, section],
            });
        }
    };

    isSectionInSchedule = (section: Section) =>
        this.state.currentSchedule.find(sectionInSchedule => section === sectionInSchedule);

    generateSchedule = () => {
        const crns = this.state.currentSchedule.map(section => section.crn);
        fetch('http://localhost:3000/api/generate', {
            method: 'POST',
            body: JSON.stringify(crns),
            headers: {
                'Content-Type': 'application/json',
            },
        })
            .then(response => response.text())
            .then(text => {
                const blob = new Blob([text], { type: 'text/plain;charset=utf-8' });
                FileSaver.saveAs(blob, 'GMU Fall 2018.ics');
            });
    };

    removeFromSchedule = (section: Section) => {
        this.setState({
            currentSchedule: this.state.currentSchedule.filter(other => section !== other),
        });
    };
}
export default App;
