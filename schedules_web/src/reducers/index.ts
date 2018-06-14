import { schedule, ScheduleState } from './schedule.reducer';
import { search, SearchState } from './search.reducer';

export interface State {
    schedule: ScheduleState;
    search: SearchState;
}

/**
 * If there is no current state passed in then initialize as nothing.
 */
const defaultState: State = {
    schedule: [],
    search: {
        searchedSections: [],
    },
};

export const allReducers = (state: State = defaultState, action: any) => ({
    schedule: schedule(state.schedule, action),
    search: search(state.search, action),
});
