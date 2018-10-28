// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

const sectionWithCrn = crn => document.getElementById('search-list').querySelector(`[data-crn="${crn}"]`);

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

const initSearchListeners = () => {
    const courseCards = Array.from(document.querySelectorAll('.course-card'));
    courseCards.forEach(card => {
        card.onclick = () => toggleSections(card);
    });

    const sectionItems = Array.from(document.querySelectorAll('.section-item'));
    sectionItems.forEach(item => (item.onclick = event => addOrRemoveFromCart(event, item)));
};

document.addEventListener('DOMContentLoaded', initSearchListeners);
