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

        this.addSectionToCurrentSchedule = this.addSectionToCurrentSchedule.bind(this);
    }

    addSectionToCurrentSchedule(section: Section) {
        this.setState({
            currentSchedule: [...this.state.currentSchedule, section],
        });
    }

    render() {
        return (
            <div>
                <h1>Schedules</h1>
                <Search />
                <SectionList sections={this.state.currentSchedule} />
            </div>
        );
    }
}
export default App;
