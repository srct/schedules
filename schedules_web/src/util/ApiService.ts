class ApiService {
    private apiRoot: string;

    public constructor(apiRoot: string) {
        this.apiRoot = apiRoot;
    }

    searchCourseSections = async (crn: string) => fetchJson(`${this.apiRoot}/course_sections?crn=${crn}`);
}

const fetchJson = async (url: string): Promise<any> => fetch(url).then(response => response.json());

export default new ApiService('http://localhost:3000/api');
