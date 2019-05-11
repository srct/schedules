import React from 'react';
import Chevron from 'src/Chevron';
import Section from 'src/Section';

export default class SectionList extends React.Component {
    constructor(props) {
        super(props);
    }

    render() {
        return (
            <div>
                {this.props.expandable ? <Chevron open={this.props.expanded} /> : null}
                {this.props.expanded ? (
                    <div className="d-flex list-group list-group-flush sections">
                        {this.props.sections.map(section => (
                            <Section key={section.id} onClick={this.props.onClick} {...section} />
                        ))}
                    </div>
                ) : (
                    <div />
                )}
            </div>
        );
    }
}
