import { Section } from '../../ts/section';
import { ADD_SECTION, REMOVE_SECTION } from './schedule.action-types';

export interface ScheduleAction {
    type: string;
    section: Section;
}

export const addSection = (section: Section): ScheduleAction => {
    return {
        type: ADD_SECTION,
        section: section,
    };
};

export const removeSection = (section: Section): ScheduleAction => {
    return {
        type: REMOVE_SECTION,
        section: section,
    };
};
