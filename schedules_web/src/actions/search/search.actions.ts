import ApiService from '../../util/ApiService';
import CourseSection from '../../util/CourseSection';
import { SET_SEARCH_RESULTS } from './search.action-types';

export interface SearchAction {
    type: string;
    searchResults: CourseSection[];
    error: string;
}

export const searchCourseSections = (crn: string) => async (dispatch: any) => {
    const objects = await ApiService.searchCourseSections(crn);

    const results: CourseSection[] = objects.map(
        (object: any): CourseSection => ({
            id: object.id,
            name: object.name,
            title: object.title,
            crn: object.crn,
            instructor: object.instructor,
            location: object.location,
            days: object.days,
            startTime: object.start_time,
            endTime: object.end_time,
        })
    );

    dispatch({
        type: SET_SEARCH_RESULTS,
        searchResults: results,
        error: results.length === 0 ? 'No course sections found with the given CRN.' : '',
    });
};
