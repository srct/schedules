import * as React from 'react';
import Section, { fetchSectionsWithCRN } from '../section';
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

        this.setState({ sections: [] });
    }

    searchForSections(crn: string) {
        fetchSectionsWithCRN(crn).then(sections => this.setState({ sections }));
    }

    render() {
        return (
            <div>
                <SearchBar onSearch={this.searchForSections} />
                <SectionList sections={this.state.sections} />
            </div>
        );
    }
}
