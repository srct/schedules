/**
 * util/CourseSection.ts
 *
 * Common object interface for all "Section"s.
 */
interface CourseSection {
    id: number;
    name: string;
    title: string;
    crn: string;
    instructor: string;
    location: string;
    days: string;
    startTime: string;
    endTime: string;
}

export default CourseSection;
