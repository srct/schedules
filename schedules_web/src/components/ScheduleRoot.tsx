import * as React from 'react';
import { CourseSection } from '../util/CourseSection';
import ScheduleList from './ScheduleList';

interface SearchRootProps {
    schedule: CourseSection[];
    removeEntry: (CourseEntry: CourseSection) => any;
}

// const generateSchedule = (schedule: CourseEntry[]): void => {
//     const crns = schedule.map(entry => entry.crn);

//     postData(ENDPOINTS.generateCalendar, crns)
//         .then(response => response.text())
//         .then(icalText => downloadCalendar(icalText));
// };

const ScheduleRoot = ({ schedule, removeEntry }: SearchRootProps) => (
    <div>
        <ScheduleList courses={schedule} selectCourseCallback={removeEntry} />
        {/* <button onClick={generateSchedule}>Generate Schedule</button> */}
    </div>
);

export default ScheduleRoot;
