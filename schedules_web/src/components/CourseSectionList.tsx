import * as React from 'react';
import CourseSection from '../util/CourseSection';
import CourseSectionCard from './CourseSectionCard';

interface CourseSectionListProps {
    courseSections: CourseSection[];
    courseSectionAction: (courseSection: CourseSection) => void;
    courseSectionActionButtonText: string;
    destructive?: boolean;
}

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
