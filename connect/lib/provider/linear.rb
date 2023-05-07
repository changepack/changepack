# typed: false
# frozen_string_literal: true

class Provider
  class Linear < Provider
    TEAMS = <<~GRAPHQL
      query {
        teams {
          nodes {
            id
            name
          }
        }
      }
    GRAPHQL

    ISSUES = <<~GRAPHQL
      query($teamId: String!) {
        team(id: $teamId) {
          id
          issues {
            nodes {
              id
              title
              description
              assignee {
                id
                name
                email
              }
              labels {
                nodes {
                  name
                }
              }
              priority
              branchName
              identifier
              state {
                id
              }
            }
          }
        }
      }
    GRAPHQL

    sig { override.returns(Results) }
    def teams
      gql = client.parse(TEAMS)
      teams = client.query(gql, context:).data.teams.nodes.map(&:to_h)
      teams.map { |team| Mapper.team(team) }
    end

    sig { override.params(team_id: String).returns(Results) }
    def issues(team_id)
      gql = client.parse(ISSUES)
      issues = client.query(gql, variables: { teamId: team_id }, context:).data.team.issues.nodes.map(&:to_h)
      issues.map { |issue| Mapper.issue(issue) }
    end

    private

    sig { override.returns GraphQL::Client }
    def client
      @client ||= GraphQL::Client.new(
        schema: GraphQL::Client.load_schema(http),
        execute: http
      ).tap { |client| client.allow_dynamic_queries = true }
    end

    sig { returns GraphQL::Client::HTTP }
    def http
      @http ||= GraphQL::Client::HTTP.new('https://api.linear.app/graphql') do
        def headers(context) # rubocop:disable Lint/NestedMethodDefinition
          {
            'Authorization' => "Bearer #{context[:access_token]}",
            'Content-Type' => 'application/json'
          }
        end
      end
    end
  end

  sig { returns(access_token: String) }
  def context
    @context ||= { access_token: access_token.to_s }
  end

  class Mapper
    extend T::Sig

    sig { params(team: Hash).returns(name: String, providers: { linear: String }) }
    def self.team(team)
      {
        name: team['name'],
        providers: { linear: team['id'] }
      }
    end

    sig { params(issue: Hash).returns(Hash) }
    def self.issue(issue)
      {
        title: issue['title'],
        description: issue['description'],
        providers: { linear: issue['id'] }
      }
    end
  end
end
