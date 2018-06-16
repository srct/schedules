import * as React from 'react';
import { connect } from 'react-redux';
import { removeSection } from '../actions/schedule/schedule.actions';
import SectionList from '../components/SectionList';
import { State } from '../reducers';
import { Section } from '../util/section';
import { downloadCalendar, ENDPOINTS, postData } from '../util/utilities';

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
