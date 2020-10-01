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

  # my_all?

    describe '#my_all?' do
      it "when an array is given then it loops through the array and return boolean value
    based on the given condition, if all the items meet the requirement" do
      expect(array.my_all? { |item| item < 0 }).to be_falsy
    end

      it "when an range is given then it loops through the range and return boolean value
      based on the given condition, if all the items meet the requirement" do
        expect(array.my_all? { |item| item > 0 }).to be_truthy
      end

      it "when a hash is given then it loops through the hash and return boolean value
      based on the given condition, if all the value or key meet the requirement" do
        expect(hash.my_all? { |_item, value| value > 0 }).to be_truthy
      end

      it "When a class is given as condition then it returns a boolean value if all the item are either
       match the condition or do not match the condition" do
         expect(array.my_all?(Numeric)).to be_truthy
       end

      it ' when an empty array is passed it returns a boolean value of true' do
        expect([].my_all?).to be_truthy
      end
    end

    # my_any?

    describe '#my_any?' do
      it "when an array is given then it loops through the array and return boolean value
    based on the given condition, if any item meet the requirement" do
      expect(array.my_any? { |item| item < 0 }).to be_falsy
    end

      it "when an range is given then it loops through the range and return boolean value
      based on the given condition, if any item meet the requirement" do
        expect(array.my_all? { |item| item > 0 }).to be_truthy
      end

      it "when a hash is given then it loops through the hash and return boolean value
      based on the given condition, if any value or key meet the requirement" do
        expect(hash.my_all? { |_item, value| value > 0 }).to be_truthy
      end

      it "When a class is given as condition then it returns a boolean value if any item is either
       match the condition or do not match the condition" do
         expect(array.my_all?(Numeric)).to be_truthy
       end

      it ' when an empty array is passed it returns a boolean value of true' do
        expect([].my_all?).to be_truthy
      end
    end

    # my_none?

    describe '#my_none?' do
      it "when an array of string is given then it loop through the array and returns the boolean value of true or false
      based on the given condtion. If no item in the array match the condition then it returns true" do
        expect(wordarray.my_none? { |word| word.size >= 5 }).to be_truthy
      end

      it 'when a case is given it returns true if case deosnt mathch with the element for every item.' do
        expect([9, 7.14, 8.91, 42].my_none?(Float)).to be(false)
      end

      it 'when all the element in array are nil or false then it returns true' do
        expect([nil, false].my_none?).to be(true)
      end

      it 'When there is no block given it returns true if no element of the array passed is equal to argument' do
        expect(wordarray.my_none?(10)).to be(true)
      end

      it 'when an empty array is given then it returns true' do
        expect([].my_none?).to be(true)
      end
    end

end
