crumb :home do
  link 'ホーム', root_path
end

Tool.all.each do |tool|
  eval <<-EOS
    crumb :#{tool.key} do
      link '#{tool.title}', '/#{tool.key}'
      parent :home
    end
  EOS
end

crumb :calendar_report do |calendar_report|
  link calendar_report.title, calendar_report_path(calendar_report)
  parent :calendar_reports
end
