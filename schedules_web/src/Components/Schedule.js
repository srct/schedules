import React, { Component } from 'react';
import SectionsList from './SectionsList.js';

export default class Schedule extends Component {
    render() {
        return (
            <div>
                <SectionsList
                    title="Your schedule"
                    sections={this.props.sections}
                />
            </div>
        );
    }
}
