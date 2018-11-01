// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require FileSaver
//= require cart

// require_tree .
// require jquery3
// require popper
// require bootstrap-sprockets
// require rails-ujs

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
