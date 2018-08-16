import * as React from 'react';
import SearchBar from '../components/SearchBar';
import CourseSection from '../util/CourseSection';
import CourseSectionList from './CourseSectionList';
import { Row, Col, Alert } from 'reactstrap';
import { SearchState } from '../reducers/search.reducer';

interface SearchRootProps {
    search: SearchState;
    searchCourseSections: (crn: string) => void;
    addCourseSection: (courseSectionToAdd: CourseSection) => void;
}

const SearchRoot = ({ search, searchCourseSections, addCourseSection }: SearchRootProps) => (
    <div>
        <SearchBar onSearch={searchCourseSections} />
        {search.error !== '' ? (
            <Error />
        ) : (
            <CourseSectionList
                courseSectionActionButtonText="Add to schedule"
                courseSections={search.courseSections}
                courseSectionAction={addCourseSection}
            />
        )}
    </div>
);

const Error = () => (
    <Row className="justify-content-center">
        <Col md="8">
            <Alert color="danger">Could not find course section with the given CRN.</Alert>
        </Col>
    </Row>
);

export default SearchRoot;
