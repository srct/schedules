/**
 * util/utilities.ts
 *
 * Reusable deterministic functions.
 */
import * as FileSaver from 'file-saver';

export const ENDPOINTS = {
    generateCalendar: 'http://localhost:3000/api/generate',
};

export const postData = (endpoint: string, data: any): Promise<Response> =>
    fetch(endpoint, {
        method: 'POST',
        body: JSON.stringify(data),
        headers: {
            'Content-Type': 'application/json',
        },
    });

export const downloadCalendar = (calendarText: string) =>
    FileSaver.saveAs(new Blob([calendarText], { type: 'text/plain;charset=utf-8' }), 'GMU Fall 2018.ics');
