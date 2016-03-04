class Error < ActiveHash::Base
  self.data = [
    {
      code: 404,
      title: '404 Not Found',
      message: 'お探しのページは見つかりませんでした。'
    },
    {
      code: 422,
      title: '422 Unprocessable Entity',
      message: '処理を完了できませんでした。しばらくしてからもう一度お試しください。'
    },
    {
      code: 500,
      title: '500 Internal Server Error',
      message: 'エラーが発生しました。しばらくしてからもう一度お試しください。'
    }
  ]
end
