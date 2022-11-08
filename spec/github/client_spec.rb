# frozen_string_literal: true

RSpec.describe Github::Client do
  let(:endpoint) { 'https://test.com' }
  let(:configuration) do
    Github::Configuration.new(endpoint: endpoint)
  end
  let(:events_response) { '[{ "id": "1", "type": "IssueCommentEvent" }, { "id": "2", "type": "IssuesEvent" }]' }
  let(:user_name) { 'tenderlove' }

  let(:client) { described_class.new(configuration) }

  describe 'an initialized client' do
    it 'Call the events and return a json' do
      stub_request(:get, "https://test.com/users/#{user_name}/events/public")
        .to_return(status: 200,
                   body: events_response,
                   headers: { 'Content-Type' => 'application/json' })

      expect(client.get_events(user_name: user_name)).to be_a(Array)
    end
  end
end
