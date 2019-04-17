import React from 'react';
import Calendar from 'src/Calendar';
import Cart from 'src/Cart';
import SectionList from 'src/SectionList';
import QuickAdd from 'src/QuickAdd';
import moment from 'moment';

export default class CalendarPage extends React.Component {
    state = { events: [], sections: [] };

    constructor(props) {
        super(props);
        this.loadEvents();
    }

    loadEvents = async () => {
        const response = await fetch(`/schedule/events?crns=${Cart.crns.join(',')}`);
        const json = await response.json();
        this.setState({ ...json });
        Cart.crns = json.sections.map(s => s.crn);
    };

    events = () => {
        return this.state.events.filter(e => e.active).map(e => ({ ...e, start: moment(e.start).toDate(), end: moment(e.end).toDate() }));
    };

    toggleSection = crn => {
        const events = this.state.events.map(e => ({ ...e, active: e.crn == crn ? !e.active : e.active }));
        this.setState({ events });
    };

    removeAll = () => {
        Cart.crns = [];
        location.reload();
    };

    render() {
        return (
            <div>
                <Calendar events={this.events()} />
                {this.state.sections.length > 0 ? (
                    <div className="d-flex justify-content-between align-items-end">
                        <h2 className="mt-4">Your Schedule</h2>{' '}
                        <button type="button" onClick={this.removeAll} className="btn btn-danger mb-8">
                            Remove all sections
                        </button>
                    </div>
                ) : null}
                <SectionList onClick={this.toggleSection} sections={this.state.sections} expanded={true} />
                <QuickAdd loadCalendar={this.loadEvents} />
            </div>
        );
    }
}
