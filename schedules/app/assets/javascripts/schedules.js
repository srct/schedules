document.addEventListener('DOMContentLoaded', () => {
    const eventsTemplate = document.querySelector('#events');
    if (eventsTemplate) {
        const eventsJSON = eventsTemplate.dataset.events;
        const events = JSON.parse(eventsJSON);
        window.events = events;
        console.log(events);
        $('#calendar').fullCalendar({
            defaultDate: new Date(2019, 0, 14),
            defaultView: 'agendaWeek',
            header: false,
            events: renderEvents,
        });

        document.getElementById('numSchedules').innerText = window.events.length;
    }
});

let i = 0;

const renderEvents = (start, end, timezone, callback) => {
    console.log(window.events[i]);
    document.getElementById('currentSchedule').innerText = i + 1;
    callback(window.events[i]);
};

const nextSchedule = () => {
    if (i + 1 < window.events.length) i++;

    $('#calendar').fullCalendar('refetchEvents');

    console.log(window.events[i]);
};

const prevSchedule = () => {
    if (i > 0) i--;

    $('#calendar').fullCalendar('refetchEvents');

    console.log(window.events[i]);
};
