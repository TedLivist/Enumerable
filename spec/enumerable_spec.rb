require_relative '../enumerable.rb'

describe Enumerable do
  my_arr = [1,2,3,4,5,6]
  describe '#my_each' do
    context 'when no block is given' do
      it 'returns an enumerator' do
        expect(my_arr.my_each).to be_an Enumerator
      end
    end
  end
end