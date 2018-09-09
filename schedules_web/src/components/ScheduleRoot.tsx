import * as React from 'react';
import CourseSection from '../util/CourseSection';
import ScheduleBadge from './ScheduleBadge';

interface ScheduleRootProps {
    schedule: CourseSection[];
    removeCourseSection: (courseSection: CourseSection) => any;
    generateCalendarUrl: () => string;
    openCalendarAsWebcal: () => void;
    downloadIcs: () => Promise<void>;
}

const ScheduleRoot = ({
    schedule,
    removeCourseSection,
    generateCalendarUrl,
    openCalendarAsWebcal,
    downloadIcs,
}: ScheduleRootProps) => (
    <div>
        <ScheduleBadge
            schedule={schedule}
            removeCourseSection={removeCourseSection}
            generateCalendarUrl={generateCalendarUrl}
            openCalendarAsWebcal={openCalendarAsWebcal}
            downloadIcs={downloadIcs}
        />
        {/* <ScheduleList courses={schedule} selectCourseCallback={removeCourseSection} /> */}
        {/* <button onClick={generateSchedule}>Generate Schedule</button> */}
    </div>
);

export default ScheduleRoot;
