# Platform

The `platform` bounded context is a horizontal context that provides foundational functionality and services that are shared across other bounded contexts within the application. It contains essential models, concerns, and utilities that facilitate the development and integration of other contexts. Together, they create a set of reusable components and services that streamline the development process and promote consistency across different parts of the application.

## Models

* `Account` represents an organization or user account within the Platform context, providing attributes for account information, such as name, description, and website. It establishes associations with key models, enabling user and resource management at the account level.
* `API` serves as the interface for external and internal communication, defining the structure and types for API requests and responses.
* `Clock` provides time-based utilities and events. It facilitates the scheduling and handling of time-based events within the application.
* `Event` represents an event that can be published and subscribed to by different parts of the application. It provides methods for handling events, managing metadata, and retrieving event data.
* `Handler` is a base class for event handlers that process incoming events. It subscribes to specific events and executes the appropriate logic when those events are received.
* `Hook` manages webhook configurations for different providers, such as Slack. It supports defining webhook requests, handling incoming events, and associating hooks with accounts.
* `Notification` manages the creation, categorization, and delivery of notifications to users or accounts. It supports multiple channels, such as email, and allows for the association of notifications with specific accounts and subjects.
* `User` represents individual users within the Platform context, handling authentication and authorization. It establishes associations with the Account model, facilitating user-account relationships and enabling secure access to resources.

## Concerns

The `platform` bounded context includes the following key features:

* `Domain` provides functionality for managing and validating domain-related attributes, such as the domain name associated with an account. It ensures that domain names are valid and unique within the system.
* `Identifier` adds a unique identifier to models, enabling them to be easily referenced and accessed within the system. It includes methods for generating and managing identifiers.
* `Inquirer` provides a mechanism for creating inquirer methods on models. An inquirer method allows for querying the state of an attribute in a more expressive and readable way.
* `Resourcable` provides functionality for automatically triggering events when a resource is created, updated, or destroyed. It simplifies the process of publishing events related to resource changes.
* `Status` concern enables models to have a status attribute and provides methods for managing and querying the status of a model. It includes functionality for transitioning between different states and validating the current state.
* `Provided` adds support for tracking and managing external providers associated with a model. It allows models to define provider attributes and automatically trigger events when providers are added or removed.

These concerns are horizontal; they are not a core part of any specific model, unlike concerns from other contexts. Therefore, they are located under `platform/concerns`, separate from the domain models.


## Communication with other contexts

The `platform` bounded context is designed to be seamlessly integrated with other bounded contexts within the application. Its models, concerns, and utilities can be directly accessed and utilized by other contexts without the need for event-driven communication.

Other bounded contexts can freely utilize the functionality provided by the `platform` context, such as accessing common models, including concerns, and reusing utilities. This promotes code reuse, consistency, and reduces development effort across multiple contexts. The `platform` context is also leveraged to access utilities like the `Clock` module for managing time-based events and the `Event` model for publishing and subscribing to events.

For example, the `write` context collaborates with the `platform` context by leveraging its models and concerns. The `write` context can freely access and utilize models such as `Account` or `User` and concerns like `Slug` or `Active`. This seamless integration enables the `write` context to leverage the foundational functionality provided by the `platform` context.

The `platform` bounded context acts as a central hub for receiving and storing hooks through the `Hook` model. These hooks, which can originate from various external providers such as Slack, are processed and managed within their respective bounded contexts. The primary responsibility of the `platform` context in this workflow is to securely receive and store these hooks, ensuring they are available for further processing by the appropriate context.

For example, when a webhook from Slack is received, it is captured by the `Hook` model within the `platform` context. The stored hook then awaits processing by a context that handles Slack notifications or events, such as sending notifications or triggering specific actions based on the hook’s data. This separation of concerns allows the `platform` context to remain focused on foundational services, while specialized contexts handle the domain-specific logic related to the hooks.

## Further information

For more details and information on the components provided by the `platform` bounded context, refer to the individual README files of the models, concerns, and utilities within the context. Additionally, consult the documentation and guidelines provided by the context for specific usage instructions and best practices.
