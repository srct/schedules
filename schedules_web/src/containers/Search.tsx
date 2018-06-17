import { connect } from 'react-redux';
import { addEntry } from '../actions/schedule/schedule.actions';
import { searchCourses } from '../actions/search/search.actions';
import SearchRoot from '../components/SearchRoot';
import { State } from '../reducers';

const mapStateToProps = (state: State) => ({
    searchResults: state.searchResults,
});

export default connect(
    mapStateToProps,
    { searchCourses, addEntry }
)(SearchRoot);
