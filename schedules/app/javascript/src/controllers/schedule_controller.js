import { Controller } from 'stimulus'
import { getCart } from 'src/cart'
import { buildUrl, downloadIcal } from '../utils'
import 

export default class extends Controller {
    static targets = ['schedule', 'loader', 'export', 'modal']

    connect() {
        if (getCart().length == 0) {
            this.exportTarget.classList.add('hidden')
            this.loaderTarget.classList.add('hidden')
            this.scheduleTarget.innerHTML = 'Add courses to your cart to see them here!'
        } else {
            this.exportTarget.classList.remove('hidden')
            this.loaderTarget.classList.remove('hidden')
            this.scheduleTarget.innerHTML = ''
            fetch(`/course_sections?crns=${getCart().join(',')}`)
                .then(resp => resp.text())
                .then(text => {
                    this.scheduleTarget.innerHTML = text
                    this.loaderTarget.classList.add('hidden')
                })
        }
    }

    downloadIcs() {
        downloadIcal(buildUrl(`/api/schedules?crns=${getCart().join(',')}`), 'GMU Schedule.ics')
    }

    openWebcal() {
        window.open(buildUrl(`/api/schedules?crns=${getCart().join(',')}`, 'webcal:'))
    }

    showModal() {
        $(this.modalTarget).modal('toggle')
    }
}
