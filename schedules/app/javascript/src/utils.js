import { saveAs } from 'file-saver'

export function buildUrl(url, protocol = window.location.protocol) {
    const port = window.location.port === '3000' ? ':3000' : ''
    return `${protocol}//${window.location.hostname}${port}${url}`
}

export function downloadIcal(url, filename) {
    fetch(url)
        .then(resp => resp.text())
        .then(text => {
            const blob = new Blob([text], { type: 'text/calendar;charset=utf-8' })
            saveAs(blob, filename)
        })
}

export function version() {
    const cached = sessionStorage.getItem('version') || ''
    const promise = fetch('https://git.gmu.edu/api/v4/projects/535/repository/tags')
        .then(response => response.json())
        .then(tags => {
            const tag = tags[0].name
            sessionStorage.setItem('version', tag)
            return tag
        })
        .catch(e => e)

    return [cached, promise]
}
