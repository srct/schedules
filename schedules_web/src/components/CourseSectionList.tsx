import * as React from 'react';
import CourseSection from '../util/CourseSection';
import CourseSectionCard from './CourseSectionCard';

interface CourseSectionListProps {
    courseSections: CourseSection[];
    courseSectionAction: (courseSection: CourseSection) => void;
    courseSectionActionButtonText: string;
    destructive?: boolean;
}

/**
 * Renders a list of CourseSectionCards for every course section in
 * the current schedule.
 */
const CourseSectionList = ({
    courseSections,
    courseSectionAction,
    courseSectionActionButtonText,
    destructive,
}: CourseSectionListProps) => (
    <div>
        {courseSections.map(courseSection => (
            <CourseSectionCard
                key={courseSection.crn}
                courseSection={courseSection}
                courseSectionAction={courseSectionAction}
                courseSectionActionButtonText={courseSectionActionButtonText}
                destructive={destructive}
            />
        ))}
    </div>
);

export default CourseSectionList;
