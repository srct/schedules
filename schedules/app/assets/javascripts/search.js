// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

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
        fetch('/search/update?ids=' + ids.join(','), { cache: 'no-store' });
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

    _constructSectionCard(section) {
        const str = `
	      <li id="section-${section.crn}" class="list-group-item schedule-section-card" onclick="removeFromSchedule(this)">
	        <span style="float:left"><b class="subj">${section.name}</b>: ${section.title}</span>
	        <span style="float:right"><i class="fas fa-map-marker-alt"></i> ${section.location} </span>
	        <div style="clear: both"></div>
	        <span style="float:left"><i class="fas fa-chalkboard-teacher"></i> TODO </span>
	        <span style="float:right"><i class="fas fa-clock"></i> ${section.days}, ${section.start_time}-${section.end_time} </span>
	        <div style="clear: both"></div>
	      </li>`;

        return elementFromString(str);
    }
}

class Search {
    sectionWithCrn(crn) {
        return document.getElementById('search-list').querySelector(`[data-crn="${crn}"]`);
    }
}

const toggleSchedule = () => this.schedule.toggle();

const addToSchedule = (event, section) => {
    section.classList.add('selected');

    this.schedule.addToSchedule(section.cloneNode(true));

    event.stopPropagation();
};

const removeFromSchedule = section => {
    this.search.sectionWithCrn(section.dataset.crn).classList.remove('selected');
    this.schedule.removeFromSchedule(section.id.split('-')[1]);
};

const toggleSections = course => {
    const sections = course.querySelector('#sections');
    if (sections.style.display === 'block') {
        course.querySelector('#sections').style.display = 'none';
    } else {
        course.querySelector('#sections').style.display = 'block';
    }
};

const setUrlInModal = () => {
    document.getElementById('calendar-link').innerText = `https://${window.location.hostname}/api/schedule?crns=${this.schedule.ids.join(',')}`;
};

const downloadIcs = async () => {
    const cal = await fetch(`/api/schedules?crns=${this.schedule.ids.join(',')}`);
    const text = await cal.text();
    var blob = new Blob([text], { type: 'text/calendar;charset=utf-8' });
    saveAs(blob, 'test.ics');
};

const addToSystemCalendar = async () => {
    const url = `webcal://${window.location.hostname}/api/schedule?crns=${this.schedule.ids.join(',')}`;
    window.open(url, '_self');
};
