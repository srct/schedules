/**
 * reducers/index.ts
 *
 * Wrap all reducers in a common object to be returned to the store.
 */
import { schedule, ScheduleState } from './schedule.reducer';
import { search, SearchState } from './search.reducer';

export interface State {
    schedule: ScheduleState;
    searchResults: SearchState;
}

/**
 * If there is no current state passed in then initialize as nothing.
 */
const defaultState: State = {
    schedule: [],
    searchResults: [],
};

/**
 * Combine all reducers into one object to attach to the store
 * @param state The current state, initialized as nothing
 * @param action The action to be applied to the reducers
 */
export const allReducers = (state: State = defaultState, action: any) => ({
    schedule: schedule(state.schedule, action),
    searchResults: search(state.searchResults, action),
});
