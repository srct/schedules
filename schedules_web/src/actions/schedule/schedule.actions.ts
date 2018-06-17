import { CourseSection } from '../../util/CourseSection';
import { ADD_ENTRY, REMOVE_ENTRY } from './schedule.action-types';

export interface ScheduleAction {
    type: string; // What action is to be performed
    entry: CourseSection; // The section that is being added/removed
}

/**
 * Add a section to the Schedule
 * @param section The section that is to be added
 */
export const addEntry = (entry: CourseSection): ScheduleAction => ({
    type: ADD_ENTRY,
    entry: entry,
});

/**
 * Remove a section from the Schedule
 * @param section The section that is to be removed
 */
export const removeEntry = (entry: CourseSection): ScheduleAction => ({
    type: REMOVE_ENTRY,
    entry: entry,
});
