// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// import Cart from 'src/cart';

// /**
//  * Toggles the display of the schedule
//  */
// const toggleSections = course => {
//     const sections = course.querySelector('.sections');
//     const chev = $(course.querySelector('#course-chevron'));
//     const label = course.querySelector('#chevron-label');

//     if (sections.style.display === 'flex') {
//         sections.style.display = 'none';
//         chev.addClass('fa-chevron-down').removeClass('fa-chevron-up');
//         label.innerText = 'Expand';
//     } else {
//         sections.style.display = 'flex';
//         chev.addClass('fa-chevron-up').removeClass('fa-chevron-down');
//         label.innerText = 'Minimize';
//     }
// };

import React from 'react';
import ReactDOM from 'react-dom';
import SearchList from 'src/SearchList';

document.addEventListener('DOMContentLoaded', () => {
    ReactDOM.render(<SearchList courses={gon.courses} instructors={gon.instructors} />, document.getElementById('root'));
});
