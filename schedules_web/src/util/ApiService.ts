class ApiService {
    private apiRoot: string;
    private webcalUrl: string;

    public constructor(apiRoot: string, webcalUrl: string) {
        this.apiRoot = apiRoot;
        this.webcalUrl = webcalUrl;
    }

    searchCourseSections = async (crn: string): Promise<any[]> =>
        fetchJson(`${this.apiRoot}/course_sections?crn=${crn}`);
    subscribeToCalendar = (crns: string[]) =>
        window.open(`${this.webcalUrl}/schedules?crns=${crns.join(',')}`, '_self');
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
const remote = 'schedules.zacwood.me/api';

const apiUrl = process.env.NODE_ENV === 'development' ? `http://${local}` : `https://${remote}`;
const webcalUrl = process.env.NODE_ENV === 'development' ? `webcal://${local}` : `webcal://${remote}`;

export default new ApiService(apiUrl, webcalUrl);
