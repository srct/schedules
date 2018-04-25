import * as React from 'react';
import Section from '../section';

interface Props {
    sections: Section[];
    selectSectionCallback?: (section: Section) => void;
}

export default class SectionList extends React.Component<Props, any> {
    constructor(props: Props) {
        super(props);

        this.renderSelectSectionColumn = this.renderSelectSectionColumn.bind(this);
        this.getSectionWithCRN = this.getSectionWithCRN.bind(this);
    }
    render() {
        return (
            <table>
                <tbody>
                    <tr>
                        <th>Course</th>
                        <th>Section Name</th>
                        <th>CRN</th>
                        <th>Days</th>
                        <th>Instructor</th>
                        <th>Location</th>
                        <th>Time</th>
                        <th />
                    </tr>
                    {this.renderRowsForSections(this.props.sections)}
                </tbody>
            </table>
        );
    }

    renderRowsForSections(sections: Section[]): JSX.Element[] {
        return sections.map(section => {
            return (
                <tr key={section.id}>
                    <td>{section.name}</td>
                    <td>{section.title}</td>
                    <td>{section.crn}</td>
                    <td>{section.days}</td>
                    <td>{section.instructor}</td>
                    <td>{section.location}</td>
                    <td>{[section.startTime, section.endTime].join(' - ')}</td>
                    {this.renderSelectSectionColumn(section.crn)}
                </tr>
            );
        });
    }

    renderSelectSectionColumn(rowCRN: string): JSX.Element {
        if (this.props.selectSectionCallback) {
            const sectionWithCRN = this.getSectionWithCRN(rowCRN);
            return (
                <td>
                    <button onClick={() => this.props.selectSectionCallback(sectionWithCRN)}>Add to schedule</button>
                </td>
            );
        } else {
            return <td />;
        }
    }

    getSectionWithCRN(crn: string): Section {
        return this.props.sections.find(section => section.crn === crn);
    }
}
