import React from 'react';

const ShareModal = props => {
    return (
        <div
            className="modal fade"
            id="shareModal"
            tabindex="-1"
            role="dialog"
            aria-labelledby="shareModalLabel"
            aria-hidden="true">
            <div className="modal-dialog" role="document">
                <div className="modal-content">
                    <div className="modal-header">
                        <h5 className="modal-title">Share your schedule!</h5>
                    </div>
                    <div className="modal-body">
                        The following link contains a copy of your schedule: <br />
                        <a id="shareLink" href={props.link}>
                            {props.link}
                        </a>
                    </div>
                </div>
            </div>
        </div>
    );
};

export default ShareModal;
