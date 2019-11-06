import { Controller } from 'stimulus'
import { subscribe, toggleSection, hasSection } from 'src/cart'

export default class extends Controller {
    static targets = ['icon', 'text']

    connect() {
        subscribe(() => this.draw())
        this.draw()
    }

    toggle() {
        toggleSection(this.crn)
    }

    draw() {
        if (hasSection(this.crn)) {
            this.iconTarget.className = 'fas fa-minus add-remove-icon'
            this.textTarget.innerText = 'Remove from Cart'
        } else {
            this.iconTarget.className = 'fas fa-plus add-remove-icon'
            this.textTarget.innerText = 'Add Section to Cart'
        }
    }

    get crn() {
        return this.data.get('crn')
    }
}
