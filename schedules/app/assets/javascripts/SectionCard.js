class SectionCard {
    constructor(section) {
        this._html = `
	      <li id="section-${section.crn}" class="list-group-item schedule-section-card" onclick="removeFromSchedule(this)">
	        <span style="float:left"><b class="subj">${section.name}</b>: ${section.title}</span>
	        <span style="float:right"><i class="fas fa-map-marker-alt"></i> ${section.location} </span>
	        <div style="clear: both"></div>
	        <span style="float:left"><i class="fas fa-chalkboard-teacher"></i> TODO </span>
	        <span style="float:right"><i class="fas fa-clock"></i> ${section.days}, ${section.start_time}-${section.end_time} </span>
	        <div style="clear: both"></div>
	      </li>`;
    }
}
