class DocsController < ApplicationController
  def terms
    Date.parse(Settings.application.release_date).tap {|date|
      @release_date  = date.strftime('%Y年%m月%d日')
      @release_month = date.strftime('%Y年%m月')
    }
    @author = Settings.application.author.ja
  end
end
