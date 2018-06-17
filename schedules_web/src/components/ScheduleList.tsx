import * as React from 'react';
import { CourseSection } from '../util/CourseSection';

interface Props {
    courses: CourseSection[];
    selectCourseCallback?: (courseSection: CourseSection) => void;
}

export default class ScheduleList extends React.Component<Props, any> {
    constructor(props: Props) {
        super(props);
    }

    render() {
        return (
            <table>
                <tbody>
                    <tr>
                        <th>Course</th>
                        <th>course Name</th>
                        <th>CRN</th>
                        <th>Days</th>
                        <th>Instructor</th>
                        <th>Location</th>
                        <th>Time</th>
                        <th />
                    </tr>
                    {this.renderRowsForCourses(this.props.courses)}
                </tbody>
            </table>
        );
    }

    renderRowsForCourses(courses: CourseSection[]): JSX.Element[] {
        return courses.map(course => {
            return (
                <tr key={course.id}>
                    <td>{course.name}</td>
                    <td>{course.title}</td>
                    <td>{course.crn}</td>
                    <td>{course.days}</td>
                    <td>{course.instructor}</td>
                    <td>{course.location}</td>
                    <td>{[course.startTime, course.endTime].join(' - ')}</td>
                    {this.renderSelectCourseColumn(course.crn)}
                </tr>
            );
        });
    }

    renderSelectCourseColumn(rowCRN: string): JSX.Element {
        if (this.props.selectCourseCallback) {
            const courseWithCRN = this.getcourseWithCRN(rowCRN);
            return (
                <td>
                    <button onClick={() => this.props.selectCourseCallback(courseWithCRN)}>"Add to schedule"</button>
                </td>
            );
        } else {
            return <td />;
        }
    }

    getcourseWithCRN(crn: string): CourseSection {
        return this.props.courses.find(course => course.crn === crn);
    }
}
