import * as React from 'react';
import { Button, Card, CardBody, CardTitle, Collapse, Row } from 'reactstrap';
import CourseSection from '../util/CourseSection';
import CourseSectionList from './CourseSectionList';

interface ScheduleBadgeProps {
    schedule: CourseSection[];
    generateCalendar: (schedule: CourseSection[]) => Promise<void>;
    removeCourseSection: (courseSection: CourseSection) => void;
}

interface State {
    collapse: boolean;
}

require('../css/icon-badge.css');

class ScheduleBadge extends React.Component<ScheduleBadgeProps, State> {
    constructor(props: ScheduleBadgeProps) {
        super(props);

        this.state = { collapse: false };
    }

    toggle = () => this.setState({ collapse: !this.state.collapse });

    render() {
        const { schedule, removeCourseSection, generateCalendar } = this.props;
        return (
            <div>
                <Row className="justify-content-end">
                    <Button
                        children={
                            <span className="fa-stack fa-3x has-badge" data-count={this.props.schedule.length}>
                                <i className="fa fas fa-shopping-bag fa-stack-1x" />
                            </span>
                        }
                        onClick={this.toggle}
                        id="cart"
                    />
                </Row>

                <Collapse isOpen={this.state.collapse}>
                    <Card>
                        <CardBody>
                            <Row className="my-3">
                                <h1 className="px-5">Your Schedule</h1>

                                <Button className="ml-auto px-5" outline color="danger" onClick={this.toggle}>
                                    Close
                                </Button>
                            </Row>

                            <CourseSectionList
                                courseSections={schedule}
                                courseSectionAction={removeCourseSection}
                                courseSectionActionButtonText="Remove from schedule"
                                destructive
                            />
                            <Row className="justify-content-center">
                                <Button
                                    size="sm"
                                    outline
                                    color="primary"
                                    onClick={() => generateCalendar(schedule)}
                                    disabled={schedule.length === 0}>
                                    Generate
                                </Button>
                            </Row>
                        </CardBody>
                    </Card>
                </Collapse>
            </div>
        );
    }
}

export default ScheduleBadge;