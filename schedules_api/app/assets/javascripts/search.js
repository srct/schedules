// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

class Schedule {
    constructor() {
        this.isOpen = false;
        this._ids = Array.from(document.getElementById('cart-list').children).map(e => Number(e.id));
    }

    get ids() {
        return this._ids;
    }

    set ids(ids) {
        this._ids = ids;

        document.getElementById('course-counter').innerText = ids.length;
        fetch('/search/update?ids=' + ids.join(','));
    }

    toggle() {
        const list = document.getElementById('schedule-list');
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
        if (this.ids.includes(section.id)) return;

        this.ids = [...this.ids, section.id];

        const courses = document.getElementById('cart-list');
        const newCourseCard = this._constructSectionCard(section);
        courses.appendChild(newCourseCard);
    }

    removeFromSchedule(id) {
        const cart = document.getElementById('cart-list');
        const children = Array.from(cart.children);
        const withId = children.findIndex(c => c.id == id);
        cart.removeChild(children[withId]);

        this.ids = this.ids.filter(_id => _id != Number(id));
    }

    _constructSectionCard(section) {
        const str = `
	      <li id="${section.id}" class="list-group-item schedule-section-card" onclick="removeFromSchedule(this)">
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
    sectionWithId(sectionId) {
        return document.getElementById('search-list').querySelector(`#section-${Number(sectionId)}`);
    }
}

const toggleSchedule = () => this.schedule.toggle();

const addToSchedule = (event, section) => {
    section.classList.add('selected');

    this.schedule.addToSchedule(JSON.parse(section.dataset.section));

    event.stopPropagation();
};

const removeFromSchedule = section => {
    this.search.sectionWithId(section.id).classList.remove('selected');
    this.schedule.removeFromSchedule(section.id);
};

const toggleSections = course => {
    const sections = course.querySelector('#sections');
    if (sections.style.display === 'block') {
        course.querySelector('#sections').style.display = 'none';
    } else {
        course.querySelector('#sections').style.display = 'block';
    }
};

document.addEventListener('DOMContentLoaded', () => {
    this.schedule = new Schedule();
    this.search = new Search();
});
