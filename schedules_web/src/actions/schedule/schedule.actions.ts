import { CourseSection } from '../../util/CourseSection';
import { ADD_COURSE_SECTION, REMOVE_COURSE_SECTION } from './schedule.action-types';

export interface ScheduleAction {
    type: string; // What action is to be performed
    courseSection: CourseSection; // The section that is being added/removed
}

/**
 * Add a section to the Schedule
 * @param section The section that is to be added
 */
export const addCourseSection = (courseSectionToAdd: CourseSection): ScheduleAction => ({
    type: ADD_COURSE_SECTION,
    courseSection: courseSectionToAdd,
});

/**
 * Remove a section from the Schedule
 * @param section The section that is to be removed
 */
export const removeCourseSection = (courseSectionToRemove: CourseSection): ScheduleAction => ({
    type: REMOVE_COURSE_SECTION,
    courseSection: courseSectionToRemove,
});
