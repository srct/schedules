import React from 'react';
import Calendar from 'src/Calendar';
import Cart from 'src/Cart';
import SectionList from 'src/SectionList';
import ExportModal from 'src/ExportModal';
import QuickAdd from 'src/QuickAdd';
import moment from 'moment';
import 'url-polyfill';

const params = new URLSearchParams(document.location.search);
const crns = params.get('crns');

export default class CalendarPage extends React.Component {
    state = { events: [], sections: [] };

    constructor(props) {
        super(props);
        this.loadEvents();
    }

    loadEvents = async () => {
        const response = await fetch(`/schedule/events?crns=${crns}`);
        const json = await response.json();
        this.setState({ ...json });
    };

    events = () => {
        return this.state.events.map(e => ({ ...e, start: moment(e.start).toDate(), end: moment(e.end).toDate() }));
    };

    render() {
        return (
            <div className="container">
                <Calendar events={this.events()} />
                {this.state.sections.length > 0 ? (
                    <div className="d-flex justify-content-between align-items-end">
                        <h2 className="mt-4">Schedule</h2>{' '}
                    </div>
                ) : null}
                <SectionList readOnly={true} sections={this.state.sections} expanded={true} />
            </div>
        );
    }
}
