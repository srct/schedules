import * as React from 'react';

export interface Props {
    compilier: string;
    framework: string;
}

export const Hello = (props: Props) => (
    <h1>
        Hello from {props.compilier} and {props.framework}
    </h1>
);
