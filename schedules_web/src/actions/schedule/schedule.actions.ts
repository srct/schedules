import { Section } from '../../util/section';
import { ADD_SECTION, REMOVE_SECTION } from './schedule.action-types';

export interface ScheduleAction {
    type: string; // What action is to be performed
    section: Section; // The section that is being added/removed
}

/**
 * Add a section to the Schedule
 * @param section The section that is to be added
 */
export const addSection = (section: Section): ScheduleAction => ({
    type: ADD_SECTION,
    section: section,
});

/**
 * Remove a section from the Schedule
 * @param section The section that is to be removed
 */
export const removeSection = (section: Section): ScheduleAction => ({
    type: REMOVE_SECTION,
    section: section,
});
