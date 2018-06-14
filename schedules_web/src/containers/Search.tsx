import * as React from 'react';
import { connect } from 'react-redux';
import { addSection } from '../actions/schedule/schedule.actions';
import { searchSections } from '../actions/search/search.actions';
import SearchBar from '../components/SearchBar';
import SectionList from '../components/SectionList';
import { State } from '../reducers';
import { Section } from '../ts/section';

interface SearchProps {
    searchedSections: Section[];
    searchSections: (crn: string) => any;
    addSection: (section: Section) => any;
}

class Search extends React.Component<SearchProps> {
    constructor(props: SearchProps) {
        super(props);
    }

    render() {
        return (
            <div>
                <SearchBar onSearch={this.props.searchSections} />
                <SectionList
                    sections={this.props.searchedSections}
                    buttonText="Add to schedule"
                    selectSectionCallback={this.props.addSection}
                />
            </div>
        );
    }
}

const mapStateToProps = (state: State) => ({
    searchedSections: state.search.searchedSections,
});

export default connect(
    mapStateToProps,
    { searchSections, addSection }
)(Search);
