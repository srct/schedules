import * as React from 'react';
import { Button, Card, CardBody, CardTitle, Collapse, Row } from 'reactstrap';
import CourseSection from '../util/CourseSection';
import CourseSectionCard from './CourseSectionCard';

interface ScheduleBadgeProps {
    schedule: CourseSection[];
}

interface State {
    collapse: boolean;
}

require('../css/icon-badge.css');

class ScheduleBadge extends React.Component<ScheduleBadgeProps, State> {
    constructor(props: ScheduleBadgeProps) {
        super(props);
        this.toggle = this.toggle.bind(this);
        this.state = { collapse: false };
    }

    toggle() {
        this.setState({ collapse: !this.state.collapse });
    }
    render() {
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
                        <CardTitle className="mt-3">
                            <Row className="justify-content-center">
                                <Button size="sm" outline color="danger" className="ml-5" onClick={this.toggle}>
                                    Close
                                </Button>
                                <h1 className="pl-5">Your Schedule</h1>
                                <Button size="sm" outline color="primary" className="mr-5">
                                    Generate Schedule
                                </Button>
                            </Row>
                        </CardTitle>
                        <legend />
                        <CardBody>
                            <CourseSectionCard />
                            <CourseSectionCard />
                            <CourseSectionCard />
                            <CourseSectionCard />
                            <CourseSectionCard />
                        </CardBody>
                    </Card>
                </Collapse>
            </div>
        );
    }
}

export default ScheduleBadge;
