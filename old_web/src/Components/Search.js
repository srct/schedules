import React, { Component } from 'react';
import SectionsList from './SectionsList.js';

export default class Search extends Component {
    constructor(props) {
        super(props);
        this.state = {
            searchTerm: '',
            sections: [],
        };

        this.handleChange = this.handleChange.bind(this);
        this.handleSubmit = this.handleSubmit.bind(this);
    }

    handleChange(event) {
        this.setState({
            searchTerm: event.target.value,
        });
    }

    handleSubmit(event) {
        fetch(`http://localhost:3001/api/search?crn=${this.state.searchTerm}`)
            .then(response => response.json())
            .then(section => {
                if (section !== null) {
                    this.setState({ sections: [section] });
                }
            });
        event.preventDefault();
    }

    render() {
        return (
            <div>
                <form onSubmit={this.handleSubmit}>
                    <input
                        type="text"
                        placeholder="Enter CRN..."
                        value={this.state.value}
                        onChange={this.handleChange}
                    />
                    <input type="submit" value="Search" />
                </form>
                <SectionsList
                    title="Search results"
                    sections={this.state.sections}
                    addToSchedule={this.props.addToSchedule}
                />
            </div>
        );
    }
}
