new AppView(model: new App()).$el.appendTo 'body'

$ document
  .ready ->
    $ '.modal-trigger'
      .leanModal()