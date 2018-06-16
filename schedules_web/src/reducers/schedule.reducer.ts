/**
 * reducers/schedule.reducer.ts
 *
 * Perform operations on the current state of the "Schedule" list in the store
 * and return a new definition of the state.
 */
import { ADD_SECTION, REMOVE_SECTION } from '../actions/schedule/schedule.action-types';
import { ScheduleAction } from '../actions/schedule/schedule.actions';
import { Section } from '../util/section';

export type ScheduleState = Section[];

export const schedule = (state: ScheduleState = [], action: ScheduleAction) => {
    switch (action.type) {
        case ADD_SECTION:
            return state.findIndex(s => s.crn === action.section.crn) === -1 ? [...state, action.section] : state;
        case REMOVE_SECTION:
            return state.filter(s => s.crn !== action.section.crn);
        default:
            return state;
    }
};
