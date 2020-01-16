import { Controller } from 'stimulus'
import Turbolinks from 'turbolinks'
import { buildUrl } from '../utils'

export default class extends Controller {
    static targets = ['input']

    search(event) {
        event.preventDefault()
        const url = `/search?query=${this.inputTarget.value}`
        Turbolinks.visit(url)
    }
}
console.log('AHHH')
