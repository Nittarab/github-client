# frozen_string_literal: true

module Github
  #
  # The score class is used to calculate the score of a user base on the public events
  class Score
    attr_reader :user_name

    def initialize(user_name:)
      @user_name = user_name
    end

    # @return [Integer] the calculated store
    def event_score
      calculate_score(Github.get_events(user_name: user_name))
    end

    private

    # @param [JSON] events object
    # @return [Integer]
    # @note you can find the events object structure here
    #       "https://docs.github.com/en/developers/webhooks-and-events/events/github-event-types"
    def calculate_score(events)
      events.inject(0) do |result, e|
        events_score = score_by_type(event_type(e)) * e.count
        result + events_score
      end
    end

    # @param [Hash] event
    def event_type(event)
      event.first['type'].strip
    end

    # @param [String] type the event_type
    def score_by_type(type)
      type == 'IssueCommentEvent' ? 2 : 1
    end
  end
end
