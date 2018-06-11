import * as React from 'react';
import { Section } from '../ts/section';
import { downloadCalendar, ENDPOINTS, postData } from '../ts/utilities';
import Search from './Search';
import SectionList from '../components/SectionList';
import { connect } from 'react-redux';
import {State} from '../reducers';
import { removeSection } from '../actions/schedule/schedule.actions';

interface AppProps {
    schedule: Section[];
    removeSection: (section: Section) => any;
}

class App extends React.Component<AppProps> {
    constructor(props: AppProps) {
        super(props);
    }

    render() {
        return (
            <div>
                <h1>Schedules</h1>
                <h2>Search</h2>
                <Search />
                <h2>Your schedule</h2>
                <SectionList
                    sections={this.props.schedule}
                    buttonText="Remove from schedule"
                    selectSectionCallback={this.props.removeSection}
                />
                <button onClick={this.generateSchedule}>Generate Schedule</button>
            </div>
        );
    }

    // TODO: Only view logic should be in the component.
    generateSchedule = () => {
        const crns = this.props.schedule.map(section => section.crn);

        postData(ENDPOINTS.generateCalendar, crns)
            .then(response => response.text())
            .then(icalText => downloadCalendar(icalText));
    };
}

const mapStateToProps = (state: State) => ({
    schedule: state.schedule
});

export default connect(mapStateToProps, {
    removeSection
})(App);