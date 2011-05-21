PDFKit.configure do |config|
  config.wkhtmltopdf = `which wkhtmltopdf`.to_s.strip
  config.default_options = {
    :encoding=>"UTF-8",
    :page_size=>"A4",
    :margin_top=>"0.5in",
    :margin_right=>"0.75in",
    :margin_bottom=>"0.5in",
    :margin_left=>"0.75in",
    :disable_smart_shrinking=>false
    }
end