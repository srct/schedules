import * as React from 'react';
import Section from '../section';

interface Props {
    sections: Section[];
    addToScheduleCallback?: (section: Section) => void;
}

export default class SectionList extends React.Component<Props, any> {
    render() {
        return (
            <table>
                <tr>
                    <th>Course</th>
                    <th>Section Name</th>
                    <th>CRN</th>
                    <th>Days</th>
                    <th>Instructor</th>
                    <th>Location</th>
                    <th>Time</th>
                </tr>
                {this.renderRowsForSections(this.state.sections)}
            </table>
        );
    }

    renderRowsForSections(sections: Section[]): JSX.Element[] {
        return sections.map(section => {
            return (
                <tr>
                    <td>{section.name}</td>
                    <td>{section.title}</td>
                    <td>{section.crn}</td>
                    <td>{section.days}</td>
                    <td>{section.instructor}</td>
                    <td>{section.location}</td>
                    <td>{[section.startTime, section.endTime].join(' - ')}</td>
                </tr>
            );
        });
    }
}
