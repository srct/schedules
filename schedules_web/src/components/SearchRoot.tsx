import * as React from 'react';
import SearchBar from '../components/SearchBar';
import CourseSection from '../util/CourseSection';

interface SearchRootProps {
    searchResults: CourseSection[];
    searchCourseSections: (crn: string) => void;
    addCourseSection: (courseSectionToAdd: CourseSection) => void;
}

const SearchRoot = ({ searchResults, searchCourseSections, addCourseSection }: SearchRootProps) => (
    <div>
        <SearchBar onSearch={searchCourseSections} />
        {/* <SectionList courses={searchResults} selectCourseCallback={addCourseSection} /> */}
    </div>
);

export default SearchRoot;
