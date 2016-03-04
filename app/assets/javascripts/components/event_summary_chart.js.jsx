var EventSummaryChart = React.createClass({
  componentWillReceiveProps: function(props) {
    if (props.isPieChart) {
      var data = $.map(props.summaries, function(summary){
        return [[summary.title, summary.time]]
      });
      new Chartkick.PieChart("event-summary-chart", data);
    } else {
      var data = $.map(props.summaries, function(summary){
        return [{name: summary.title, data: summary.daily_data}]
      });
      new Chartkick.LineChart("event-summary-chart", data);
    }
  },
  render: function() {
    return <div id="event-summary-chart" />
  }
});
