import { Controller } from 'stimulus'
import { version } from '../utils'

export default class extends Controller {
    connect() {
        const [tag, update] = version()
        this.element.innerHTML = tag
        update.then(tag => (this.element.innerHTML = tag))
    }
}
