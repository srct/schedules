import * as React from 'react';
import { Button, Card, CardBody, CardTitle, Col, Row } from 'reactstrap';

require('../css/button-text-override.css');

const CourseSectionCard = () => (
    <Row className="justify-content-center my-5">
        <Col md="9">
            <Card>
                <CardBody>
                    <CardTitle className="mb-4">
                        <i className="fas fa-hashtag" /> 78212
                    </CardTitle>
                    <Row>
                        <Col md="6">
                            <div className="mb-4">
                                <h4>Senior Adv Design Project I</h4>
                                <p>CYSE 492 - 001</p>
                            </div>
                            <i className="fas fa-chalkboard-teacher fa-fw" /> Gino J Manzo
                            <br />
                            <i className="fas fa-clock fa-fw" /> Thursdays, 4:30 pm - 6:20 pm
                            <br />
                            <i className="fas fa-school fa-fw" /> James Buchanan Hall D023
                        </Col>
                        <Col md="6">
                            <Button color="primary" size="lg" block className="shadow-sm mt-3">
                                <i className="fas fa-plus-circle mr-2 fa-fw" /> Add to schedule
                            </Button>
                        </Col>
                    </Row>
                </CardBody>
            </Card>
        </Col>
    </Row>
);

export default CourseSectionCard;
