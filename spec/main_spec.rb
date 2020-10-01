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

  # my_each_with_index method
  describe 'my_each_with_index' do
    it 'when an array is given it loop through an array and return each item with index ' do
      expect(array.my_each_with_index { |item, index| puts "#{item} is #{index}" }). to equal(array.each_with_index { |item, index| puts "#{item} is #{index}" })
    end

    it 'when an range is given it loop through the range and return each item with index ' do
      expect(range.my_each_with_index { |item, index| puts "#{item} is #{index}" }). to equal(range.each_with_index { |item, index| puts "#{item} is #{index}" })
    end

    it 'when a hash is given it loop through the hash and return each item with index ' do
      expect(hash.my_each_with_index { |item, index| puts "#{item} is #{index}" }). to equal(hash.each_with_index { |item, index| puts "#{item} is #{index}" })
    end
    it 'when a block is not given it returns an enumerator' do
      expect(array.my_each_with_index). to be_a(Enumerator)
    end
  end

  # my_select

  describe '#my_select' do
    it 'when a array is given it loops through the array and return the item that match given condition' do
      expect(array.my_select(&:odd?)).to eq([1, 3, 5, 7])
    end

    it 'when a range is given it loops through the range and return the item that match given condition' do
      expect(range.my_select(&:odd?)).to eq([1, 3, 5, 7, 9])
    end

    it 'when a hash is given it loops through the hash and return the item that match given condition' do
      expect(hash.my_select { |_item, value| value > 1200 }).to eq([[:mar, 1500], [:apr, 1300]])
    end

    it 'when a block is not given it returns an enumerator.' do
      expect(array.my_select). to be_a(Enumerator)
    end
  end
end
