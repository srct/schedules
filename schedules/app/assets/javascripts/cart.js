class Cart {
    constructor() {
        this.isOpen = false;
        this._courses = {};
    }

    toggle() {
        const list = document.getElementById('cart');
        const icon = document.getElementById('schedule-icon');

        if (this.isOpen) {
            list.style.display = 'none';
            icon.style.color = 'black';
        } else {
            list.style.display = 'block';
            icon.style.color = 'green';
        }

        this.isOpen = !this.isOpen;
    }

    set courses(courses) {
        this._courses = courses;
        for (const courseId in this._courses) {
            if (this._courses[courseId].length === 0) delete this._courses[courseId];
        }
        console.log(courses);
        document.getElementById('course-counter').innerText = Object.keys(this._courses).length;
    }

    async addSections(sections) {
        const resp = await fetch(`/sessions/cart?course_id=${sections[0].cid}&section_ids=${sections.map(s => s.id).join(',')}`, { cache: 'no-store' });
        const json = await resp.json();
        this.courses = json;
    }

    async addPair(sections) {
        const resp = await fetch(`/sessions/cart?course_id=${sections[0].cid}&pair_ids=${sections[0].id},${sections[1].id}`, { cache: 'no-store' });
        const json = await resp.json();
        this.courses = json;
    }

    includesPair(pair) {
        const ids = pair.map(p => p.id);
        for (const courseId in this._courses) {
            const pairs = this._courses[courseId];
            if (!Array.isArray(pairs[0])) continue;

            for (const otherPair of pairs) {
                if (JSON.stringify(ids) == JSON.stringify(otherPair)) return true;
            }
        }

        return false;
    }

    includesSection(obj) {
        for (const key in this._courses) {
            const list = this._courses[key];
            if (list.includes(obj.id)) return true;
        }

        return false;
    }
}

// class Cart {
//     constructor() {
//         this.isOpen = false;
//         this._courses = {}; {title, id, sections: {id, crn}}

//         const cartData = document.getElementById('cart-data');
//         const courses = Array.from(cartData.content.children);
//         for (const course of courses) {
//             const { id, title } = course.dataset;
//             const sections = Array.from(course.children).map(node => ({ ...node.dataset }));
//             this._courses[id] = { id, title, sections };
//         }
//         document.getElementById('course-counter').innerText = Object.keys(this._courses).length;

//         this._ids = Array.from(document.getElementById('cart-courses').children).map(e => e.dataset.crn);
//     }

//     get crns() {
//         return Object.keys(this._courses)
//             .map(cid => this._courses[cid].sections.map(s => s.crn))
//             .reduce((prev, curr) => [...prev, ...curr], []);
//     }

//     get ids() {
//         return Object.keys(this._courses)
//             .map(cid => this._courses[cid].sections.map(s => s.id))
//             .reduce((prev, curr) => [...prev, ...curr], []);
//     }

//     toggle() {
//         const list = document.getElementById('cart');
//         const icon = document.getElementById('schedule-icon');

//         if (this.isOpen) {
//             list.style.display = 'none';
//             icon.style.color = 'black';
//         } else {
//             list.style.display = 'block';
//             icon.style.color = 'green';
//         }

//         this.isOpen = !this.isOpen;
//     }

//     addCourse(course) {
//         this._courses[course.id] = course;

//         const courseList = document.getElementById('cart-courses');
//         const courseNode = courseList.querySelector(`#schedule-${course.id}`);

//         const newNode = this._constructCourseNode(course);
//         if (courseNode !== null) courseList.replaceChild(newNode, courseNode);
//         else courseList.appendChild(newNode);

//         document.getElementById('course-counter').innerText = Object.keys(this._courses).length;
//         fetch(`/sessions/update?section_ids=${this.ids.join(',')}`, { cache: 'no-store' });
//     }

//     removeCourse(id) {
//         const sectionIds = this._courses[id].sections.map(s => s.id);
//         for (const sectionId of sectionIds) {
//             const sectionCard = document.querySelector(`#section-${sectionId}`);
//             sectionCard && sectionCard.classList.remove('selected');
//         }

//         delete this._courses[id];

//         const courseList = document.getElementById('cart-courses');
//         const current = courseList.querySelector(`#schedule-${id}`);
//         courseList.removeChild(current);

//         document.getElementById('course-counter').innerText = Object.keys(this._courses).length;
//         fetch(`/sessions/update?section_ids=${this.ids.join(',')}`, { cache: 'no-store' });
//     }

//     courseContainingSection(id) {
//         for (const courseId in this._courses) {
//             const course = this._courses[courseId];
//             for (const section of course.sections) {
//                 if (section.id == id) return course;
//             }
//         }
//         return undefined;
//     }

//     includesSection(id) {
//         return !!this.courseContainingSection(id);
//     }

//     section: { id, crn }
//     addSection(section) {
//         const course = this._courses[section.cid];
//         if (course) {
//             course.sections.push(section);

//             const courseNode = document.getElementById(`schedule-${course.id}`);
//             const crnList = courseNode.querySelector('.crns');
//             crnList.innerText = course.sections.map(s => `#${s.crn}`);

//             fetch(`/sessions/update?section_ids=${this.ids.join(',')}`, { cache: 'no-store' });
//         } else {
//             const courseCard = document.getElementById(`course-${section.cid}`);
//             const title = courseCard.querySelector('.title').innerText;

//             this.addCourse({ title, id: section.cid, sections: [section] });
//         }
//     }

//     removeSection(section) {
//         const course = this.courseContainingSection(section.id);
//         course.sections = course.sections.filter(s => s.id !== section.id);
//         const schedule = document.querySelector('#cart-courses');
//         const courseNode = schedule.querySelector(`#schedule-${course.id}`);
//         const crnList = courseNode.querySelector('.crns');
//         if (course.sections.length === 0) {
//             this.removeCourse(section.cid);
//         } else {
//             crnList.innerText = course.sections.map(s => `#${s.crn}`);
//         }

//         fetch(`/sessions/update?section_ids=${this.ids.join(',')}`, { cache: 'no-store' });
//     }

//     async downloadIcs() {
//         const cal = await fetch(`/api/schedules?crns=${this.crns.join(',')}`);
//         const text = await cal.text();
//         var blob = new Blob([text], { type: 'text/calendar;charset=utf-8' });
//         saveAs(blob, 'test.ics');
//     }

//     async addToSystemCalendar() {
//         const url = `webcal:${window.location.hostname}/api/schedule?crns=${this.crns.join(',')}`;
//         window.open(url, '_self');
//     }

//     _constructCourseNode(course) {
//         let html = `<li id="schedule-${course.id}" class="list-group-item schedule-section-card" onclick="removeCourse(${course.id})">`;
//         html += `<div style="display: flex; justify-content: space-between;">`;
//         html += `<b style="min-width: 15%">${course.title}</b>`;
//         html += `<span class="crns" style="color: gray; font-size: 10pt;">`;
//         html += course.sections.map(s => `#${s.crn}`).join(', ');
//         html += `</span>`;
//         html += `</div>`;
//         html += `</li>`;

//         return elementFromString(html);
//     }
// }

// const removeCourse = id => {
//     this.cart.removeCourse(id);
// };
