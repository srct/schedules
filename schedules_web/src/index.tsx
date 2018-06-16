/**
 * index.tsx
 *
 * The entry point for the application. Apply global styling, configure high
 * level (global application) settings and render <App />. Simple.
 */

// Apply Global Masonstrap styling
import 'masonstrap/build/css/masonstrap.min.css';
import 'masonstrap/build/js/masonstrap.min.js';
import * as React from 'react';
import * as ReactDOM from 'react-dom';
import { Provider } from 'react-redux';
import { applyMiddleware, compose, createStore } from 'redux';
import ReduxThunk from 'redux-thunk';
import App from './components/App';
import { allReducers } from './reducers';

declare global {
    interface Window {
        __REDUX_DEVTOOLS_EXTENSION__?: () => any;
    }
}
const extension = window.__REDUX_DEVTOOLS_EXTENSION__ && window.__REDUX_DEVTOOLS_EXTENSION__();
const isProduction = process.env.NODE_ENV === 'production';

let addOns;
if (isProduction || !extension) {
    addOns = compose(applyMiddleware(ReduxThunk));
} else {
    addOns = compose(
        applyMiddleware(ReduxThunk),
        extension
    );
}

// Attach all reducers + addOns to the Redux store
const store = createStore(allReducers, addOns);

ReactDOM.render(
    <Provider store={store}>
        <App />
    </Provider>,
    document.getElementById('root')
);
