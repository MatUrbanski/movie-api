# frozen_string_literal: true

require 'spec_helper'

describe RateParams do
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
            value: ['is missing']
          }
        end

        it 'raises InvalidParamsError' do
          expect { described_class.new.permit!(params) }.to raise_error(an_instance_of(Exceptions::InvalidParamsError))
        end
      end

      context 'when params have inalid format' do
        let(:params) { { value: '10' } }

        let(:object) do
          {
            value: ['must be one of: 1, 2, 3, 4, 5']
          }
        end

        it 'raises InvalidParamsError' do
          expect { described_class.new.permit!(params) }.to raise_error(an_instance_of(Exceptions::InvalidParamsError))
        end
      end
    end

    context 'when params are valid' do
      let(:params) { { value: '3' } }

      it 'returns validated params' do
        expect(described_class.new.permit!(params)).to eq params
      end
    end
  end
end
