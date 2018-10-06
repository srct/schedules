// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

const sectionWithCrn = crn => document.getElementById('search-list').querySelector(`[data-crn="${crn}"]`);

/**
 * Either adds or removes a section from the schedule depending on
 * if it is currently in the schedule.
 */
const addOrRemoveFromSchedule = (event, section) => {
    if (this.schedule.ids.includes(section.dataset.crn)) {
        this.schedule.removeFromSchedule(section.dataset.crn);
        section.classList.remove('selected');
    } else {
        this.schedule.addToSchedule(section.cloneNode(true));
        section.classList.add('selected');
    }

    event.stopPropagation();
};

/**
 * Removes a given section from the schedule
 * @param {Node} DOM Node of the Section in the schedule
 */
const removeFromSchedule = section => {
    const sectionInSearch = sectionWithCrn(section.dataset.crn);
    if (sectionInSearch) {
        sectionInSearch.classList.remove('selected');
    }
    this.schedule.removeFromSchedule(section.dataset.crn);
};

/**
 * Toggles the display of the schedule
 */
const toggleSections = course => {
    const sections = course.querySelector('.sections');
    console.log(sections);
    if (sections.style.display === 'flex') {
        sections.style.display = 'none';
    } else {
        sections.style.display = 'flex';
    }
};

/**
 * Generates a webcal:// URL for the current sections in the schedule
 * and sets the link in the modal to it.
 */
const setUrlInModal = () => {
    document.getElementById('calendar-link').innerText = `https://${window.location.hostname}/api/schedule?crns=${this.schedule.ids.join(',')}`;
};
