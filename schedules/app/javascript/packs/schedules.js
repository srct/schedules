import React from 'react';
import ReactDOM from 'react-dom';
import Cart from 'src/Cart';
import { saveAs } from 'file-saver';
import html2canvas from 'html2canvas';
import $ from 'jquery';
import CalendarPage from 'src/CalendarPage';

document.addEventListener('DOMContentLoaded', () => {
    ReactDOM.render(<CalendarPage />, document.getElementById('root'));
});

const downloadIcs = async () => {
    const response = await fetch(`${window.location.protocol}//${window.location.hostname}/api/schedules?crns=${Cart._courses.join(',')}`);
    const text = await response.text();
    const blob = new Blob([text], { type: 'text/calendar;charset=utf-8' });
    saveAs(blob, 'GMU Schedule.ics');
};

const addToSystemCalendar = () => {
    window.open(`webcal://${window.location.hostname}/api/schedules?crns=${Cart._courses.join(',')}`);
};

const saveImage = () => {
    html2canvas(document.querySelector('#calendar')).then(canvas => {
        canvas.toBlob(blob => {
            saveAs(blob, 'GMU Schedule.png');
        });
    });
};

const initListeners = () => {
    const items = Array.from(document.querySelectorAll('.section-item'));
    items.forEach(item => (item.onclick = () => remove(item)));

    // document.getElementById('open-modal-btn').onclick = setUrlInModal;
    document.getElementById('download-ics').onclick = downloadIcs;
    document.getElementById('add-to-system').onclick = addToSystemCalendar;
    document.getElementById('save-image').onclick = saveImage;

    document.getElementById('share-url').innerText = `${window.location.protocol}//${window.location.hostname}/schedule/view?crns=${Cart._courses.join(',')}`;
    document.getElementById('share-url').href = `${window.location.protocol}//${window.location.hostname}/schedule/view?crns=${Cart._courses.join(',')}`;
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
