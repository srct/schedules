import { connect } from 'react-redux';
import { addCourseSection } from '../actions/schedule/schedule.actions';
import { searchCourseSections } from '../actions/search/search.actions';
import SearchRoot from '../components/SearchRoot';
import { State } from '../reducers';

const mapStateToProps = (state: State) => ({
    search: state.search,
});

export default connect(
    mapStateToProps,
    { searchCourseSections, addCourseSection }
)(SearchRoot);
