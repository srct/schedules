//= require FileSaver
//= require cart

const elementFromString = string => {
    const html = new DOMParser().parseFromString(string, 'text/html');
    return html.body.firstChild;
};

document.addEventListener('DOMContentLoaded', () => {
    this.cart = new Cart();
    initGlobalListeners();
});

const setSemester = async select => {
    const url = new URL(window.location.href);
    url.searchParams.set('semester_id', select.value);
    window.open(url.toString(), '_self');
};

const initGlobalListeners = () => {
    const semesterSelect = document.getElementById('semester-select');
    semesterSelect.onchange = () => setSemester(semesterSelect);
};
