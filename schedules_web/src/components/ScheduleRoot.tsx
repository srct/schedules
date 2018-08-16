import * as React from 'react';
import CourseSection from '../util/CourseSection';
import ScheduleBadge from './ScheduleBadge';
import ApiService from '../util/ApiService';
import { downloadFile } from '../util/utilities';

interface ScheduleRootProps {
    schedule: CourseSection[];
    removeCourseSection: (courseSection: CourseSection) => any;
}

const generateSchedule = async (schedule: CourseSection[]): Promise<void> => {
    const crns = schedule.map(section => section.crn);
    const calendar = await ApiService.generateCalendar(crns);
    downloadFile(calendar, 'GMU Fall 2018.ics');
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
