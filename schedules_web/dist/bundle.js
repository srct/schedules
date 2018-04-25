/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};
/******/
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/
/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId]) {
/******/ 			return installedModules[moduleId].exports;
/******/ 		}
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			i: moduleId,
/******/ 			l: false,
/******/ 			exports: {}
/******/ 		};
/******/
/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);
/******/
/******/ 		// Flag the module as loaded
/******/ 		module.l = true;
/******/
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/
/******/
/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;
/******/
/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;
/******/
/******/ 	// define getter function for harmony exports
/******/ 	__webpack_require__.d = function(exports, name, getter) {
/******/ 		if(!__webpack_require__.o(exports, name)) {
/******/ 			Object.defineProperty(exports, name, {
/******/ 				configurable: false,
/******/ 				enumerable: true,
/******/ 				get: getter
/******/ 			});
/******/ 		}
/******/ 	};
/******/
/******/ 	// define __esModule on exports
/******/ 	__webpack_require__.r = function(exports) {
/******/ 		Object.defineProperty(exports, '__esModule', { value: true });
/******/ 	};
/******/
/******/ 	// getDefaultExport function for compatibility with non-harmony modules
/******/ 	__webpack_require__.n = function(module) {
/******/ 		var getter = module && module.__esModule ?
/******/ 			function getDefault() { return module['default']; } :
/******/ 			function getModuleExports() { return module; };
/******/ 		__webpack_require__.d(getter, 'a', getter);
/******/ 		return getter;
/******/ 	};
/******/
/******/ 	// Object.prototype.hasOwnProperty.call
/******/ 	__webpack_require__.o = function(object, property) { return Object.prototype.hasOwnProperty.call(object, property); };
/******/
/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "";
/******/
/******/
/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(__webpack_require__.s = "./src/index.tsx");
/******/ })
/************************************************************************/
/******/ ({

/***/ "./src/components/App.tsx":
/*!********************************!*\
  !*** ./src/components/App.tsx ***!
  \********************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

"use strict";

Object.defineProperty(exports, "__esModule", { value: true });
const React = __webpack_require__(/*! react */ "react");
const SectionList_1 = __webpack_require__(/*! ./SectionList */ "./src/components/SectionList.tsx");
const Search_1 = __webpack_require__(/*! ./Search */ "./src/components/Search.tsx");
class App extends React.Component {
    constructor(props) {
        super(props);
        this.state = { currentSchedule: [] };
        this.addSectionToCurrentSchedule = this.addSectionToCurrentSchedule.bind(this);
    }
    addSectionToCurrentSchedule(section) {
        this.setState({
            currentSchedule: [...this.state.currentSchedule, section],
        });
    }
    render() {
        return (React.createElement("div", null,
            React.createElement("h1", null, "Schedules"),
            React.createElement(Search_1.default, null),
            React.createElement(SectionList_1.default, { addToScheduleCallback: this.addSectionToCurrentSchedule }),
            React.createElement(SectionList_1.default, null)));
    }
}
exports.default = App;


/***/ }),

/***/ "./src/components/Search.tsx":
/*!***********************************!*\
  !*** ./src/components/Search.tsx ***!
  \***********************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

"use strict";

Object.defineProperty(exports, "__esModule", { value: true });
const React = __webpack_require__(/*! react */ "react");
class Search extends React.Component {
    constructor(props) {
        super(props);
        this.state = { searchTerm: '' };
        this.onSearch = this.onSearch.bind(this);
        this.updateSearchTerm = this.updateSearchTerm.bind(this);
    }
    updateSearchTerm(event) {
        this.setState({
            searchTerm: event.target.value,
        });
    }
    onSearch(event) {
        event.preventDefault();
    }
    render() {
        return (React.createElement("form", { onSubmit: this.onSearch },
            React.createElement("input", { type: "text", placeholder: "Enter CRN...", value: this.state.searchTerm, onChange: this.updateSearchTerm }),
            React.createElement("input", { type: "submit", value: "Search" })));
    }
}
exports.default = Search;


/***/ }),

/***/ "./src/components/SectionList.tsx":
/*!****************************************!*\
  !*** ./src/components/SectionList.tsx ***!
  \****************************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

"use strict";

Object.defineProperty(exports, "__esModule", { value: true });
const React = __webpack_require__(/*! react */ "react");
const section_1 = __webpack_require__(/*! ../section */ "./src/section.ts");
class SectionList extends React.Component {
    constructor(props) {
        super(props);
        this.state = { sections: [] };
        section_1.fetchSections().then(sections => this.updateStateWithSections(sections));
        this.updateStateWithSections = this.updateStateWithSections.bind(this);
    }
    updateStateWithSections(sections) {
        this.setState({
            sections,
        });
    }
    render() {
        return (React.createElement("table", null,
            React.createElement("tr", null,
                React.createElement("th", null, "Course"),
                React.createElement("th", null, "Section Name"),
                React.createElement("th", null, "CRN"),
                React.createElement("th", null, "Days"),
                React.createElement("th", null, "Instructor"),
                React.createElement("th", null, "Location"),
                React.createElement("th", null, "Time")),
            this.renderRowsForSections(this.state.sections)));
    }
    renderRowsForSections(sections) {
        return sections.map(section => {
            return (React.createElement("tr", null,
                React.createElement("td", null, section.name),
                React.createElement("td", null, section.title),
                React.createElement("td", null, section.crn),
                React.createElement("td", null, section.days),
                React.createElement("td", null, section.instructor),
                React.createElement("td", null, section.location),
                React.createElement("td", null, [section.startTime, section.endTime].join(' - '))));
        });
    }
}
exports.default = SectionList;


/***/ }),

/***/ "./src/index.tsx":
/*!***********************!*\
  !*** ./src/index.tsx ***!
  \***********************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

"use strict";

Object.defineProperty(exports, "__esModule", { value: true });
const React = __webpack_require__(/*! react */ "react");
const ReactDOM = __webpack_require__(/*! react-dom */ "react-dom");
const App_1 = __webpack_require__(/*! ./components/App */ "./src/components/App.tsx");
ReactDOM.render(React.createElement(App_1.default, null), document.getElementById('root'));


/***/ }),

/***/ "./src/section.ts":
/*!************************!*\
  !*** ./src/section.ts ***!
  \************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

"use strict";

var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : new P(function (resolve) { resolve(result.value); }).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
Object.defineProperty(exports, "__esModule", { value: true });
function fetchSections() {
    return __awaiter(this, void 0, void 0, function* () {
        const response = yield fetch('http://localhost:3001/api/courses/1/sections');
        const jsonObjects = yield response.json();
        let sections = [];
        jsonObjects.forEach((object) => {
            sections.push({
                id: object.id,
                name: object.name,
                title: object.title,
                crn: object.crn,
                instructor: object.instructor,
                location: object.location,
                days: object.days,
                startTime: object.start_time,
                endTime: object.end_time,
            });
        });
        return sections;
    });
}
exports.fetchSections = fetchSections;


/***/ }),

/***/ "react":
/*!************************!*\
  !*** external "React" ***!
  \************************/
/*! no static exports found */
/***/ (function(module, exports) {

module.exports = React;

/***/ }),

/***/ "react-dom":
/*!***************************!*\
  !*** external "ReactDOM" ***!
  \***************************/
/*! no static exports found */
/***/ (function(module, exports) {

module.exports = ReactDOM;

/***/ })

/******/ });
//# sourceMappingURL=bundle.js.map