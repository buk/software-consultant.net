# encoding: utf-8
require 'uglifier'

class JsCompressor
  def compress(source)
    uglifier.compile(source)
  end

  def uglifier
    @uglifier ||= Uglifier.new
  end
end
