require 'rubygems'
require 'bundler/setup'

require 'sinatra'

require_relative 'ext/PDFlib'

set :raise_errors => true

get '/' do
  content_type 'application/pdf'

  p = PDFlib.new
  p.set_option("errorpolicy=return")
  p.set_option("stringformat=utf8")
  p.begin_document("", "")
  p.set_info("Creator", "hello.rb")
  p.set_info("Author", "Thomas Merz")
  p.set_info("Title", "Hello world (Ruby)!")
  p.begin_page_ext(595, 842, "")
  font = p.load_font("Helvetica-Bold", "unicode", "")
  p.setfont(font, 24)
  p.set_text_pos(50, 700)
  p.show("Hello world!")
  p.continue_text("(says Anynines, PDFlib and Sinatra)")
  p.end_page_ext("")
  p.end_document("")

  p.get_buffer()
end
