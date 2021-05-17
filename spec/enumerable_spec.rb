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
end