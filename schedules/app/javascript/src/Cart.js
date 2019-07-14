class Cart {
    constructor() {
        document.addEventListener('DOMContentLoaded', () => (document.getElementById('cart-counter').innerText = this.crns.length));
    }

    get crns() {
        const crnString = localStorage.getItem('crns');
        if (!crnString) return [];
        return JSON.parse(crnString);
    }

    set crns(crnList) {
        localStorage.setItem('crns', JSON.stringify(crnList));
        document.getElementById('cart-counter').innerText = crnList.length;
    }

    addCrn(crn) {
        if (!this.includesCrn(crn)) {
            this.crns = [...this.crns, crn];
        }
    }

    toggleCrn(crn) {
        if (!this.includesCrn(crn)) {
            this.crns = [...this.crns, crn];
        } else {
            this.crns = this.crns.filter(c => c != crn);
        }
    }

    includesCrn(crn) {
        return this.crns.filter(c => c == crn).length > 0;
    }
}

export default new Cart();
