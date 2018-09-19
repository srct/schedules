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

        fetch('/search/add/' + section.id);

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

        fetch('/search/remove/' + id);
    }

    _constructSectionCard(section) {
        const str = `
	      <li id="${section.id}" class="list-group-item" onclick="removeFromSchedule(this)">
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
    constructor() {
        const searchItems = Array.from(document.getElementById('search-list').children);
        this.courses = searchItems.map(s => JSON.parse(s.dataset.course));
        console.log(this.courses);
    }

    courseWithId(id) {
        return this.courses.filter(c => c.id == id)[0];
    }
}

const toggleSchedule = () => this.schedule.toggle();

const addToSchedule = (event, section) => {
    console.log(section.dataset.section);
    this.schedule.addToSchedule(JSON.parse(section.dataset.section));

    event.stopPropagation();
};

const removeFromSchedule = section => {
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
