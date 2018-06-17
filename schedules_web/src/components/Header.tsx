import * as React from 'react';
import { Col, Row } from 'reactstrap';

require('../css/iconbadge.css');

const Header = () => (
    <div>
        {/* TODO Extract into its own components with state management. */}
        <Row className="justify-content-end my-5 px-3">
            <span className="fa-stack fa-3x has-badge" data-count="0">
                <i className="fa fas fa-shopping-bag fa-stack-1x" />
            </span>
        </Row>
        <Row className="justify-content-center my-5">
            <h1>
                <i className="far fa-calendar-alt" /> Schedules
            </h1>
            <div className="w-100 mb-3" />
            <Col md="6">
                <p>
                    This is a catchy slogan that concisely describes the site with a lot of words that looks good on
                    mobile ahh.
                </p>
            </Col>
        </Row>
    </div>
);

export default Header;
