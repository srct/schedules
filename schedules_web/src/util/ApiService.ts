class ApiService {
    private apiRoot: string;

    public constructor(apiRoot: string) {
        this.apiRoot = apiRoot;
    }

    searchCourseSections = async (crn: string): Promise<any[]> =>
        fetchJson(`${this.apiRoot}/course_sections?crn=${crn}`);
    subscribeToCalendar = (crns: string[]) =>
        window.open(`webcal://localhost:3000/api/schedules?crns=${crns.join(',')}`, '_self');
}

const fetchJson = async (url: string): Promise<any> => fetch(url).then(response => response.json());
const postJson = (endpoint: string, data: any): Promise<Response> =>
    fetch(endpoint, {
        method: 'POST',
        body: JSON.stringify(data),
        headers: {
            'Content-Type': 'application/json',
        },
    });

export default new ApiService('http://localhost:3000/api');
