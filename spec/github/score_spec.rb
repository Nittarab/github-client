# frozen_string_literal: true

RSpec.describe Github::Score do
  let(:endpoint) { 'https://test.com' }

  let(:events_response) { '[{ "id": "1", "type": "IssueCommentEvent" }, { "id": "2", "type": "IssuesEvent" }]' }
  let(:user_name) { 'test' }

  before do
    Github.configure(endpoint: endpoint)
  end

  it 'calculate the score' do
    stub_request(:get, "https://test.com/users/#{user_name}/events/public")
      .to_return(status: 200,
                 body: events_response,
                 headers: { 'Content-Type' => 'application/json' })

    expect(described_class.new(user_name: user_name).event_score).to eq(3)
  end
end
