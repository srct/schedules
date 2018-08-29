import * as React from 'react';
import CourseSection from '../util/CourseSection';
import ScheduleBadge from './ScheduleBadge';
import ApiService from '../util/ApiService';
import { downloadFile } from '../util/utilities';

interface ScheduleRootProps {
    schedule: CourseSection[];
    removeCourseSection: (courseSection: CourseSection) => any;
}

const generateSchedule = async (schedule: CourseSection[]) => {
    const crns = schedule.map(section => section.crn);
    ApiService.subscribeToCalendar(crns);
};

const ScheduleRoot = ({ schedule, removeCourseSection }: ScheduleRootProps) => (
    <div>
        <ScheduleBadge
            schedule={schedule}
            removeCourseSection={removeCourseSection}
            generateCalendar={generateSchedule}
        />
        {/* <ScheduleList courses={schedule} selectCourseCallback={removeCourseSection} /> */}
        {/* <button onClick={generateSchedule}>Generate Schedule</button> */}
    </div>
);

export default ScheduleRoot;
