import * as React from 'react';
import CourseSection from '../util/CourseSection';
import ScheduleBadge from './ScheduleBadge';

interface SearchRootProps {
    schedule: CourseSection[];
    removeCourseSection: (courseSection: CourseSection) => any;
}

// const generateSchedule = (schedule: CourseEntry[]): void => {
//     const crns = schedule.map(entry => entry.crn);

//     postData(ENDPOINTS.generateCalendar, crns)
//         .then(response => response.text())
//         .then(icalText => downloadCalendar(icalText));
// };

const ScheduleRoot = ({ schedule, removeCourseSection }: SearchRootProps) => (
    <div>
        <ScheduleBadge schedule={schedule} removeCourseSection={removeCourseSection} />
        {/* <ScheduleList courses={schedule} selectCourseCallback={removeCourseSection} /> */}
        {/* <button onClick={generateSchedule}>Generate Schedule</button> */}
    </div>
);

export default ScheduleRoot;
