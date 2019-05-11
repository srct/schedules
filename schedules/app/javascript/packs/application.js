/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

import '@babel/polyfill';
import 'url-polyfill';

const elementFromString = string => {
    const html = new DOMParser().parseFromString(string, 'text/html');
    return html.body.firstChild;
};

document.addEventListener('DOMContentLoaded', () => {
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
