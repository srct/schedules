import * as React from 'react';
import { Row } from 'reactstrap';
import CourseSection from '../util/CourseSection';

interface ScheduleBadgeProps {
    schedule: CourseSection[];
}

const ScheduleBadge = ({ schedule }: ScheduleBadgeProps) => (
    <Row className="justify-content-end my-5 px-3">
        <span className="fa-stack fa-3x has-badge" data-count={schedule.length}>
            <i className="fa fas fa-shopping-bag fa-stack-1x" />
        </span>
    </Row>
);

export default ScheduleBadge;
