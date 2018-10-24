// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

const sectionWithCrn = crn => document.getElementById('search-list').querySelector(`[data-crn="${crn}"]`);

// const addCourse = async (event, id) => {
//     event && event.stopPropagation();

//     const courseCard = document.getElementById(`course-${id}`);
//     const title = courseCard.querySelector('.title').innerText;
//     const sectionsItems = Array.from(courseCard.querySelectorAll('li'));
//     const filtered = sectionsItems.filter(li => {
//         return !li.parentNode.classList.contains('pair') || li.dataset.type === 'Lecture';
//     });

//     for (const section of filtered) {
//         await addOrRemoveFromCart(undefined, section);
//     }
// }
/**
 * Either adds or removes a section from the cart depending on
 * if it is currently in the cart.
 */
const addOrRemoveFromCart = async (event, sectionNode) => {
    event && event.stopPropagation();
    const section = { ...sectionNode.dataset };

    await this.cart.addSection(section);
    if (this.cart.includesSection(section)) {
        sectionNode.classList.add('selected');
    } else {
        sectionNode.classList.remove('selected');
    }
};

/**
 * Toggles the display of the schedule
 */
const toggleSections = course => {
    const sections = course.querySelector('.sections');

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
    document.getElementById('calendar-link').innerText = `${window.location.protocol}//${window.location.hostname}/api/schedule?crns=${this.cart._courses.join(',')}`;
};
