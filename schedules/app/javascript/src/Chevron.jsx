import React from 'react';

export default class Chevron extends React.Component {
    constructor(props) {
        super(props);
    }

    render() {
        const base = { display: 'block', textAlign: 'center' };
        return (
            <div>
                <div style={this.props.open ? { ...base } : { display: 'none' }}>
                    <p id="chevron-label" style={{ marginBottom: '4px', fontSize: '10px' }}>
                        Minimize
                    </p>
                    <i id="course-chevron" className="fas fa-chevron-up" />
                </div>

                <div style={this.props.open ? { display: 'none' } : { ...base }}>
                    <p id="chevron-label" style={{ marginBottom: '4px', fontSize: '10px' }}>
                        Expand
                    </p>
                    <i id="course-chevron" className="fas fa-chevron-down" />
                </div>
            </div>
        );
    }
}
