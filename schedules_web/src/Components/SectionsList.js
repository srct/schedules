import React, { Component } from 'react';

export default class SectionsList extends Component {
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
                        {this.props.sections.map(section => {
                            return (
                                <tr key={section.id}>
                                    <td>{section.name}</td>
                                    <td>{section.title}</td>
                                    <td>{section.crn}</td>
                                    <td>{section.instructor}</td>
                                    <td>{section.location}</td>
                                    <td>{section.days}</td>
                                    <td>{[section.start_time, section.end_time].join(' - ')}</td>

                                    {/* If the addToSchedule prop exists, include an
                                    add to schedule button to the last column */}
                                    {this.props.addToSchedule ? (
                                        <td>
                                            <button onClick={e => this.props.addToSchedule(e, section)}>
                                                Add to schedule
                                            </button>
                                        </td>
                                    ) : (
                                        <td />
                                    )}
                                </tr>
                            );
                        })}
                    </tbody>
                </table>
            </div>
        );
    }
}
