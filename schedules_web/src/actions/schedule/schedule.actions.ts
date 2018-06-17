import { CourseEntry } from '../../util/CourseEntry';
import { ADD_ENTRY, REMOVE_ENTRY } from './schedule.action-types';

export interface ScheduleAction {
    type: string; // What action is to be performed
    entry: CourseEntry; // The section that is being added/removed
}

/**
 * Add a section to the Schedule
 * @param section The section that is to be added
 */
export const addEntry = (entry: CourseEntry): ScheduleAction => ({
    type: ADD_ENTRY,
    entry: entry,
});

/**
 * Remove a section from the Schedule
 * @param section The section that is to be removed
 */
export const removeEntry = (entry: CourseEntry): ScheduleAction => ({
    type: REMOVE_ENTRY,
    entry: entry,
});
