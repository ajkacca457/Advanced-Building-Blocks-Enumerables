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
      expect(array.my_each { |item| puts item }). to equal(array.each { |item| puts item })
    end

    it 'when a range is given it loop through the range and return each item' do
      expect(range.my_each { |item| puts item }). to equal(range.each { |item| puts item })
    end

    it 'when a block is not given it returns an enumerator' do
      expect(array.my_each). to be_a(Enumerator)
    end
  end

  # my_each_with_index method
  describe 'my_each_with_index' do
    it 'when an array is given it loop through an array and return each item with index ' do
      expect(array.my_each_with_index { |item, index| puts "#{item} is #{index}" })
        .to equal(array.each_with_index { |item, index| puts "#{item} is #{index}" })
    end

    it 'when an range is given it loop through the range and return each item with index ' do
      expect(range.my_each_with_index { |item, index| puts "#{item} is #{index}" })
        .to equal(range.each_with_index { |item, index| puts "#{item} is #{index}" })
    end

    it 'when a hash is given it loop through the hash and return each item with index ' do
      expect(hash.my_each_with_index { |item, index| puts "#{item} is #{index}" })
        .to equal(hash.each_with_index { |item, index| puts "#{item} is #{index}" })
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

  # my_map
  describe '#my_map' do
    it 'when an array is given it loops through the array and return a new array after
    executing the given condition' do
      expect(array.my_map { |item| item * 3 }).to eql([3, 6, 9, 12, 15, 18, 21])
    end

    it 'when a range is given it loops through the range and return a new array after
    executing the given condition' do
      expect(range.my_map { |item| item * 2 }).to eql([2, 4, 6, 8, 10, 12, 14, 16, 18])
    end

    it 'when a hash is given it loops through the hash and return a new array after
    executing the given condition' do
      expect(hash.my_map { |_item, value| value * 2 }).to eql([2000, 2400, 3000, 2600])
    end

    it 'when an proc is given it loops through the array and return a new array after
    executing the given proc' do
      expect([1, 2, 3, 4].my_map(&my_proc)).to eql([3, 6, 9, 12])
    end

    it 'when a block is not given then it return an enumerator' do
      expect(array.my_map). to be_a(Enumerator)
    end
  end

  # my_count

  describe '#my_count' do
    it 'when an array is given it returns the number of items in array after looping through the array.' do
      expect(array.my_count(&:odd?)).to eql(4)
    end

    it "when an argument is given, it returns the number of items in the array
      that are equal to item are counted. " do
      expect(array.my_count(4)).to eql(1)
    end

    it 'when a block is not given then it counts the number of items that are present in the array.' do
      expect(array.my_count).to eql(array.length)
    end

    it 'when a block is not given and a range is given then it counts
    the number of items that are present in the range.' do
      expect(range.my_count).to eql(range.count)
    end
  end

  #----------my_inject-----------

  describe '#my_inject' do
    it 'when an array is given then it returns the Sum of all the element of the array' do
      expect(array.my_inject(:+)).to eql(28)
    end
  end

  it 'when an range is given then it returns the Sum of all the element of the range' do
    expect(range.my_inject { |total, item| total + item }).to eql(45)
  end

  it 'when an accumulator and a symbol are passed as argument then it multiply numbers inside an array or range' do
    expect((1..10).my_inject(2, :*)).to eql(7_257_600)
  end

  it 'when an array or a range range is given with proc then it executes and return the result' do
    expect(wordarray.my_inject(&search)).to eql('dear')
  end

  describe '#multiply_els' do
    it 'when an array is given then it multiply all the element inside argument array' do
      expect(multiply_els([8, 12, 4, 33, 45])).to eql(570_240)
    end
    it 'when a range is given then it multiply all the element inside argument range' do
      expect(multiply_els(1...8)).to eql(50_40)
    end
  end
end
