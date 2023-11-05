# Connect

The `connect` bounded context is a collection of models and their relationships that are designed to interact with different providers such as GitHub, Linear, and others. The primary purpose of this context is to manage repositories, teams, issues, and commits for the associated providers.

## Models

### AccessToken

The `AccessToken` model represents the access token used to authenticate and communicate with external providers. It has a unique token for each account and provider type.

### Provider

The `Provider` class is an abstract class designed to provide a common interface for different provider implementations such as GitHub, Linear, etc. It defines methods for fetching repositories, commits, teams, and issues from the associated providers.

### Team and Issue

The `Team` model represents a team or a project within an account, pulled from project management software like Linear or JIRA. The `Issue` model represents an issue or task within a team or project.

### Repository and Commit

The `Repository` model represents a code repository within an account. The `Commit` model represents a commit within a code repository.

We have decided not to use Single Table Inheritance (STI) for the `Team` and `Repository` models, as well as for the `Commit` and `Issue` models, despite the fact that they share some common behavior. The reason behind this decision is that these models have different attributes, which would make data modeling awkward and less efficient if we were to use STI.

By not using STI, we are able to keep the data models for `Team`, `Repository`, `Commit`, and `Issue` separate and well-organized, ensuring that each model maintains its own specific attributes and behavior. This makes it easier to manage, understand, and maintain the codebase and data structure in the long run.

## Inbound Communication

The `connect` context receives events from other contexts and handles them through a set of event handlers. These event handlers are responsible for updating the `connect` context's state and triggering actions based on the events. The context collaborates with the `platform` context for inbound communication. This collaboration is particularly relevant when new access tokens need to be created as users sign in or register using OAuth 2 provided by GitHub, Linear, and others.

The following event handlers handle inbound communication:

* Triggered by the `Clock::NewHour` event, we mark all active teams and repositories as outdated, which in turn initiates the pull process
* Triggered by the `Team::Outdated` or `User::ProvidersChanged` event, we pull updated data for the specified team or repository

## Outbound Communication

The `connect` context sends out events as a result of changes in its state or as a response to certain actions. Other contexts can listen to these events and react accordingly. The connect context primarily collaborates with the `write` context as a source of updates that can be attached to posts and newsletters.

For all Create, Update, and Destroy (CRUD) actions, except Read, the `connect` context sends out corresponding events. These events include:

* `Created` sent when a new resource (team, repository, issue, or commit) has been created
* `Updated` sent when a resource (team, repository, issue, or commit) has been updated
* `Destroyed` sent when a resource (team, repository, issue, or commit) has been destroyed

These events form the outbound communication of the `connect` context and can be consumed by other contexts to maintain synchronization and initiate appropriate actions based on the events.
