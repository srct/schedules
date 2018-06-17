/**
 * reducers/schedule.reducer.ts
 *
 * Perform operations on the current state of the "Schedule" list in the store
 * and return a new definition of the state.
 */
import { ADD_ENTRY, REMOVE_ENTRY } from '../actions/schedule/schedule.action-types';
import { ScheduleAction } from '../actions/schedule/schedule.actions';
import { CourseSection } from '../util/CourseSection';

export type ScheduleState = CourseSection[];

export const schedule = (state: ScheduleState = [], action: ScheduleAction) => {
    switch (action.type) {
        case ADD_ENTRY:
            return state.findIndex(s => s.crn === action.entry.crn) === -1 ? [...state, action.entry] : state;
        case REMOVE_ENTRY:
            return state.filter(s => s.crn !== action.entry.crn);
        default:
            return state;
    }
};
