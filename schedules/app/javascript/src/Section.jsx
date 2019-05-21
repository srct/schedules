import React from 'react';
import Cart from 'src/Cart';
import Stars from 'src/Stars';

export default class Section extends React.Component {
  constructor(props) {
    super(props);
    this.state = { inCart: Cart.includesCrn(this.props.crn) };
  }

  onClick = e => {
    e.stopPropagation();

    if (this.props.readOnly) return;

    console.log(e.target.tagName);
    if (e.target.tagName === 'A') return; // if we clicked on a link, don't add the section to the cart

    Cart.toggleCrn(this.props.crn);
    this.setState({ inCart: Cart.includesCrn(this.props.crn) });

    this.props.onClick && this.props.onClick(this.props.crn);
  };

  render() {
    const {
      name,
      title,
      crn,
      readOnly,
      instructor_name,
      instructor_url,
      teaching_rating,
      location,
      days,
      start_time,
      end_time,
    } = this.props;
    const { inCart } = this.state;

    const percent = teaching_rating ? (
      <Stars percent={(teaching_rating[0] / 5) * 100} />
    ) : null;

    const remove = (
      <span
        className="float-right text-center add-remove-btn"
        style={inCart ? {} : { display: 'none' }}>
        <i id="icon" className="fas fa-minus" />
        <br />
        <span className="text">Remove</span>
      </span>
    );
    const add = (
      <span
        className="float-right text-center add-remove-btn"
        style={inCart ? { display: 'none' } : {}}>
        <i id="icon" className="fas fa-plus" />
        <br />
        <span className="text">Add</span>
      </span>
    );

    return (
      <li className="list-group-item section-item" onClick={this.onClick}>
        <p>
          <b>{name}</b>: {title}{' '}
          <em>
            (#
            {crn})
          </em>
        </p>
        {!readOnly && (
          <div>
            {remove}
            {add}
          </div>
        )}
        <i className="fas fa-chalkboard-teacher" />{' '}
        {instructor_name !== 'TBA' ? (
          <span>
            <a href={instructor_url}>{instructor_name}</a> {percent}
          </span>
        ) : (
          <span>{instructor_name}</span>
        )}
        <br />
        <i className="fas fa-map-marker-alt" /> {location} <br />
        <i className="fas fa-clock" /> {days}, {start_time} - {end_time} <br />
      </li>
    );
  }
}
