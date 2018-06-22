import * as React from 'react';
import { Col, Row } from 'reactstrap';

const Header = () => (
    <div>
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
