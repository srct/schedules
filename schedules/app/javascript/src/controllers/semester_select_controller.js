import { Controller } from 'stimulus'
import { buildUrl } from '../utils'
import Turbolinks from 'turbolinks'

export default class extends Controller {
    changeSemester(event) {
        event.preventDefault()
        const id = event.target.value
        Turbolinks.visit(buildUrl(window.location.pathname + '?' + event.target.name + '=' + id))
    }
}
