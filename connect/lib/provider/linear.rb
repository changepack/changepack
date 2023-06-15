# typed: false
# frozen_string_literal: true

class Provider
  class Linear < Provider
    Object = T.type_alias { GraphQL::Client::Schema::ObjectClass }
    Objects = T.type_alias { T::Array[Object] }

    sig { override.returns(Results) }
    def teams
      client.query(parse(:teams), context:)
            .data
            .teams
            .nodes
            .map { |team| Mapper.team(team) }
    end

    sig { override.params(team: Team, after: Cursor).returns(Results) }
    def issues(team, after: nil)
      issues = paginate do
        client.query(parse(:issues), variables: variables(team, after), context:)
      end

      issues.map { |issue| Mapper.issue(issue, team:) }
    end

    private

    sig { params(items: Objects).returns(Objects) }
    def paginate(items: [])
      query = yield
      paginated_items = items.concat(query.data.team.issues.nodes)

      if exhausted?(query)
        paginated_items
      else
        paginate(items: paginated_items) do
          variables = paginated_variables(query)
          client.query(parse(:issues), variables:, context:)
        end
      end
    end

    sig { params(query: GraphQL::Client::Response).returns(T::Boolean) }
    def exhausted?(query)
      query.data.team.issues.page_info.has_next_page.blank?
    end

    sig { params(query: Symbol).returns(GraphQL::Client::OperationDefinition) }
    def parse(query)
      client.parse(
        Rails.root.join('connect', 'lib', 'provider', "#{query}.graphql").read
      )
    end

    sig { params(team: Team, after: Cursor).returns(Hash) }
    def variables(team, after = nil)
      { teamId: team.linear, after: }.compact
    end

    sig { params(query: GraphQL::Client::Response).returns(Hash) }
    def paginated_variables(query)
      {
        teamId: query.data.team.id,
        after: query.data.team.issues.page_info.end_cursor
      }
    end

    sig { override.returns(GraphQL::Client) }
    def client
      @client ||= GraphQL::Client.new(
        schema: GraphQL::Client.load_schema(http),
        execute: http
      ).tap { |client| client.allow_dynamic_queries = true }
    end

    sig { returns(GraphQL::Client::HTTP) }
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
    class << self
      extend T::Sig

      sig { params(team: Object).returns(Hash) }
      def team(team)
        {
          name: team.name,
          providers: { linear: team.id },
          schema: schema(team).deep_stringify_keys
        }
      end

      sig { params(team: Object).returns(Hash) }
      def schema(team)
        {
          done: {
            type: :object,
            required: [:id],
            properties: {
              id: { const: team.merge_workflow_state.id }
            }
          }
        }
      end

      sig { params(issue: Object, team: Team).returns(Hash) }
      def issue(issue, team:)
        {
          title: issue.title,
          description: issue.description,
          providers: { linear: issue.id }
        }.merge(
          **completion(issue, team:), **meta(issue)
        )
      end

      sig { params(issue: Object, team: Team).returns(Hash) }
      def completion(issue, team:)
        {
          assignee: assignee(issue),
          branch: issue.branch_name,
          done: team.schema.done.validate(issue.state.to_h)
        }
      end

      sig { params(issue: Object).returns(Hash) }
      def meta(issue)
        {
          priority: issue.priority,
          issued_at: issue.created_at,
          identifier: issue.identifier,
          labels: issue.labels.nodes.map(&:name)
        }
      end

      sig { params(issue: Object).returns T.nilable(Hash) }
      def assignee(issue)
        return if issue.assignee.blank?

        {
          name: issue.assignee.name,
          email: issue.assignee.email,
          providers: { linear: issue.assignee.id }
        }
      end
    end
  end
end
