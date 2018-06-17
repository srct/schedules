import { CourseEntry } from '../../util/CourseEntry';
import { SET_SEARCH_RESULTS } from './search.action-types';

export interface SearchAction {
    type: string;
    searchResults: CourseEntry[];
}

export const searchCourses = (crn: string) => async (dispatch: any) => {
    const response = await fetch(`http://localhost:3000/api/search?crn=${crn}`);
    const object = await response.json();

    const results: CourseEntry[] = [
        {
            id: object.id,
            name: object.name,
            title: object.title,
            crn: object.crn,
            instructor: object.instructor,
            location: object.location,
            days: object.days,
            startTime: object.start_time,
            endTime: object.end_time,
        },
    ];

    dispatch({
        type: SET_SEARCH_RESULTS,
        searchResults: results,
    });
};
