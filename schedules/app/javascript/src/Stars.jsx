import React from 'react';

export default class Stars extends React.Component {
    render() {
        return (
            <div className="star-rating">
                <div className="back-stars">
                    <i className="fas fa-star" aria-hidden="true" />
                    <i className="fas fa-star" aria-hidden="true" />
                    <i className="fas fa-star" aria-hidden="true" />
                    <i className="fas fa-star" aria-hidden="true" />
                    <i className="fas fa-star" aria-hidden="true" />

                    <div className="front-stars" style={{ width: `${this.props.percent}%` }}>
                        <i className="fa fa-star" aria-hidden="true" />
                        <i className="fa fa-star" aria-hidden="true" />
                        <i className="fa fa-star" aria-hidden="true" />
                        <i className="fa fa-star" aria-hidden="true" />
                        <i className="fa fa-star" aria-hidden="true" />
                    </div>
                </div>
            </div>
        );
    }
}
