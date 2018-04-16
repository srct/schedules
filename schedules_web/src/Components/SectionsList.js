import React, { Component } from 'react';

export default class SectionsList extends Component {
    constructor(props) {
        super(props);

        this.getRowsForSections = this.getRowsForSections.bind(this);
        this.getRowForSection = this.getRowForSection.bind(this);
        this.getLastColumn = this.getLastColumn.bind(this);
    }

    getRowsForSections() {
        return this.props.sections.map(section => {
            return this.getRowForSection(section);
        });
    }

    getRowForSection(section) {
        return (
            <tr key={section.id}>
                <td>{section.name}</td>
                <td>{section.title}</td>
                <td>{section.crn}</td>
                <td>{section.instructor}</td>
                <td>{section.location}</td>
                <td>{section.days}</td>
                <td>{[section.start_time, section.end_time].join(' - ')}</td>

                {this.getLastColumn(section)}
            </tr>
        );
    }

    getLastColumn(section) {
        if (this.props.addToSchedule) {
            return (
                <td>
                    <button onClick={e => this.props.addToSchedule(section)}>Add to schedule</button>
                </td>
            );
        } else {
            return <td />;
        }
    }

    render() {
        return (
            <div>
                <h2>{this.props.title}</h2>
                <table>
                    <tbody>
                        <tr>
                            <th>Name</th>
                            <th>Title</th>
                            <th>CRN</th>
                            <th>Professor</th>
                            <th>Location</th>
                            <th>Days</th>
                            <th>Times</th>
                            <th />
                        </tr>
                        {this.getRowsForSections()}
                    </tbody>
                </table>
            </div>
        );
    }
}
