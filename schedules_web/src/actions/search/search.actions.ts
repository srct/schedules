import { SET_SEARCH_SECTIONS } from './search.action-types';
import { Section } from '../../ts/section';

export interface SearchAction {
    type: string;
    sections: Section[];
}

export const searchSections = (crn: string) => async (dispatch: any) => {
    const response = await fetch(`http://localhost:3000/api/search?crn=${crn}`);
    const object = await response.json();

    const section: Section = {
        id: object.id,
        name: object.name,
        title: object.title,
        crn: object.crn,
        instructor: object.instructor,
        location: object.location,
        days: object.days,
        startTime: object.start_time,
        endTime: object.end_time,
    };

    dispatch({
        type: SET_SEARCH_SECTIONS,
        sections: [section]
    });
}