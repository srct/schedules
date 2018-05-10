import * as React from 'react';
import Section, { fetchSectionWithCRN } from '../section';
import SearchBar from './SearchBar';
import SectionList from './SectionList';

interface Props {
    addSearchResultCallback?: (section: Section) => void;
}

interface State {
    sections: Section[];
}

export default class Search extends React.Component<Props, State> {
    constructor(props: Props) {
        super(props);
        this.state = { sections: [] };
    }

    render() {
        return (
            <div>
                <SearchBar onSearch={this.searchForSections} />
                <SectionList
                    sections={this.state.sections}
                    buttonText="Add to schedule"
                    selectSectionCallback={this.props.addSearchResultCallback}
                />
            </div>
        );
    }

    searchForSections = (crn: string) => {
        fetchSectionWithCRN(crn).then(section => this.setState({ sections: [section] }));
    };
}
