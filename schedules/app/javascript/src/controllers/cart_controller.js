import { Controller } from 'stimulus'
import { getCart, subscribe } from 'src/cart'

export default class extends Controller {
    static targets = ['counter']

    connect() {
        subscribe(() => this.draw())
        this.draw()
    }

    draw() {
        this.counterTarget.innerText = getCart().length
    }
}
