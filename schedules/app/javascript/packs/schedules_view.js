import Cart from 'src/cart';
import { saveAs } from 'file-saver';
import html2canvas from 'html2canvas';
import $ from 'jquery';
import 'fullcalendar';
import 'moment';
import 'url-polyfill';

const params = new URLSearchParams(document.location.search);
const crns = params.get('crns');

document.addEventListener('DOMContentLoaded', () => {
    const eventsTemplate = document.querySelector('#events');
    if (eventsTemplate) {
        const eventsJSON = eventsTemplate.dataset.events;
        const events = JSON.parse(eventsJSON);
        window.events = events;
        $('#calendar').fullCalendar({
            defaultDate: new Date(2019, 0, 14),
            defaultView: 'agendaWeek',
            header: false,
            events: renderEvents,
            columnHeaderFormat: 'dddd',
            allDaySlot: false,
        });
    }

    initListeners();
});

const renderEvents = (start, end, timezone, callback) => {
    callback(window.events);
};

/**
 * Generates a URL for the current sections in the schedule
 * and sets the link in the modal to it.
 */
const setUrlInModal = () => {
    document.getElementById('calendar-link').innerText = `${window.location.protocol}//${window.location.hostname}/api/schedules?crns=${crns}`;
};

const downloadIcs = async () => {
    const response = await fetch(`${window.location.protocol}//${window.location.hostname}/api/schedules?crns=${crns}`);
    const text = await response.text();
    const blob = new Blob([text], { type: 'text/calendar;charset=utf-8' });
    saveAs(blob, 'GMU Schedule.ics');
};

const addToSystemCalendar = () => {
    window.open(`webcal://${window.location.hostname}/api/schedules?crns=${crns}`);
};

const saveImage = () => {
    html2canvas(document.querySelector('#calendar')).then(canvas => {
        canvas.toBlob(blob => {
            saveAs(blob, 'GMU Schedule.png');
        });
    });
};

const initListeners = () => {
    document.getElementById('open-modal-btn').onclick = setUrlInModal;
    document.getElementById('download-ics').onclick = downloadIcs;
    document.getElementById('add-to-system').onclick = addToSystemCalendar;
    document.getElementById('save-image').onclick = saveImage;
};

if (!HTMLCanvasElement.prototype.toBlob) {
    Object.defineProperty(HTMLCanvasElement.prototype, 'toBlob', {
        value: function(callback, type, quality) {
            var canvas = this;
            setTimeout(function() {
                var binStr = atob(canvas.toDataURL(type, quality).split(',')[1]),
                    len = binStr.length,
                    arr = new Uint8Array(len);

                for (var i = 0; i < len; i++) {
                    arr[i] = binStr.charCodeAt(i);
                }

                callback(new Blob([arr], { type: type || 'image/png' }));
            });
        },
    });
}
