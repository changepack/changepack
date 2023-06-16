# typed: false
# frozen_string_literal: true

class Update
  class Done < Handler
    on ::Update::Done

    sig { override.returns T::Boolean }
    def run
      # Logic to be executed when Update::Done event is triggered
    end
  end
end
```

