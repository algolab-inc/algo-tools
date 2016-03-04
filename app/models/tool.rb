class Tool < ActiveHash::Base
  self.data = [
    {
      key: 'calendar_reports',
      title: '時間の使い方チェッカー',
      lead: 'Googleカレンダーを解析して時間の使い方を可視化するツール',
    }
  ]
end
