require 'natto'

text = 'すもももももももものうち'

natto = Natto::MeCab.new
natto.parse(text) do |n|
  puts "#{n.surface}\t#{n.feature}"
end