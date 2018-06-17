import { connect } from 'react-redux';
import { removeCourseSection } from '../actions/schedule/schedule.actions';
import ScheduleRoot from '../components/ScheduleRoot';
import { State } from '../reducers';

const mapStateToProps = (state: State) => ({
    schedule: state.schedule,
});

export default connect(
    mapStateToProps,
    { removeCourseSection }
)(ScheduleRoot);
