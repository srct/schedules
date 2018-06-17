import * as React from 'react';
import SearchBar from '../components/SearchBar';
import SectionList from '../components/ScheduleList';
import { CourseEntry } from '../util/CourseEntry';

interface SearchRootProps {
    searchResults: CourseEntry[];
    searchCourses: (crn: string) => void;
    addEntry: (entry: CourseEntry) => void;
}

const SearchRoot = ({ searchResults, searchCourses, addEntry }: SearchRootProps) => (
    <div>
        <SearchBar onSearch={searchCourses} />
        <SectionList courses={searchResults} selectCourseCallback={addEntry} />
    </div>
);

export default SearchRoot;
