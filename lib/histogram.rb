# encoding: utf-8
class Histogram
  include Enumerable

  def initialize(*words)
    @data = Hash.new(0.0)
    @count = 0
    words.each {|w| self << w }
  end

  def [](key)
    @data[key] / @data.length
  end

  def count(key)
    @data[key]
  end

  def <<(key)
    if key.is_a?(Enumerable)
      key.each{|d| add(d) }
    else
      add(key)
    end
  end

  def +(other)
    r = self.clone
    other.each{|k,v|
      r.add(k, v, false)
    }
    r
  end

  def merge(other)
    other.each_count{|k,v|
      @data[k]+=v
    }
  end

  def each
    @data.each{ |k,v| yield(k, v) }
  end

  def words
    @data.keys
  end

  def stats
    {
      :word_count => @count,
      :unique => @data.keys.length,
      :mean => word_lengths.mean,
      :median => word_lengths.median,
      :squares => word_lengths.squares,
      :variance => word_lengths.variance,
      :deviation => word_lengths.deviation
    }
  end

  def long_words
    upper = (word_lengths.median + word_lengths.deviation).floor
    words.find_all{|w| w.length >= upper}
  end

  def short_words
    lower = (word_lengths.median - word_lengths.deviation).ceil
    words.find_all{|w| w.length <= lower}
  end

  def to_s
    self.map{|k,v| "#{k}:#{v}" }.join(', ')
  end

  def scores
    s = []
    return s if @data.empty?
    unique = @data.keys.length
    l_words = long_words
    s_words = short_words
    base = unique.to_f / @count.to_f
    @data.each {|word, value|
      score = base
      score = score * 2.0 if l_words.include?(word)
      score = score * 2.0 if s_words.include?(word)
      score = score * value #mehrfaches vorkommen wird belohnt
      score = score * 0.66 if value==1
      s << [word, score]
    }
    return s.find_all{|a| a[1]>=base}
  end

  def top(count=10)
    top = scores.sort{|a, b| -1*(a[1]<=>b[1]) }
    Hash.new.tap do |map|
      top[0...count].each{ |word, value| map[word] = value }
    end
  end

  def add(word, num=1)
    @data[word]+=num
    @count += num
  end

  private

  def word_lengths
    @word_lengths ||= @data.collect{|k, v| k.length}
  end

end
