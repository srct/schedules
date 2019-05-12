import React from 'react';
import BigCalendar from 'react-big-calendar';
import Toolbar from 'src/Toolbar';
import moment from 'moment';
import '!style-loader!css-loader!react-big-calendar/lib/css/react-big-calendar.css';
import withSizes from 'react-sizes';

const localizer = BigCalendar.momentLocalizer(moment);

const minTime = new Date();
minTime.setHours(7, 0, 0);

const maxTime = new Date();
maxTime.setHours(23, 0, 0);

const Calendar = props => (
    <div className="full-width" style={{ backgroundColor: 'white', padding: '24px' }}>
        <BigCalendar
            localizer={localizer}
            events={props.events}
            title=""
            components={{ toolbar: Toolbar }}
            defaultView="week"
            views={['week', 'day']}
            startAccessor="start"
            endAccessor="end"
            defaultDate={moment('2019-01-14').toDate()}
            formats={{
                dayFormat: (date, culture, localizer) => localizer.format(date, 'ddd', culture),
                dayHeaderFormat: (date, culture, localizer) => localizer.format(date, 'ddd', culture),
                dayRangeHeaderFormat: () => '',
            }}
            style={{ height: '75vh' }}
            min={minTime}
        />
    </div>
);

export default Calendar;
