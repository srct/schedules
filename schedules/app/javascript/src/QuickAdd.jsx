import React from 'react';
import Cart from 'src/Cart';

export default class QuickAdd extends React.Component {
    constructor(props) {
        super(props);
        this.state = { crns: '' };
    }

    add = e => {
        e.preventDefault();
        const crns = this.state.crns.split(',');
        crns.forEach(c => c.length === 5 && Cart.addCrn(c));
        this.props.loadCalendar();
    };

    render() {
        return (
            <div>
                <h3 className="quick-add-header">Quick add</h3>
                <p>Want to quickly generate a calendar populated with your semester's classes? Enter the CRNs in a comma separated list below.</p>
                <form onSubmit={this.add} className="form">
                    <div className="input-group">
                        <input
                            id="crns"
                            name="crns"
                            type="text"
                            value={this.state.crns}
                            onChange={e => this.setState({ crns: e.target.value })}
                            className="form-control"
                            placeholder="12345,54321,..."
                            aria-describedby="basic-addon2"
                            autoComplete="off"
                        />
                        <div className="input-group-append">
                            <button type="submit" className="btn btn-primary" type="button">
                                Populate Calendar
                            </button>
                        </div>
                    </div>
                </form>
            </div>
        );
    }
}
