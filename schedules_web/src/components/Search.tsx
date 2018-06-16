import * as React from 'react';
import SearchBar from '../components/SearchBar';
import SectionList from '../components/SectionList';
import { Section } from '../util/section';

interface SearchProps {
    searchedSections: Section[];
    searchSections: (crn: string) => any;
    addSection: (section: Section) => any;
}

const Search = ({ searchedSections, searchSections, addSection }: SearchProps) => (
    <div>
        <SearchBar onSearch={searchSections} />
        <SectionList sections={searchedSections} buttonText="Add to schedule" selectSectionCallback={addSection} />
    </div>
);

export default Search;
