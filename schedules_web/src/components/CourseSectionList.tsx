import * as React from 'react';
import CourseSection from '../util/CourseSection';
import CourseSectionCard from './CourseSectionCard';

interface CourseSectionListProps {
    courseSections: CourseSection[];
    courseSectionAction: (courseSection: CourseSection) => void;
    courseSectionActionButtonText: string;
}

const CourseSectionList = ({
    courseSections,
    courseSectionAction,
    courseSectionActionButtonText,
}: CourseSectionListProps) => (
    <div>
        {courseSections.map(courseSection => (
            <CourseSectionCard
                key={courseSection.crn}
                courseSection={courseSection}
                courseSectionAction={courseSectionAction}
                courseSectionActionButtonText={courseSectionActionButtonText}
            />
        ))}
    </div>
);

export default CourseSectionList;
