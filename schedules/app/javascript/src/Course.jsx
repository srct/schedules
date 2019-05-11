import React from 'react';

import SectionList from 'src/SectionList';

export default class Course extends React.Component {
    constructor(props) {
        super(props);
        this.state = { expanded: false, sections: [] };
    }

    async onClick() {
        if (this.state.sections.length === 0) {
            const resp = await fetch(`/api/course_sections?course_id=${this.props.id}`);
            const json = await resp.json();
            this.setState({ sections: json });
        }
        this.setState({ expanded: !this.state.expanded });
    }

    prereqs = () => {
        if (this.props.prereqs) {
            const [first, rest] = this.props.prereqs.split(':');
            const [reqs, note] = rest.split('.');
            return (
                <p>
                    <strong>{first}</strong>
                    {reqs}
                    <sub>{note}</sub>
                </p>
            );
        }
        return <div />;
    };

    // <% first, rest = course.prereqs.split(':') %>
    // 	    <% prereqs, note = rest.split('.') %>
    // 	    <p><strong><%= first %>:</strong> <%= prereqs %> <sub><%= note %></sub></p>
    render() {
        const { id, subject, course_number, title, credits, description, url } = this.props;

        return (
            <div className="card course-card" onClick={() => this.onClick()}>
                <div className="card-header">
                    <div className="row">
                        <div className="col">
                            <a href={url}>
                                <h4 className="title">{`${subject} ${course_number}`}</h4>
                            </a>
                        </div>
                    </div>
                    <div className="d-md-flex justify-content-between">
                        <h5>
                            <em>{title}</em>
                        </h5>
                        <div className="attr-list justify-content-start">
                            <div className="attr">
                                <div className="icon">
                                    <i className="fa fa-book" />
                                </div>
                                {credits} credits
                            </div>
                        </div>
                    </div>
                </div>
                <div className="card-body">
                    <p>{description}</p>
                    {this.prereqs()}
                    <div className="list-group list-group-flush sections" style={{ display: 'none' }} />
                    <SectionList {...this.state} expandable={true} />
                </div>
            </div>
        );
    }
}
