import * as React from 'react';
import { Col, Row, UncontrolledTooltip } from 'reactstrap';

/**
 * Renders the app header with information and instructions for using Schedules.
 */
const Header = () => (
    <div>
        <Row className="justify-content-center my-5">
            <h1>
                <i className="far fa-calendar-alt" /> Schedules
            </h1>
            <div className="w-100 mb-3" />
            <Col md="6">
                <p>
                    An application to generate a schedule
                    {' ('}
                    <span style={{ textDecoration: 'underline' }} id="UncontrolledTooltipExample">
                        <i className="fas fa-question" />
                    </span>
                    <UncontrolledTooltip placement="right" target="UncontrolledTooltipExample">
                        Find your class' CRNs on Patriot Web under Student Services > Registration > Student Schedule
                    </UncontrolledTooltip>
                    {') '}
                    to place into your calendar populated with class times. Built and maintained by{' '}
                    <a href="https://srct.gmu.edu">Mason SRCT</a>.
                </p>
            </Col>
        </Row>
    </div>
);

export default Header;
