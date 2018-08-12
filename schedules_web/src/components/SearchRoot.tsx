import * as React from 'react';
import SearchBar from '../components/SearchBar';
import CourseSection from '../util/CourseSection';
import CourseSectionList from './CourseSectionList';

interface SearchRootProps {
    searchResults: CourseSection[];
    searchCourseSections: (crn: string) => void;
    addCourseSection: (courseSectionToAdd: CourseSection) => void;
}

const SearchRoot = ({ searchResults, searchCourseSections, addCourseSection }: SearchRootProps) => (
    <div>
        <SearchBar onSearch={searchCourseSections} />
        <CourseSectionList
            courseSectionActionButtonText="Add to schedule"
            courseSections={searchResults}
            courseSectionAction={addCourseSection}
        />
    </div>
);

export default SearchRoot;
