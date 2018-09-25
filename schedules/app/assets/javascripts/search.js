// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

class Search {
    sectionWithCrn(crn) {
        return document.getElementById('search-list').querySelector(`[data-crn="${crn}"]`);
    }
}

const addToSchedule = (event, section) => {
    section.classList.add('selected');

    this.schedule.addToSchedule(section.cloneNode(true));

    event.stopPropagation();
};

const removeFromSchedule = section => {
    const sectionInSearch = this.search.sectionWithCrn(section.dataset.crn);
    if (sectionInSearch) {
        sectionInSearch.classList.remove('selected');
    }

    this.schedule.removeFromSchedule(section.dataset.crn);
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
