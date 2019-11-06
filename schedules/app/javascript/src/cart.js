const subscribers = []

export function subscribe(callback) {
    subscribers.push(callback)
}

export function getCart() {
    return JSON.parse(localStorage.getItem('cart') || '[]').filter(val => !!val)
}

export function hasSection(crn) {
    return getCart().includes(crn)
}

export function toggleSection(crn) {
    if (getCart().includes(crn)) {
        removeSection(crn)
    } else {
        addSection(crn)
    }
    for (const callback of subscribers) {
        callback()
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
