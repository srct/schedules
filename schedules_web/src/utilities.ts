import * as FileSaver from 'file-saver';

export const ENDPOINTS = {
    generateCalendar: 'http:localhost:3000/api/generate',
};

export function postData(endpoint: string, data: any): Promise<Response> {
    return fetch(endpoint, {
        method: 'POST',
        body: JSON.stringify(data),
        headers: {
            'Content-Type': 'application/json',
        },
    });
}

export function downloadCalendar(calendarText: string) {
    const blob = new Blob([calendarText], { type: 'text/plain;charset=utf-8' });
    FileSaver.saveAs(blob, 'GMU Fall 2018.ics');
}
