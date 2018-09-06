import * as React from 'react';
import { Button, Modal, ModalHeader, ModalBody, ModalFooter } from 'reactstrap';

interface Props {
    isModalOpen: boolean;
    toggleModal: () => void;
}

class ExportModal extends React.Component<Props, {}> {
    render() {
        const { isModalOpen, toggleModal } = this.props;
        return (
            <Modal isOpen={isModalOpen} toggle={toggleModal}>
                <ModalHeader toggle={toggleModal}>Your calendar has been generated!</ModalHeader>
                <ModalBody>
                    Here are instructions for adding you calendar to a bunch of different calendar managers.
                </ModalBody>
                <ModalFooter>
                    <Button color="secondary" onClick={toggleModal}>
                        Download calendar file
                    </Button>
                    <Button color="primary" onClick={toggleModal}>
                        Add to calendar
                    </Button>{' '}
                </ModalFooter>
            </Modal>
        );
    }
}

export default ExportModal;
