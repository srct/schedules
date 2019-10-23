// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

import 'url-polyfill'

import Turbolinks from 'turbolinks'
Turbolinks.start()

window.addEventListener('turbolinks:load', () => {
    setInitialLinks()
    addListeners()
    document.querySelector('#count').innerText = getCart().length
})

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
    const item = document.querySelector(`[data-crn="${crn}"]`)
    if (!item) return
    const icon = item.querySelector('.add-remove-link a i')
    const link = item.querySelector('.add-remove-link a span')
    if (getCart().includes(crn)) {
        link.innerText = ' Remove from cart'
        icon.className = 'fas fa-minus'
    } else {
        link.innerText = ' Add Section to Cart'
        icon.className = 'fas fa-plus'
    }
}

const elementFromString = string => {
    const html = new DOMParser().parseFromString(string, 'text/html')
    return html.body.firstChild
}
