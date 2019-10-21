/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

import 'url-polyfill'
import Turbolinks from 'turbolinks'

window.addEventListener('DOMContentLoaded', () => {
    Turbolinks.start()
    setLinks()
    addListeners()
})

function setLinks(crns) {}

function addListeners() {
    const links = Array.from(document.querySelectorAll('.add-section'))
    for (const link of links) {
        link.addEventListener('click', e => {
            e.preventDefault()
            const crn = link.dataset.crn
            toggleSection(crn)
            console.log(getCart())
            writeLinks()
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
}

function addSection(crn) {
    const newCart = [...getCart(), crn]
    localStorage.setItem('cart', JSON.stringify(newCart))
}

function removeSection(crn) {
    const newCart = getCart().filter(c => c !== crn)
    localStorage.setItem('cart', JSON.stringify(newCart))
}

function writeLinks() {}

const elementFromString = string => {
    const html = new DOMParser().parseFromString(string, 'text/html')
    return html.body.firstChild
}

if (!HTMLCanvasElement.prototype.toBlob) {
    Object.defineProperty(HTMLCanvasElement.prototype, 'toBlob', {
        value: function(callback, type, quality) {
            var canvas = this
            setTimeout(function() {
                var binStr = atob(canvas.toDataURL(type, quality).split(',')[1]),
                    len = binStr.length,
                    arr = new Uint8Array(len)

                for (var i = 0; i < len; i++) {
                    arr[i] = binStr.charCodeAt(i)
                }

                callback(new Blob([arr], { type: type || 'image/png' }))
            })
        },
    })
}
