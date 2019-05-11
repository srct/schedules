import React from 'react';

export default class InstructorCard extends React.Component {
    render() {
        const inst = this.props.instructor;
        return (
            <div className="card p-3">
                <span>
                    <i className="fas fa-chalkboard-teacher mr-2" />
                    <a href={`/instructors/${inst.id}`}>{this.props.instructor.name}</a>
                </span>
            </div>
        );
    }
}
