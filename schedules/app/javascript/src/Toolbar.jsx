import React from 'react';
import BigCalendar from 'react-big-calendar';
import Toolbar from 'react-big-calendar/lib/Toolbar';
import '!style-loader!css-loader!react-big-calendar/lib/css/react-big-calendar.css';
import withSizes from 'react-sizes';

class CustomToolbar extends Toolbar {
    render() {
        const { label, isMobile } = this.props;
        if (isMobile && label === '') {
            this.view('day');
        }
        return (
            <div className="rbc-toolbar d-flex justify-content-between">
                {!isMobile && (
                    <span className="rbc-btn-group">
                        <button type="button" onClick={() => this.view('day')}>
                            Day
                        </button>
                        <button type="button" onClick={() => this.view('week')}>
                            Week
                        </button>
                    </span>
                )}

                <span className="rbc-toolbar-label">{this.props.label}</span>

                {this.props.view === 'day' && (
                    <span className="rbc-btn-group">
                        {this.props.label !== 'Sun' && (
                            <button type="button" onClick={() => this.navigate('PREV')}>
                                Back
                            </button>
                        )}
                        {this.props.label !== 'Sat' && (
                            <button type="button" onClick={() => this.navigate('NEXT')}>
                                Next
                            </button>
                        )}
                    </span>
                )}
            </div>
        );
    }

    navigate = action => {
        console.log(action);

        this.props.onNavigate(action);
    };

    view = action => {
        this.props.onView(action);
    };
}

const mapSizesToProps = ({ width }) => ({
    isMobile: width < 1000,
});

export default withSizes(mapSizesToProps)(CustomToolbar);
