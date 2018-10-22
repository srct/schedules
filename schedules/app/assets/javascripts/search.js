// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

const sectionWithCrn = crn => document.getElementById('search-list').querySelector(`[data-crn="${crn}"]`);

const addCourse = async (event, id) => {
    event.stopPropagation();

    const courseCard = document.getElementById(`course-${id}`);
    const title = courseCard.querySelector('.title').innerText;
    const sectionsItems = Array.from(courseCard.querySelectorAll('li'));
    const filtered = sectionsItems.filter(li => {
        return !li.parentNode.classList.contains('pair') || li.dataset.type === 'Lecture';
    });

    for (const section of filtered) {
        await addOrRemoveFromCart(undefined, section);
    }
};

/**
 * Either adds or removes a section from the cart depending on
 * if it is currently in the cart.
 */
const addOrRemoveFromCart = async (event, sectionNode) => {
    event && event.stopPropagation();
    const section = { ...sectionNode.dataset };

    const parent = sectionNode.parentNode;
    if (parent.classList.contains('pair')) {
        const otherNode = Array.from(parent.children).filter(c => c != sectionNode)[0];
        const other = { ...otherNode.dataset };

        let pair;
        if (section.type == 'Lecture') {
            pair = [section, other];
            await this.cart.addPair(pair);
        } else {
            pair = [other, section];
            await this.cart.addPair(pair);
        }

        if (this.cart.includesPair(pair)) {
            console.log('found');
            [sectionNode, otherNode].forEach(s => s.classList.add('selected'));
        } else {
            console.log('not found');
            [sectionNode, otherNode].forEach(s => s.classList.remove('selected'));
        }
    } else {
        await this.cart.addSections([section]);
        if (this.cart.includesSection(section)) {
            sectionNode.classList.add('selected');
        } else {
            sectionNode.classList.remove('selected');
        }
    }
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
