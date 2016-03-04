var EventSummaryToggleButton = React.createClass({
  handleClick: function(e) {
    if (e.target.parentElement.className != 'disabled') {
      this.props.onToggleClick();
    }
  },
  render: function() {
    return (
      <ul className='pagination pagination-sm'>
        <li className={this.props.isPieChart ? 'disabled' : ''}>
          <a onClick={this.handleClick}>通算割合</a>
        </li>
        <li className={this.props.isPieChart ? '' : 'disabled'}>
          <a onClick={this.handleClick}>日別推移</a>
        </li>
      </ul>
    );
  }
});
