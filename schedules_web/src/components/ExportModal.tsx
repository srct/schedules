import * as React from 'react';
import { Button, Modal, ModalHeader, ModalBody, ModalFooter } from 'reactstrap';
import { downloadFile } from '../util/utilities';

interface ExportModalProps {
    isModalOpen: boolean;
    toggleModal: () => void;
    calendarUrl: () => string;
    openCalendarAsWebcal: () => void;
    downloadIcs: () => Promise<void>;
}

/**
 * Modal view that contains buttons for exporting your schedule as
 * well as instructions for importing your schedule into different
 * calendar managers
 */
const ExportModal = ({
    isModalOpen,
    toggleModal,
    calendarUrl,
    openCalendarAsWebcal,
    downloadIcs,
}: ExportModalProps) => (
    <Modal isOpen={isModalOpen} toggle={toggleModal}>
        <ModalHeader toggle={toggleModal}>Your calendar has been generated!</ModalHeader>
        <ModalBody>
            <h5>Apple Calendar</h5>
            To add your schedule to Apple Calendar, click the "Add to calendar" button below. If you are on a device
            running macOS or iOS, this will open a dialogue which will walk you through adding the calendar.
            <hr />
            <h5>Google Calendar</h5>
            <strong>On desktop:</strong>
            <br />
            Open your <a href="https://calendar.google.com/">Google Calendar</a>. Click the "Settings" button in the top
            right, and then click the Settings tab. In the menu on the left, click "Add calendar" and "From URL". Now,
            paste the following link inside the text box: <br />
            <code>{calendarUrl()}</code>
            <br />
            <strong>On mobile (Android only):</strong>
            <br />
            Click the "Download calendar file" button. This will download the calendar file which you may then open and
            add to your calendar.
            <hr />
            <h5>.ics file</h5>
            To download a .ics file containing your schedule, click the "Download calendar file" button below.
        </ModalBody>
        <ModalFooter>
            <Button color="secondary" onClick={downloadIcs}>
                Download calendar file
            </Button>
            <Button color="primary" onClick={openCalendarAsWebcal}>
                Add to calendar
            </Button>{' '}
        </ModalFooter>
    </Modal>
);

export default ExportModal;
