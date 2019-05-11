import React from 'react';
import InstructorCard from 'src/InstructorCard';

export default class InstructorList extends React.Component {
    render() {
        return <div>{this.props.instructors && this.props.instructors.map(i => <InstructorCard instructor={i} />)}</div>;
    }
}
