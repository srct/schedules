export interface Section {
    id: number;
    name: string;
    title: string;
    crn: string;
    instructor: string;
    location: string;
    days: string;
    startTime: string;
    endTime: string;
}

export async function fetchSectionWithCRN(crn: string): Promise<Section> {
    const response = await fetch(`http://localhost:3000/api/search?crn=${crn}`);
    const object = await response.json();

    return {
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
}
