/**
 * reducers/schedule.reducer.ts
 *
 * Perform operations on the current state of the "Schedule" list in the store
 * and return a new definition of the state.
 */
import { ADD_COURSE_SECTION, REMOVE_COURSE_SECTION } from '../actions/schedule/schedule.action-types';
import { ScheduleAction } from '../actions/schedule/schedule.actions';
import CourseSection from '../util/CourseSection';

export type ScheduleState = CourseSection[];

export const schedule = (state: ScheduleState = [], action: ScheduleAction) => {
    switch (action.type) {
        case ADD_COURSE_SECTION:
            return state.findIndex(s => s.crn === action.courseSection.crn) === -1
                ? [...state, action.courseSection]
                : state;
        case REMOVE_COURSE_SECTION:
            return state.filter(s => s.crn !== action.courseSection.crn);
        default:
            return state;
    }
};
