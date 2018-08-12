class ApiService {
    private apiRoot: string;

    public constructor(apiRoot: string) {
        this.apiRoot = apiRoot;
    }

    searchCourseSections = async (crn: string): Promise<string[]> =>
        fetchJson(`${this.apiRoot}/course_sections?crn=${crn}`);
    generateCalendar = async (crns: string[]): Promise<string> =>
        postJson(`${this.apiRoot}/generate`, crns).then(response => response.text());
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
