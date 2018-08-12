import * as React from 'react';
import { Button, Card, CardBody, CardTitle, Col, Row } from 'reactstrap';
import CourseSection from '../util/CourseSection';

interface CourseSectionCardProps {
    courseSectionAction: (courseSection: CourseSection) => void;
    courseSection: CourseSection;
    courseSectionActionButtonText: string;
    destructive?: boolean;
}

require('../css/button-text-override.css');

const CourseSectionCard = ({
    courseSection,
    courseSectionAction,
    courseSectionActionButtonText,
    destructive,
}: CourseSectionCardProps) => (
    <Row className="justify-content-center">
        <Col md="9">
            <Card>
                <CardBody>
                    <CardTitle className="mb-4">
                        <i className="fas fa-hashtag" /> {courseSection.crn}
                    </CardTitle>
                    <Row>
                        <Col md="6">
                            <div className="mb-4">
                                <h4>{courseSection.title}</h4>
                                <p>{courseSection.name}</p>
                            </div>
                            <i className="fas fa-chalkboard-teacher fa-fw" /> {courseSection.instructor}
                            <br />
                            <i className="fas fa-clock fa-fw" /> {courseSection.days}, {courseSection.startTime} -{' '}
                            {courseSection.endTime}
                            <br />
                            <i className="fas fa-school fa-fw" /> {courseSection.location}
                        </Col>
                        <Col md="6">
                            <Button
                                onClick={() => courseSectionAction(courseSection)}
                                color={destructive ? 'danger' : 'primary'}
                                size="lg"
                                block
                                className="shadow-sm mt-3">
                                <i className={`fas fa-${destructive ? 'minus' : 'plus'}-circle mr-2 fa-fw`} />{' '}
                                {courseSectionActionButtonText}
                            </Button>
                        </Col>
                    </Row>
                </CardBody>
            </Card>
        </Col>
    </Row>
);

export default CourseSectionCard;
