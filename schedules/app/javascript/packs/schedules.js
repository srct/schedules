import { saveAs } from 'file-saver'

const initPage = () => {
    if (getCart().length != 0) {
        document.getElementById('root').innerHTML = '<i class="fas fa-spinner fa-spin"></i>'
        fetch(`/course_sections?crns=${getCart().join(',')}`)
            .then(resp => resp.text())
            .then(text => {
                const tree = elementFromString(text)
                const body = tree.querySelector('.page')
                document.getElementById('root').innerHTML = body.innerHTML
                setInitialLinks()
                addListeners()
            })
    } else {
        document.getElementById('root').innerHTML = 'Add classes to your cart to see them here!'
    }
    document.querySelector('#count').innerText = getCart().length

    document.getElementById('add-to-system').addEventListener('click', () => {
        window.open(
            `webcal://${window.location.hostname}${
                window.location.port === '3000' ? ':3000' : ''
            }/api/schedules?crns=${getCart().join(',')}`
        )
    })

    document.getElementById('download-ics').addEventListener('click', () => {
        fetch(
            `${window.location.protocol}//${window.location.hostname}${
                window.location.port === '3000' ? ':3000' : ''
            }/api/schedules?crns=${getCart().join(',')}`
        )
            .then(resp => resp.text())
            .then(text => {
                const blob = new Blob([text], { type: 'text/calendar;charset=utf-8' })
                saveAs(blob, 'GMU Schedule.ics')
            })
    })
}

window.addEventListener('DOMContentLoaded', initPage)

function setInitialLinks() {
    getCart().forEach(writeLink)
}

function addListeners() {
    const links = Array.from(document.querySelectorAll('.add-section'))
    for (const link of links) {
        link.addEventListener('click', e => {
            e.preventDefault()
            const crn = link.dataset.crn
            toggleSection(crn)
            writeLink(crn)
        })
    }
}

function getCart() {
    return JSON.parse(localStorage.getItem('cart') || '[]')
}

function toggleSection(crn) {
    if (getCart().includes(crn)) {
        removeSection(crn)
    } else {
        addSection(crn)
    }
    console.log(getCart())
    document.querySelector('#count').innerText = getCart().length
}

function addSection(crn) {
    const newCart = [...getCart(), crn]
    localStorage.setItem('cart', JSON.stringify(newCart))
}

function removeSection(crn) {
    const newCart = getCart().filter(c => c !== crn)
    localStorage.setItem('cart', JSON.stringify(newCart))
}

function writeLink(crn) {
    const item = document.querySelectorAll(`[data-crn="${crn}"]`)
    if (item.length == 0) return
    item.forEach(item => {
        const icon = item.querySelector('.add-remove-link a i')
        const link = item.querySelector('.add-remove-link a span')
        if (getCart().includes(crn)) {
            link.innerText = ' Remove from cart'
            icon.className = 'fas fa-minus'
        } else {
            link.innerText = ' Add Section to Cart'
            icon.className = 'fas fa-plus'
        }
    })
}

const elementFromString = string => {
    const html = new DOMParser().parseFromString(string, 'text/html')
    return html.body
}
