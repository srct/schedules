// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

const sectionWithCrn = crn => document.getElementById('search-list').querySelector(`[data-crn="${crn}"]`);

const addCourse = (event, id) => {
    const courseCard = document.getElementById(`course-${id}`);
    const title = courseCard.querySelector('.title').innerText;
    const sectionsItems = Array.from(courseCard.querySelectorAll('li'));
    const sections = sectionsItems.map(li => ({ ...li.dataset }));

    this.cart.addCourse({ title, id, sections });
    sectionsItems.forEach(s => s.classList.add('selected'));

    event.stopPropagation();
};
/**
 * Either adds or removes a section from the cart depending on
 * if it is currently in the cart.
 */
const addOrRemoveFromCart = (event, sectionNode) => {
    const section = { ...sectionNode.dataset };

    if (this.cart.includesSection(section.id)) {
        this.cart.removeSection(section);
        sectionNode.classList.remove('selected');
    } else {
        this.cart.addSection(section);
        sectionNode.classList.add('selected');
    }

    event.stopPropagation();
};

/**
 * Removes a given section from the cart
 * @param {Node} DOM Node of the Section in the cart
 */
const removeFromCart = section => {
    const sectionInSearch = sectionWithCrn(section.dataset.crn);
    if (sectionInSearch) {
        sectionInSearch.classList.remove('selected');
    }
    this.cart.removeFromSchedule(section.dataset.crn);
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
    document.getElementById('calendar-link').innerText = `https://${window.location.hostname}/api/schedule?crns=${this.cart.ids.join(',')}`;
};
