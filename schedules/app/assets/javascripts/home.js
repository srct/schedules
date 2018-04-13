function search() {
    const searchTable = document.getElementById('scheduleTable');
    const crn = document.getElementById('search').value;

    fetch(`api/search?crn=${crn}`)
        .then(section => section.json())
        .then(section => addRow(searchTable, section));
}

function addRow(table, section) {
    const tr = document.createElement('tr');
    const fields = [
        section.name,
        section.title,
        section.crn,
        section.instructor,
        section.location,
        section.days,
        [section.start_time, section.end_time].join(' - '),
    ];

    fields.forEach(field => {
        const td = document.createElement('td');
        const txt = document.createTextNode(field);
        td.appendChild(txt);
        tr.appendChild(td);
    });

    table.appendChild(tr);
}
