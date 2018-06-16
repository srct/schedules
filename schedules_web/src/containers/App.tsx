import * as React from 'react';
import { connect } from 'react-redux';
import { removeSection } from '../actions/schedule/schedule.actions';
import SectionList from '../components/SectionList';
import { State } from '../reducers';
import { Section } from '../util/section';
import { downloadCalendar, ENDPOINTS, postData } from '../util/utilities';
import Search from './Search';

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
                <h1 className="display-3">
                    <span className="fa-stack mr-3">
                        <i className="fas fa-circle fa-stack-2x" />
                        <i className="fas fa-flag fa-stack-1x fa-inverse" />
                    </span>
                    Schedules
                </h1>
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

/**
 * Take the current schedule in the store and map it to the <App /> component.
 * @param state The current Redux store state.
 */
const mapStateToProps = (state: State) => ({
    schedule: state.schedule,
});

/**
 * Ensure that the Redux state is passed into the component.
 */
export default connect(
    mapStateToProps,
    { removeSection }
)(App);
