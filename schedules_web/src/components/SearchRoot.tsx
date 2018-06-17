import * as React from 'react';
import SectionList from '../components/ScheduleList';
import SearchBar from '../components/SearchBar';
import { CourseSection } from '../util/CourseSection';

interface SearchRootProps {
    searchResults: CourseSection[];
    searchCourses: (crn: string) => void;
    addEntry: (entry: CourseSection) => void;
}

const SearchRoot = ({ searchResults, searchCourses, addEntry }: SearchRootProps) => (
    <div>
        <SearchBar onSearch={searchCourses} />
        <SectionList courses={searchResults} selectCourseCallback={addEntry} />
    </div>
);

export default SearchRoot;
