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
//= require rails-ujs
//= require turbolinks
//= require FileSaver
//= require_tree .
// require jquery3
// require popper
// require bootstrap-sprockets

const elementFromString = string => {
    const html = new DOMParser().parseFromString(string, 'text/html');
    return html.body.firstChild;
};

document.addEventListener('DOMContentLoaded', () => {
    this.schedule = new Schedule();
});

const setSemester = async select => {
    const resp = await fetch(`/sessions/update?semester_id=${select.value}`);
    location.reload(true);
};

/** Loads FontAwesome icons on load; fixes weird flickering */
document.addEventListener('turbolinks:load', () => {
    FontAwesome.dom.i2svg();
});
