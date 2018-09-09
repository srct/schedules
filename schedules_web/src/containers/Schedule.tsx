import { connect } from 'react-redux';
import { removeCourseSection } from '../actions/schedule/schedule.actions';
import ScheduleRoot from '../components/ScheduleRoot';
import { State } from '../reducers';
import CourseSection from '../util/CourseSection';
import ApiService from '../util/ApiService';
import { downloadFile } from '../util/utilities';

// Takes the current Redux state and returns objects which will be
// passed to the component as Props
const mapStateToProps = (state: State) => {
    const crns = state.schedule ? state.schedule.map(section => section.crn) : [];
    return {
        schedule: state.schedule,
        generateCalendarUrl: () => ApiService.generateCalendarUrl(crns),
        openCalendarAsWebcal: () => ApiService.openCalendarAsWebcal(crns),
        downloadIcs: async () => {
            const icsText = await ApiService.fetchICal(crns);
            downloadFile(icsText, 'GMU Fall 2018.ics');
        },
    };
};

// Pass mapStateToProps and other values to the component's props
export default connect(
    mapStateToProps,
    { removeCourseSection }
)(ScheduleRoot);
