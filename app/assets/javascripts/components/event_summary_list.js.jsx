var EventSummaryList = React.createClass({
  handleSummaryClick: function(summary) {
    this.props.onSummaryClick(summary);
  },
  render: function() {
    var that = this;
    var total = 0.0;
    var summaries = $.map(this.props.summaries, function(summary) {
      total += summary.time;
      return (
        <tr key={summary.id}>
          <td>
            {
              summary.id in that.props.children
              ? <a onClick={that.handleSummaryClick.bind(that, summary)}>{summary.title}</a>
              : summary.title
            }
          </td>
          <td className="number">{summary.time.toFixed(2)}</td>
        </tr>
      );
    });
    return (
      <table className="table table-bordered table-striped table-hover">
        <thead>
          <tr>
            <th>タイトル</th>
            <th>時間</th>
          </tr>
        </thead>
        <tbody>
          {summaries}
          <tr className="sum">
            <td>合計</td>
            <td className="number">{total.toFixed(2)}</td>
          </tr>
        </tbody>
      </table>
    );
  }
});
