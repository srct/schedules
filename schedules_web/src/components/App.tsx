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
    }

    addSectionToCurrentScheduleIfUnique(section: Section) {
        if (!this.state.currentSchedule.find(sectionInSchedule => section === sectionInSchedule)) {
            this.setState({
                currentSchedule: [...this.state.currentSchedule, section],
            });
        }
    }

    render() {
        return (
            <div>
                <h1>Schedules</h1>
                <Search addSearchResultCallback={this.addSectionToCurrentScheduleIfUnique} />
                <SectionList sections={this.state.currentSchedule} />
            </div>
        );
    }
}
export default App;
