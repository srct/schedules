import { connect } from 'react-redux';
import { addEntry, removeEntry } from '../actions/schedule/schedule.actions';
import ScheduleRoot from '../components/ScheduleRoot';
import { State } from '../reducers';

const mapStateToProps = (state: State) => ({
    schedule: state.schedule,
});

export default connect(
    mapStateToProps,
    { addEntry, removeEntry }
)(ScheduleRoot);
