// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

const sectionWithCrn = crn => document.getElementById('search-list').querySelector(`[data-crn="${crn}"]`);

const addCourse = (event, id) => {
    const courseCard = document.getElementById(`course-${id}`);
    const title = courseCard.querySelector('#title').innerText;
    const sectionsItems = Array.from(courseCard.querySelectorAll('li'));
    const sections = sectionsItems.map(li => ({ ...li.dataset }));

    this.schedule.addCourse({ title, id, sections });
    sectionsItems.forEach(s => s.classList.add('selected'));

    event.stopPropagation();
};
/**
 * Either adds or removes a section from the schedule depending on
 * if it is currently in the schedule.
 */
const addOrRemoveFromSchedule = (event, sectionNode) => {
    const section = { ...sectionNode.dataset };

    if (this.schedule.includesSection(section.id)) {
        this.schedule.removeSection(section);
        sectionNode.classList.remove('selected');
    } else {
        this.schedule.addSection(section);
        sectionNode.classList.add('selected');
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
    const sections = course.querySelector('#sections');
    if (sections.style.display === 'block') {
        course.querySelector('#sections').style.display = 'none';
    } else {
        course.querySelector('#sections').style.display = 'block';
    }
};

/**
 * Generates a webcal:// URL for the current sections in the schedule
 * and sets the link in the modal to it.
 */
const setUrlInModal = () => {
    document.getElementById('calendar-link').innerText = `https://${window.location.hostname}/api/schedule?crns=${this.schedule.ids.join(',')}`;
};
