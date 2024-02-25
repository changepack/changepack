You may be asking yourself why there are no models present here. This is due to the team’s choice to implement certain aspects of Domain-Driven Design, specifically the concept of Bounded Contexts.

Bounded Context is a principle where a large system is divided into smaller, more manageable contexts, each with a clearly defined boundary and responsibility. These contexts encapsulate specific areas of the domain and help maintain a clear separation of concerns.

In the case of Changepack, we divided the app into several contexts such as `platform`, `connect`, `write`, and so on. Within each context, we allow for tight coupling, where models can reference each other through relationships, and classes can be used directly. This approach simplifies development and adheres to The Rails Way within individual contexts.

* [platform](https://github.com/changepack/changepack/tree/main/platform)
* [connect](https://github.com/changepack/changepack/tree/main/connect)
* [write](https://github.com/changepack/changepack/tree/main/write)
* and more, found in the main directory of this repository

However, to ensure maintainability and flexibility, we embrace loose coupling between contexts, minimizing direct interactions between components across different contexts. This is where the event-based architecture becomes valuable. By utilizing events as the primary communication mechanism between different contexts, we effectively reduce coupling and maintain a clean, modular architecture that can adapt to changing requirements and scale effectively.

[Learn more about the decision here.](https://github.com/changepack/architecture/blob/master/decisions/modelling.md)
