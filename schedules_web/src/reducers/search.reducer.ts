/**
 * reducers/search.reducer.ts
 *
 * Perform operations on the current state of the "search.searchedSections"
 * list in the store and return a new definition of the state.
 */
import { SET_SEARCH_RESULTS } from '../actions/search/search.action-types';
import { SearchAction } from '../actions/search/search.actions';
import CourseSection from '../util/CourseSection';

export type SearchState = CourseSection[];

export const search = (state: SearchState = [], action: SearchAction): SearchState => {
    switch (action.type) {
        case SET_SEARCH_RESULTS:
            return action.searchResults;
        default:
            return state;
    }
};
