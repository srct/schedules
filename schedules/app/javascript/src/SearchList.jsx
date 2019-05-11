import React from 'react';
import CourseList from 'src/CourseList';
import InstructorList from 'src/InstructorList';

export default class SearchList extends React.Component {
    render() {
        return (
            <div>
                <InstructorList instructors={this.props.instructors} />
                <CourseList courses={this.props.courses} />
            </div>
        );
    }
}
