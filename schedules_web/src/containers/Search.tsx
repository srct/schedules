import { connect } from 'react-redux';
import { addSection } from '../actions/schedule/schedule.actions';
import { searchSections } from '../actions/search/search.actions';
import Search from '../components/Search';
import { State } from '../reducers';

const mapStateToProps = (state: State) => ({
    searchedSections: state.search.searchedSections,
});

export default connect(
    mapStateToProps,
    { searchSections, addSection }
)(Search);
