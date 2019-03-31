//import '@babel/polyfill';

class Cart {
    constructor() {
        this.isOpen = false;
        this._courses = [];

        const cartData = document.getElementById('cart-data');
        if (cartData) {
            this._courses = JSON.parse(cartData.dataset.cart);
        }
    }

    _parseData() {
        const cartData = document.getElementById('cart-data');
        if (cartData) {
            this._courses = JSON.parse(cartData.dataset.cart);
        }
    }

    toggle() {
        const list = document.getElementById('cart');
        const icon = document.getElementById('schedule-icon');

        if (this.isOpen) {
            list.style.display = 'none';
            icon.style.color = 'black';
        } else {
            list.style.display = 'block';
            icon.style.color = 'green';
        }

        this.isOpen = !this.isOpen;
    }

    set courses(courses) {
        this._courses = courses;
        for (const courseId in this._courses) {
            if (this._courses[courseId].length === 0) delete this._courses[courseId];
        }
        document.getElementById('cart-counter').innerText = Object.keys(this._courses).length;
    }

    async toggleSection(section) {
        const resp = await fetch(`/sessions/cart?&crn=${section.crn}`, {
            cache: 'no-store',
            credentials: 'same-origin',
        });
        const json = await resp.json();
        this.courses = json;
    }

    includesSection(obj) {
        for (const key in this._courses) {
            const list = this._courses[key];
            if (list.includes(obj.crn)) return true;
        }

        return false;
    }
}

const cart = new Cart();

document.addEventListener('DOMContentLoaded', () => cart._parseData());

export default cart;
