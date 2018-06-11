import { schedule, ScheduleState } from './schedule.reducer';
import { search, SearchState } from './search.reducer';

export interface State {
    schedule: ScheduleState
    search: SearchState
}

const defaultState: State = {
    schedule: [],
    search: {
        searchedSections: []
    }
};

export const reducers = (state: State = defaultState, action: any) => ({
    schedule: schedule(state.schedule, action),
    search: search(state.search, action)
})