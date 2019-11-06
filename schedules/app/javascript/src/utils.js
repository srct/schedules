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
