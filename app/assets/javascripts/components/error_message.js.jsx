var ErrorMessage = React.createClass({
  render: function() {
    return (
      <div>
        {this.props.hasError
        ? <div className="alert alert-dismissible alert-warning">
            <button type="button" className="close" data-dismiss="alert">&times;</button>
            <p>エラーが発生しました。しばらくしてからもう一度お試しください。</p>
          </div>
        : null
        }
      </div>
    );
  }
});
