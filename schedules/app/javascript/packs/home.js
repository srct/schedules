import React from 'react';
import ReactDOM from 'react-dom';
import Cart from 'src/Cart';
import QuickAdd from 'src/QuickAdd';

document.addEventListener('DOMContentLoaded', () => {
    const calendarUrl = `${window.location.protocol}//${window.location.hostname}${window.location.port == 3000 ? ':3000' : ''}/schedule`;
    ReactDOM.render(
        <QuickAdd
            loadCalendar={() => {
                window.location.href = calendarUrl;
            }}
        />,
        document.getElementById('quick-add')
    );
});
