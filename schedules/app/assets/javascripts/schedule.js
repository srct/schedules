class Schedule {
    constructor() {
        this.isOpen = false;
        this._ids = Array.from(document.getElementById('schedule').children).map(e => e.dataset.crn);
    }

    get ids() {
        return this._ids;
    }

    set ids(ids) {
        this._ids = ids;

        document.getElementById('course-counter').innerText = ids.length;
        fetch('/sessions/update?crns=' + ids.join(','), { cache: 'no-store' });
    }

    toggle() {
        const list = document.getElementById('cart');
        const icon = document.getElementById('schedule-icon');

        if (this.isOpen) {
            list.style.display = 'none';
            icon.style.color = 'black';
        } else {
            list.style.display = 'block';
            icon.style.color = 'green';
        }

        this.isOpen = !this.isOpen;
    }

    addToSchedule(section) {
        if (this.ids.includes(section.dataset.crn)) return;

        this.ids = [...this.ids, section.dataset.crn];

        section.classList.remove('section-item');
        section.classList.remove('selected');
        section.classList.add('schedule-section-card');
        section.onclick = () => removeFromSchedule(section);

        document.getElementById('schedule').appendChild(section);
    }

    removeFromSchedule(id) {
        const cart = document.getElementById('schedule');
        const section = cart.querySelector(`#section-${id}`);
        cart.removeChild(section);

        this.ids = this.ids.filter(_id => _id != id);
    }

    async downloadIcs() {
        const cal = await fetch(`/api/schedules?crns=${this.ids.join(',')}`);
        const text = await cal.text();
        var blob = new Blob([text], { type: 'text/calendar;charset=utf-8' });
        saveAs(blob, 'test.ics');
    }

    async addToSystemCalendar() {
        const url = `webcal://${window.location.hostname}/api/schedule?crns=${this.ids.join(',')}`;
        window.open(url, '_self');
    }
}
