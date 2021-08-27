# frozen_string_literal: true

require 'spec_helper'

describe Constants do
  it 'defines EMAIL_REGEX constant' do
    expect(described_class::EMAIL_REGEX).to eq(/^[^,;@ \r\n]+@[^,@; \r\n]+\.[^,@; \r\n]+$/)
  end

  it 'defines UUID_REGEX constant' do
    expect(described_class::UUID_REGEX).to eq(/(\h{8}(?:-\h{4}){3}-\h{12})/)
  end
end
