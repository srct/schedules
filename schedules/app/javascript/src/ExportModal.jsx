import React from 'react';
import Cart from 'src/Cart';
import { saveAs } from 'file-saver';

export default class extends React.Component {
    render() {
        return (
            <div
                className="modal fade"
                id="exportModal"
                tabindex="-1"
                role="dialog"
                aria-labelledby="exportModalLabel"
                aria-hidden="true">
                <div className="modal-dialog" role="document">
                    <div className="modal-content">
                        <div className="modal-header">
                            <h5 className="modal-title" id="exportModalLabel">
                                Your calendar has been generated! <br /> (Click on the options below to see further
                                instructions)
                            </h5>
                            <button type="button" className="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div className="modal-body">
                            <button
                                type="button"
                                className="btn-variant"
                                data-toggle="collapse"
                                data-target="#apple-info">
                                {' '}
                                <h5> Apple Calendar </h5>{' '}
                            </button>
                            <div id="apple-info" className="collapse">
                                To add your schedule to Apple Calendar, click the "Add to calendar" button below. If you
                                are on a device running macOS or iOS, this will open a dialogue which will walk you
                                through adding the calendar.
                            </div>
                            <hr />
                            <button
                                type="button"
                                className="btn-variant"
                                data-toggle="collapse"
                                data-target="#google-info">
                                {' '}
                                <h5>Google Calendar</h5>{' '}
                            </button>
                            <div id="google-info" className="collapse">
                                <strong>On desktop:</strong>
                                <br />
                                First, download the calendar file using the "Download calendar file" below. Open your{' '}
                                <a href="https://calendar.google.com/" target="_blank">
                                    Google Calendar
                                </a>
                                . Click the "Settings" button in the top right, and then click the Settings tab. In the
                                menu on the left, click "Import & export" and "Import". Now, upload the calendar file
                                you downloaded and click "Import".
                                <br />
                                <strong>On mobile (Android only):</strong>
                                <br />
                                Click the "Download calendar file" button. This will download the calendar file which
                                you may then open and add to your calendar.
                                <br />
                            </div>
                            <hr />
                            <button
                                type="button"
                                className="btn-variant"
                                data-toggle="collapse"
                                data-target="#outlook-info">
                                {' '}
                                <h5>Outlook Calendar</h5>{' '}
                            </button>
                            <div id="outlook-info" className="collapse">
                                <button
                                    type="button"
                                    className="btn-variant"
                                    data-toggle="collapse"
                                    data-target="#outlook-desktop">
                                    {' '}
                                    <strong>On desktop (Windows):</strong>{' '}
                                </button>
                                <br />
                                <div id="outlook-desktop" className="collapse">
                                    First, download the calendar file using the “Download calendar file” button below.
                                    In Outlook, choose File, then Open and Export, and then Import/Export. In the Import
                                    and Export Wizard Box, choose “Import and iCalendar (.ics) or vCalendar file (.vcs)”
                                    and the “next” button. Search for the button you downloaded in the beginning. Click
                                    “Okay” and then “Import.”
                                </div>
                                <br />

                                <button
                                    type="button"
                                    className="btn-variant"
                                    data-toggle="collapse"
                                    data-target="#outlook-mac">
                                    {' '}
                                    <strong>On desktop (Mac):</strong>{' '}
                                </button>
                                <br />
                                <div id="outlook-mac" className="collapse">
                                    First, download the calendar file using the “Download calendar file” button below.
                                    Open Outlook and make sure the calendar in which you want to import the file into
                                    has a checkmark next to it. Alternatively, you can add it into a new calendar by
                                    clicking the “Organize” tab and then the “New Calendar” button. Double click the new
                                    Calendar to rename it. Open the Finder application and search for the file you
                                    downloaded in the beginning. Then, drag and drop the file into the desired Calendar
                                    area.
                                </div>
                                <br />

                                <button
                                    type="button"
                                    className="btn-variant"
                                    data-toggle="collapse"
                                    data-target="#outlook-classNameic">
                                    {' '}
                                    <strong>Outlook Online (ClassNameic Layout)</strong>{' '}
                                </button>
                                <br />
                                <div id="outlook-classNameic" className="collapse">
                                    To check if you are using the ClassNameic Layout, look in the top right and see if
                                    “The new Outlook” bar is slid to the left. If it is not, you may consider reading
                                    “The New Outlook Layout” instructions or clicking the bar to slide it to the left.
                                    First, download the calendar file using the “Download calendar file” button below.
                                    Login onto your{' '}
                                    <a href="https://outlook.live.com/owa/" target="blank">
                                        Outlook
                                    </a>{' '}
                                    and click the calendar icon on the bottom left. On the menu bar, located above the
                                    Calendar, choose the “Add Calendar” menu. From the drop down menu, click import from
                                    file and browse for the calendar file you downloaded in the beginning. Click the
                                    save icon, then the calendar will be imported.
                                </div>
                                <br />

                                <button
                                    type="button"
                                    className="btn-variant"
                                    data-toggle="collapse"
                                    data-target="#outlook-new">
                                    {' '}
                                    <strong>Outlook Online (New Outlook Layout)</strong>{' '}
                                </button>
                                <br />
                                <div id="outlook-new" className="collapse">
                                    To check if you are using the New Outlook Layout, look in the top right and see if
                                    “The new Outlook” bar is slid to the right. If it is not, you may consider reading
                                    the “ClassNameic Layout” instructions or clicking the bar to slide it to the right.
                                    First download the calendar file using the “Download calendar file” button below.
                                    Login onto your{' '}
                                    <a href="https://outlook.live.com/owa/" target="blank">
                                        Outlook
                                    </a>{' '}
                                    and click the calendar icon on the bottom left. On the left side bar, under
                                    “Calendars”, click the “Discover calendars” button. Choose on the “From File” menu
                                    under the “Import” Section. Then click the browse button and search for the file you
                                    downloaded in the beginning. Lastly, choose “Import” and your calendar will be
                                    displayed.
                                </div>
                            </div>
                            <br />
                            <hr />
                            <h5>.ics file</h5>
                            To download a .ics file containing your schedule, click the "Download calendar file" button
                            below.
                        </div>
                        <div className="modal-footer flex">
                            <button
                                id="download-ics"
                                type="button"
                                className="btn btn-secondary"
                                onClick={this.downloadIcs}>
                                Download calendar file
                            </button>
                            <button
                                id="add-to-system"
                                type="button"
                                className="btn btn-primary"
                                onClick={this.addToSystemCalendar}>
                                Add to system calendar
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        );
    }

    downloadIcs = async () => {
        const response = await fetch(
            `${window.location.protocol}//${window.location.hostname}${
                window.location.port === '3000' ? ':3000' : ''
            }/api/schedules?crns=${Cart.crns.join(',')}`
        );
        const text = await response.text();
        const blob = new Blob([text], { type: 'text/calendar;charset=utf-8' });
        saveAs(blob, 'GMU Schedule.ics');
    };

    addToSystemCalendar = () => {
        window.open(
            `webcal://${window.location.hostname}${
                window.location.port === '3000' ? ':3000' : ''
            }/api/schedules?crns=${Cart.crns.join(',')}`
        );
    };
}
