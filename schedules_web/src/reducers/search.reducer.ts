/**
 * reducers/search.reducer.ts
 *
 * Perform operations on the current state of the "search.searchedSections"
 * list in the store and return a new definition of the state.
 */
import { SET_SEARCH_RESULTS } from '../actions/search/search.action-types';
import { SearchAction } from '../actions/search/search.actions';
import CourseSection from '../util/CourseSection';

export interface SearchState {
    courseSections: CourseSection[];
    error: string;
}

const initialState: SearchState = {
    courseSections: [],
    error: '',
};

export const search = (state: SearchState = initialState, action: SearchAction): SearchState => {
    switch (action.type) {
        case SET_SEARCH_RESULTS:
            return { courseSections: action.searchResults, error: action.error };
        default:
            return state;
    }
};
