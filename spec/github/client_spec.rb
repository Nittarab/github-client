# frozen_string_literal: true

RSpec.describe Github::Client do
  it 'has a version number' do
    expect(Github::Client::Version).not_to be_nil
  end
end
