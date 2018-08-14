/**
 * reducers/index.ts
 *
 * Wrap all reducers in a common object to be returned to the store.
 */
import { schedule, ScheduleState } from './schedule.reducer';
import { search, SearchState } from './search.reducer';
import { combineReducers } from 'redux';

// The global state
export interface State {
    schedule: ScheduleState;
    search: SearchState;
}

/**
 * Combine all reducers into one object to attach to the store
 */
export const allReducers = combineReducers({ search, schedule });
