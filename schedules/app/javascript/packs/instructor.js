// /**
//  * Either adds or removes a section from the cart depending on
//  * if it is currently in the cart.
//  */

import $ from 'jquery';
import Cart from 'src/Cart';

const addOrRemoveFromCart = async (event, sectionNode) => {
    event && event.stopPropagation();
    if (event.target.tagName === 'A') return;
    const section = { ...sectionNode.dataset };

    Cart.toggleCrn(section.crn);
    const icon = $(sectionNode.querySelector('.add-remove-btn #icon'));
    const text = sectionNode.querySelector('.add-remove-btn .text');
    if (Cart.includesCrn(section.crn)) {
        icon.addClass('fa-minus').removeClass('fa-plus');
        text.innerText = 'Remove';
    } else {
        icon.addClass('fa-plus').removeClass('fa-minus');
        text.innerText = 'Add';
    }
};

const initSearchListeners = () => {
    const sectionItems = Array.from(document.querySelectorAll('.section-item'));
    sectionItems.forEach(item => {
        item.onclick = event => addOrRemoveFromCart(event, item);
    });

    setTimeout(() => {
        sectionItems.forEach(item => {
            const icon = $(item.querySelector('.add-remove-btn #icon'));
            const text = item.querySelector('.add-remove-btn .text');
            console.log(item.dataset.crn);
            if (Cart.includesCrn(item.dataset.crn)) {
                icon.addClass('fa-minus').removeClass('fa-plus');
                text.innerText = 'Remove';
            } else {
                icon.addClass('fa-plus').removeClass('fa-minus');
                text.innerText = 'Add';
            }
        });
    }, 100);
};

document.addEventListener('DOMContentLoaded', initSearchListeners);
