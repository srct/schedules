export default interface Section {
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

export async function fetchSectionsWithCRN(crn: string): Promise<Section[]> {
    const response = await fetch('http://localhost:3001/api/courses/1/sections');
    const jsonObjects = await response.json();
    let sections: Section[] = [];
    jsonObjects.forEach((object: any) => {
        sections.push({
            id: object.id,
            name: object.name,
            title: object.title,
            crn: object.crn,
            instructor: object.instructor,
            location: object.location,
            days: object.days,
            startTime: object.start_time,
            endTime: object.end_time,
        });
    });
    return sections;
}
