import { connect } from 'react-redux';
import { addCourseSection } from '../actions/schedule/schedule.actions';
import { searchCourseSections } from '../actions/search/search.actions';
import SearchRoot from '../components/SearchRoot';
import { State } from '../reducers';

// Takes the current Redux state and returns objects which will be
// passed to the component as Props
const mapStateToProps = (state: State) => ({
    search: state.search,
});

// Pass mapStateToProps and other values to the component's props
export default connect(
    mapStateToProps,
    { searchCourseSections, addCourseSection }
)(SearchRoot);
