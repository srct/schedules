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

const initListeners = () => {
    const items = Array.from(document.querySelectorAll('.section-item'));
    items.forEach(item => (item.onclick = e => addOrRemoveFromCart(e, item)));
};

document.addEventListener('DOMContentLoaded', initListeners);
