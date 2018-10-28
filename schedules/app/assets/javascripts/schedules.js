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
        });
    }

    initListeners();
});

const renderEvents = (start, end, timezone, callback) => {
    callback(window.events);
};

const remove = async item => {
    await window.cart.addSection({ ...item.dataset });
    location.reload(true);
};

/**
 * Generates a URL for the current sections in the schedule
 * and sets the link in the modal to it.
 */
const setUrlInModal = () => {
    document.getElementById('calendar-link').innerText = `${window.location.protocol}//${window.location.hostname}/api/schedules?section_ids=${window.cart._courses.join(',')}`;
};

const downloadIcs = async () => {
    const response = await fetch(`http://localhost:3000/api/schedules?section_ids=${window.cart._courses.join(',')}`);
    const text = await response.text();
    const blob = new Blob([text], { type: 'text/calendar;charset=utf-8' });
    saveAs(blob, 'GMU Schedule.ics');
};

const addToSystemCalendar = () => {};

const initListeners = () => {
    const items = Array.from(document.querySelectorAll('.section-item'));
    items.forEach(item => (item.onclick = () => remove(item)));

    document.getElementById('open-modal-btn').onclick = setUrlInModal;
    document.getElementById('download-ics').onclick = downloadIcs;
    document.getElementById('add-to-system').onclick = addToSystemCalendar;
};
