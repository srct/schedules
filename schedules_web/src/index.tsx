import 'masonstrap/build/css/masonstrap.min.css';
import 'masonstrap/build/js/masonstrap.min.js';
import {applyMiddleware, compose, createStore} from 'redux';
import ReduxThunk from 'redux-thunk';
import {Provider} from 'react-redux';
import * as React from 'react';
import * as ReactDOM from 'react-dom';
import App from './containers/App';
import { reducers } from './reducers';

declare global {
    interface Window {
        __REDUX_DEVTOOLS_EXTENSION__?: () => any;
    }
}

const extension = window.__REDUX_DEVTOOLS_EXTENSION__ && window.__REDUX_DEVTOOLS_EXTENSION__();
const isProduction = process.env.NODE_ENV === 'production';

let enhance;
if (isProduction || !extension) {
    enhance = compose(applyMiddleware(ReduxThunk));
} else {
    enhance = compose(applyMiddleware(ReduxThunk), extension);
}

const store = createStore(reducers, enhance);

ReactDOM.render(
    <Provider store={store}>
        <App />
    </Provider>, document.getElementById('root'));