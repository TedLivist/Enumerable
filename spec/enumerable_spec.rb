require_relative '../enumerable.rb'

describe Enumerable do
  my_arr = [1,2,3,4]
  my_range = (1..3)
  my_hash = {:name => 'Teddy', :country => 'Nigeria'}
  describe '#my_each' do
    context 'when no block is given' do
      it 'returns an enumerator' do
        expect(my_arr.my_each).to be_an Enumerator
      end
    end

    context 'when block is given' do
      it 'evaluates the block' do
        init_arr = []
        my_arr.my_each {|i| init_arr << i * 2}
        expect(init_arr).to eql([2,4,6,8])
      end
    end
  end

  describe "#my_each_with_index" do
    context "when no block is given" do
      it "returns an enumerator" do
        expect(my_arr.my_each_with_index).to be_an Enumerator
      end
    end

    context "when block is given" do
      context "and self is an array" do
        it "evaluates the block" do
          each_index_arr = []
          my_arr.my_each_with_index {|v, i| each_index_arr << [v, i]}
          expect(each_index_arr).to eql([[1, 0], [2, 1], [3, 2], [4, 3]])
        end
      end

      context "and self is a range" do
        it "evaluates the block" do
          each_index_range = []
          my_range.my_each_with_index {|v, i| each_index_range << "#{v} - #{i}"}
          expect(each_index_range).to eql(["1 - 0", "2 - 1", "3 - 2"])
        end
      end

      context "and self is a hash" do
        it "evaluates the block" do
          each_index_hash = []
          my_hash.my_each_with_index {|v, i| each_index_hash << "#{v[0]} - #{i}"}
          expect(each_index_hash).to eql(["name - 0", "country - 1"])
        end
      end
    end
  end

  describe "#select" do
    context "when no block is given" do
      it "returns an enumerator" do
        expect(my_arr.my_select).to be_an Enumerator
      end
    end

    context "when block is given" do
      it "evaluates the block" do
        expect(my_arr.my_select {|i| i >= 3}).to eql([3, 4])
      end
    end
  end

  describe "#my_all?" do
    context "when block given" do
      context "and all items are true" do
        it "returns the true" do
          expect(%w[ant bear cat].my_all? { |word| word.length >= 3 }).to be(true)
        end
      end

      context "and any item is false" do
        it "return false" do
          expect(%w[ant bear cat].my_all? { |word| word.length >= 4 }).to be(false)
        end
      end
    end

    context "when argument is a Regex" do
      it "checks if all items match the pattern" do
        expect(%w[ant bear cat].my_all?(/t/)).to be(false)
      end
    end

    context "when argument is a Class" do
      it "check if all items belong to the Class" do
        expect([1, 2i, 3.14].my_all?(Numeric)).to be(true)
      end
    end

    context "when neither block nor parameter is given" do
      it "if all items are truthy" do
        expect([nil, true, 99].my_all?).to be(false)
      end
    end
  end

  describe "#my_any?" do
    context "when block given" do
      context "and any item is true" do
        it "returns the true" do
          expect(%w[ant bear cat].my_any? { |word| word.length >= 3 }).to be(true)
        end
      end

      context "and any item is false" do
        it "return false" do
          expect(%w[ant bear cat].my_any? { |word| word.length >= 4 }).to be(true)
        end
      end
    end

    context "when argument is a Regex" do
      it "checks if any item matches the pattern" do
        expect(%w[ant bear cat].my_any?(/t/)).to be(true)
      end
    end

    context "when argument is a Class" do
      it "check if any item belongs to the Class" do
        expect([1, 2i, 3.14].any?(Numeric)).to be(true)
      end
    end

    context "when neither block nor parameter is given" do
      it "if any item is truthy" do
        expect([nil, true, 99].any?).to be(true)
      end
    end
  end

  describe "#my_none?" do
    context "when block given" do
      context "and none of items is true" do
        it "returns the false" do
          expect(%w[ant bear cat].my_none? { |word| word.length >= 5 }).to be(true)
        end
      end

      context "and no item is false" do
        it "return true" do
          expect(%w[ant bear cat].my_none? { |word| word.length >= 4 }).to be(false)
        end
      end
    end

    context "when argument is a Regex" do
      it "checks if no item matches the pattern" do
        expect(%w[ant bear cat].my_none?(/d/)).to be(true)
      end
    end

    context "when argument is a Class" do
      it "check if no item belongs to the Class" do
        expect([1, 3.14, 42].my_none?(Float)).to be(false)
      end
    end

    context "when no item is truthy" do
      it "returns true" do
        expect([nil, false].my_none?).to be(true)
      end
    end

    context "when neither block nor parameter is given" do
      it "if all items are truthy" do
        expect([].my_none?).to be(true)
      end
    end
  end

  describe "#my_count" do
    context "when block is given" do
      it "evaluates the block" do
        my_counter = my_arr.my_count {|x| x > 2 }
        expect(my_counter).to eql(2)
      end
    end

    context "when argument is provided" do
      it "counts the items equal to argment" do
        my_counter = my_arr.my_count(2) #=> [1,2,3,4]
        expect(my_counter).to eql(1)
      end
    end

    context "neither block nor arguments are given" do
      it "counts the items of self" do
        my_counter = my_arr.my_count
        expect(my_counter).to eql(4)
      end
    end
  end

  describe "#my_map" do
    context "when neither proc nor block is given" do
      it "returns an enumerator" do
        expect(my_arr.my_map).to be_an Enumerator
      end
    end

    context "when proc is provided" do
      it "maps the proc to self" do
        new_proc = Proc.new {|x| x * 2}
        expect(my_arr.my_map(new_proc)).to eql([2, 4, 6, 8])
      end
    end

    context "when block is given" do
      it "evaluates the block" do
        expect(my_range.my_map {|x| x + 2}).to eql([3, 4, 5])
      end
    end
  end

  describe "#my_inject" do
    context "when only plus symbol is passed as argument" do
      it "adds all items" do
        expect(my_range.my_inject(:+)).to eql(6)
      end
    end

    context "when a number and multiply symbol are arguments" do
      it "multiplies the numbers" do
        expect(my_arr.my_inject(1, :*)).to eql(24)
      end
    end

    context "when a block is given" do
      it "sums all items" do
        expect(my_arr.my_inject {|s, n| s + n}).to eql(10)
      end
    end

    context "when a block and an argument are given" do
      it "multiplies the numbers" do
        expect(my_arr.my_inject(1) {|m, n| m * n}).to eql(24)
      end
    end

    context "when self is array of strings" do
      it "returns the longest string" do
        expect(%w{ cat sheep bear }.inject {|memo, word| memo.length > word.length ? memo : word}).to eql("sheep")
      end
    end
  end

end