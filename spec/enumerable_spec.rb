require_relative '../enumerable.rb'

describe Enumerable do
  my_arr = [1,2,3,4]
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
      context "with self as an array" do
        it "evaluates the block as an array" do
          init_arr = []
          my_arr.my_each_with_index {|v, i| init_arr << [v, i]}
          expect(init_arr).to eql([[1, 0], [2, 1], [3, 2], [4, 3]])
        end
      end
    end

  end
end