class Schedule {
    constructor() {
        this.isOpen = false;
        this._courses = {}; // {title, id, sections: {id, crn}}

        const cartData = document.querySelector('#cart-data');
        const courses = Array.from(cartData.content.children);
        for (const course of courses) {
            const { id, title } = course.dataset;
            const sections = Array.from(course.children).map(node => ({ ...node.dataset }));
            this._courses[id] = { id, title, sections };
        }
        document.getElementById('course-counter').innerText = Object.keys(this._courses).length;

        this._ids = Array.from(document.getElementById('schedule').children).map(e => e.dataset.crn);
    }

    get crns() {
        return Object.keys(this._courses)
            .map(cid => this._courses[cid].sections.map(s => s.crn))
            .reduce((prev, curr) => [...prev, ...curr], []);
    }

    get ids() {
        return Object.keys(this._courses)
            .map(cid => this._courses[cid].sections.map(s => s.id))
            .reduce((prev, curr) => [...prev, ...curr], []);
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

    addCourse(course) {
        this._courses[course.id] = course;

        const parent = document.querySelector('#schedule');
        const current = parent.querySelector(`#schedule-${course.id}`);

        const newNode = this._constructCourseNode(course);
        if (current !== null) parent.replaceChild(newNode, current);
        else parent.appendChild(newNode);

        document.getElementById('course-counter').innerText = Object.keys(this._courses).length;
        fetch(`/sessions/update?section_ids=${this.ids.join(',')}`, { cache: 'no-store' });
    }

    removeCourse(id) {
        const sectionIds = this._courses[id].sections.map(s => s.id);
        for (const sectionId of sectionIds) {
            const sectionCard = document.querySelector(`#section-${sectionId}`);
            sectionCard && sectionCard.classList.remove('selected');
        }

        delete this._courses[id];

        const parent = document.querySelector('#schedule');
        const current = parent.querySelector(`#schedule-${id}`);
        parent.removeChild(current);

        document.getElementById('course-counter').innerText = Object.keys(this._courses).length;
        fetch(`/sessions/update?section_ids=${this.ids.join(',')}`, { cache: 'no-store' });
    }

    courseContainingSection(id) {
        for (const courseId in this._courses) {
            const course = this._courses[courseId];
            for (const section of course.sections) {
                if (section.id == id) return course;
            }
        }
        return undefined;
    }

    includesSection(id) {
        return !!this.courseContainingSection(id);
    }

    // section: { id, crn }
    addSection(section) {
        const course = this._courses[section.cid];
        if (course) {
            course.sections.push(section);

            const courseNode = document.querySelector('#schedule').querySelector(`#schedule-${course.id}`);
            const crnList = courseNode.querySelector('.crns');
            crnList.innerText = course.sections.map(s => `#${s.crn}`);

            fetch(`/sessions/update?section_ids=${this.ids.join(',')}`, { cache: 'no-store' });
        } else {
            const courseCard = document.getElementById(`course-${section.cid}`);
            const title = courseCard.querySelector('#title').innerText;

            this.addCourse({ title, id: section.cid, sections: [section] });
        }
    }

    removeSection(section) {
        const course = this.courseContainingSection(section.id);
        course.sections = course.sections.filter(s => s.id !== section.id);
        const schedule = document.querySelector('#schedule');
        const courseNode = schedule.querySelector(`#schedule-${course.id}`);
        const crnList = courseNode.querySelector('.crns');
        if (course.sections.length === 0) {
            this.removeCourse(section.cid);
        } else {
            crnList.innerText = course.sections.map(s => `#${s.crn}`);
        }

        fetch(`/sessions/update?section_ids=${this.ids.join(',')}`, { cache: 'no-store' });
    }

    async downloadIcs() {
        const cal = await fetch(`/api/schedules?crns=${this.crns.join(',')}`);
        const text = await cal.text();
        var blob = new Blob([text], { type: 'text/calendar;charset=utf-8' });
        saveAs(blob, 'test.ics');
    }

    async addToSystemCalendar() {
        const url = `webcal://${window.location.hostname}/api/schedule?crns=${this.crns.join(',')}`;
        window.open(url, '_self');
    }

    _constructCourseNode(course) {
        let html = `<li id="schedule-${course.id}" class="list-group-item schedule-section-card" onclick="removeCourse(${course.id})">`;
        html += `<div style="display: flex; justify-content: space-between;">`;
        html += `<b style="min-width: 15%">${course.title}</b>`;
        html += `<span class="crns" style="color: gray; font-size: 10pt;">`;
        html += course.sections.map(s => `#${s.crn}`).join(', ');
        html += `</span>`;
        html += `</div>`;
        html += `</li>`;

        return elementFromString(html);
    }
}

const removeCourse = id => {
    this.schedule.removeCourse(id);
};
