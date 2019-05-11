import React from 'react';
import Course from 'src/Course';

export default class CourseList extends React.Component {
    constructor(props) {
        super(props);
    }

    render() {
        return (
            <div>
                {this.props.courses.map(course => (
                    <Course key={course.id} {...course} />
                ))}
            </div>
        );
    }
}
