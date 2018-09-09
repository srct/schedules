import * as React from 'react';
import { Button, Card, CardBody, CardTitle, Collapse, Row } from 'reactstrap';
import CourseSection from '../util/CourseSection';
import CourseSectionList from './CourseSectionList';
import ExportModal from './ExportModal';

interface ScheduleBadgeProps {
    schedule: CourseSection[];
    removeCourseSection: (courseSection: CourseSection) => void;
    generateCalendarUrl: () => string;
    openCalendarAsWebcal: () => void;
    downloadIcs: () => Promise<void>;
}

interface State {
    collapse: boolean;
    isModalOpen: boolean;
}

require('../css/icon-badge.css');

/**
 * Contains all functionality for viewing your schedule, such as the
 * shopping cart, list of course sections, and the generate calendar modal.
 *
 * TODO: Split this component up
 */
class ScheduleBadge extends React.Component<ScheduleBadgeProps, State> {
    constructor(props: ScheduleBadgeProps) {
        super(props);

        this.state = { collapse: false, isModalOpen: false };
    }

    toggleCollapse = () => this.setState({ collapse: !this.state.collapse });
    toggleModal = () => this.setState({ isModalOpen: !this.state.isModalOpen });

    render() {
        const { schedule, removeCourseSection, generateCalendarUrl, openCalendarAsWebcal, downloadIcs } = this.props;
        return (
            <div>
                <Row className="justify-content-end">
                    <Button
                        children={
                            <span className="fa-stack fa-3x has-badge" data-count={this.props.schedule.length}>
                                <i className="fa fas fa-shopping-bag fa-stack-1x" />
                            </span>
                        }
                        onClick={this.toggleCollapse}
                        id="cart"
                    />
                </Row>

                <Collapse isOpen={this.state.collapse}>
                    <Card>
                        <CardBody>
                            <Row className="my-3">
                                <h1 className="px-5">Your Schedule</h1>

                                <Button className="ml-auto px-5" outline color="danger" onClick={this.toggleCollapse}>
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
                                    onClick={this.toggleModal}
                                    disabled={schedule.length === 0}>
                                    Generate
                                </Button>
                            </Row>
                        </CardBody>
                    </Card>
                </Collapse>
                <ExportModal
                    isModalOpen={this.state.isModalOpen}
                    toggleModal={this.toggleModal}
                    calendarUrl={generateCalendarUrl}
                    openCalendarAsWebcal={openCalendarAsWebcal}
                    downloadIcs={downloadIcs}
                />
            </div>
        );
    }
}

export default ScheduleBadge;
