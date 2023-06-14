# Broadcast

The `broadcast` bounded context is responsible for broadcasting new posts to various channels such as email, Slack, or Intercom. 

## Responsibilities

The `broadcast` context reacts to events from the `Post` model in the `write` context. Specifically, it listens for the `Post::Published` event which is triggered whenever a post is transitioned to `published` state.

Upon receiving a `Post::Published` event, the `broadcast` context is responsible for broadcasting the newly published post to various channels. 

## Post::Published Event

When a `Post::Published` event is received, the `broadcast` context currently just returns the ID of the newly published post. Future enhancements will include the actual broadcasting functionality to various channels.

