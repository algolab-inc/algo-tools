var CalendarReportBox = React.createClass({
  getInitialState: function() {
    return {
      eventSummaries: {},
      eventSummaryIds: {},
      currentSummaries: {},
      currentChildren: {},
      currentParents: [],
      hasData: true,
      hasError: false,
      isPieChart: true
    }
  },
  componentDidMount: function() {
    $.ajax({
      url: this.props.url,
      dateType: 'json',
      success: function(eventSummaries) {
        if (Object.keys(eventSummaries.ids).length > 1) {
          this.setState({
            eventSummaries: eventSummaries.trees,
            eventSummaryIds: eventSummaries.ids,
            currentSummaries: eventSummaries.trees[1]['top'],
            currentChildren: eventSummaries.trees[2] || {},
            currentParents: this.getParents(eventSummaries.ids['top'])
          });
        } else {
          this.setState({
            hasData: false
          });
        }
      }.bind(this),
      error: function(xhr, status, err) {
        this.setState({
          hasData: false,
          hasError: true
        });
      }.bind(this)
    })
  },
  getParents: function(summary) {
    var parents = [];
    while (summary) {
      parents.unshift(summary);
      summary = this.state.eventSummaryIds[summary.parent_id]
    }
    return parents;
  },
  handleSummaryClick: function(summary) {
    this.setState({
      currentSummaries: this.state.eventSummaries[summary.depth + 1][summary.id],
      currentChildren: this.state.eventSummaries[summary.depth + 2] || {},
      currentParents: this.getParents(summary)
    });
  },
  handleToggleClick: function() {
    this.setState({
      isPieChart: !this.state.isPieChart
    });
  },
  render: function() {
    return (
      <div>
        <div className="row">
          <div className="col-lg-12">
            <ErrorMessage hasError={this.state.hasError} />
          </div>
          <div className="col-lg-12">
            <EventSummaryBreadcrumb parents={this.state.currentParents}
                                    onSummaryClick={this.handleSummaryClick} />
          </div>
          <div className="col-lg-12 text-center">
            <EventSummaryToggleButton isPieChart={this.state.isPieChart} onToggleClick={this.handleToggleClick} />
          </div>
          <div className="col-lg-12">
            <EventSummaryChart summaries={this.state.currentSummaries}
                               isPieChart={this.state.isPieChart} />
          </div>
          <div className="col-lg-12">
            <EventSummaryList summaries={this.state.currentSummaries}
                              children={this.state.currentChildren}
                              onSummaryClick={this.handleSummaryClick} />
          </div>
        </div>
      </div>
    );
  }
});
