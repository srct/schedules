document.addEventListener('DOMContentLoaded', () => {
    const eventsTemplate = document.querySelector('#events');
    if (eventsTemplate) {
        const eventsJSON = eventsTemplate.dataset.events;
        const events = JSON.parse(eventsJSON);
        console.log(events);
        $('#calendar').fullCalendar({
            defaultDate: new Date(2019, 0, 14),
            defaultView: 'agendaWeek',
            header: false,
            events: events,
        });
    }
});
