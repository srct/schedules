import React from 'react';
import BigCalendar from 'react-big-calendar';
import moment from 'moment';
import '!style-loader!css-loader!react-big-calendar/lib/css/react-big-calendar.css';

const localizer = BigCalendar.momentLocalizer(moment);

const Calendar = props => (
    <div style={{ backgroundColor: 'white', padding: '24px' }}>
        <BigCalendar
            localizer={localizer}
            events={props.events}
            title=""
            defaultView="week"
            views={['week', 'day']}
            startAccessor="start"
            endAccessor="end"
            defaultDate={moment('2019-01-14').toDate()}
            formats={{
                dayFormat: (date, culture, localizer) => localizer.format(date, 'ddd', culture),
                dayRangeHeaderFormat: () => '',
            }}
            style={{ height: '75vh' }}
        />
    </div>
);

export default Calendar;
