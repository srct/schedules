import { SET_SEARCH_SECTIONS } from '../actions/search/search.action-types';
import { SearchAction } from './../actions/search/search.actions';
import { Section } from './../ts/section';

export interface SearchState {
    searchedSections: Section[];
}

export const search = (state: SearchState = { searchedSections: [] }, action: SearchAction) => {
    switch (action.type) {
        case SET_SEARCH_SECTIONS:
            return Object.assign({}, state, {
                searchedSections: [...action.sections],
            });
        default:
            return state;
    }
};
