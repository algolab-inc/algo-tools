var EventSummaryBreadcrumb = React.createClass({
  handleSummaryClick: function(summary) {
    this.props.onSummaryClick(summary);
  },
  render: function() {
    var that = this;
    var crumbs =
      this.props.parents.length > 0
      ? this.props.parents.map(function(parent, index) {
          return (
            index < that.props.parents.length - 1
            ? <li key={parent.id}>
                <a onClick={that.handleSummaryClick.bind(that, parent)}>{parent.title}</a>
              </li>
            : <li key={parent.id} className='active'>{parent.title}</li>
          );
        })
      : <li>&nbsp;</li>
    return (
      <ul className='breadcrumb'>
        {crumbs}
      </ul>
    );
  }
});
