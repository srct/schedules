// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
import Cart from 'src/cart';

/**
 * Either adds or removes a section from the cart depending on
 * if it is currently in the cart.
 */
const addOrRemoveFromCart = async (event, sectionNode) => {
    event && event.stopPropagation();
    const section = { ...sectionNode.dataset };

    await Cart.toggleSection(section);
    const icon = $(sectionNode.querySelector('.add-remove-btn #icon'));
    const text = sectionNode.querySelector('.add-remove-btn .text');
    if (Cart.includesSection(section)) {
        icon.addClass('fa-minus').removeClass('fa-plus');
        text.innerText = 'Remove';
    } else {
        icon.addClass('fa-plus').removeClass('fa-minus');
        text.innerText = 'Add';
    }
};

/**
 * Toggles the display of the schedule
 */
const toggleSections = course => {
    const sections = course.querySelector('.sections');
    const chev = $(course.querySelector('#course-chevron'));
    const label = course.querySelector('#chevron-label');

    if (sections.style.display === 'flex') {
        sections.style.display = 'none';
        chev.addClass('fa-chevron-down').removeClass('fa-chevron-up');
        label.innerText = 'Expand';
    } else {
        sections.style.display = 'flex';
        chev.addClass('fa-chevron-up').removeClass('fa-chevron-down');
        label.innerText = 'Minimize';
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