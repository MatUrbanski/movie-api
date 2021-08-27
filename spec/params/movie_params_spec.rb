# frozen_string_literal: true

require 'spec_helper'

describe MovieParams do
  describe '#call' do
    context 'when params are invalid' do
      before do
        expect(Exceptions::InvalidParamsError)
          .to receive(:new)
          .with(object, I18n.t('invalid_params'))
          .and_return(Exceptions::InvalidParamsError.new(object, I18n.t('invalid_params')))
      end

      context 'when params are blank' do
        let(:params) { {} }

        let(:object) do
          {
            title: ['is missing'],
            price_in_cents: ['is missing']
          }
        end

        it 'raises InvalidParamsError' do
          expect { described_class.new.permit!(params) }.to raise_error(an_instance_of(Exceptions::InvalidParamsError))
        end
      end

      context 'when price_in_cents is not integer' do
        let(:params) { { price_in_cents: 'test' } }

        let(:object) do
          {
            title: ['is missing'],
            price_in_cents: ['must be an integer']
          }
        end

        it 'raises InvalidParamsError' do
          expect { described_class.new.permit!(params) }.to raise_error(an_instance_of(Exceptions::InvalidParamsError))
        end
      end
    end

    context 'when params are valid' do
      let(:params) { { title: 'Fast & Furious', price_in_cents: 5000 } }

      it 'returns validated params' do
        expect(described_class.new.permit!(params)).to eq params
      end
    end
  end
end
