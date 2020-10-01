require './lib/main.rb'

RSpec.describe Enumerable do
  include Enumerable
  let(:array) { [1, 2, 3, 4, 5, 6, 7] }
  let(:range) { (1...10) }
  let(:hash) { { jan: 1000, feb: 1200, mar: 1500, apr: 1300 } }
  let(:wordarray) { %w[cat dog bear dear rat] }
  let(:my_proc) { proc { |num| num * 3 } }
  let(:search) { proc { |memo, word| memo.length > word.length ? memo : word } }

  # my_each method
  describe '#my_each' do
    it 'when an array is given it loop through an array and return each item' do
      expect(array.my_each { |item| item }). to equal(array.each { |item| item })
    end

    it 'when a range is given it loop through the range and return each item' do
      expect(range.my_each { |item| item }). to equal(range.each { |item| item })
    end

    it 'when a block is not given it returns an enumerator' do
      expect(array.my_each). to be_a(Enumerator)
    end
  end

end
