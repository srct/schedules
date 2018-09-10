class ApiService {
    private apiRoot: string;
    private webcalUrl: string;

    public constructor(apiRoot: string, webcalUrl: string) {
        this.apiRoot = apiRoot;
        this.webcalUrl = webcalUrl;
    }

    searchCourseSections = async (crn: string): Promise<any[]> =>
        fetchJson(`${this.apiRoot}/course_sections?crn=${crn}`);
    generateCalendarUrl = (crns: string[]): string => `${this.apiRoot}/schedules?crns=${crns.join(',')}`;
    openCalendarAsWebcal = (crns: string[]) => {
        window.open(`${this.webcalUrl}/schedules?crns=${crns.join(',')}`, '_self');
    };
    fetchICal = async (crns: string[]): Promise<string> =>
        fetch(this.generateCalendarUrl(crns)).then(response => response.text());
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

const local = 'localhost:3000/api';
const remote = `${window.location.hostname}/api`;

const apiUrl = process.env.NODE_ENV === 'development' ? `http://${local}` : `https://${remote}`;
const webcalUrl = process.env.NODE_ENV === 'development' ? `webcal://${local}` : `webcal://${remote}`;

export default new ApiService(apiUrl, webcalUrl);
