class PostPublishedHandler
  def run(event)
    # For now, just return the ID of the newly published post
    event.post_id
  end
end
```

