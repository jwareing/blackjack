class window.ChipView extends Backbone.View
  className: 'chip-holder'
  template: _.template '
    <div class="chip chip-040"></div> \
    <div class="chip chip-1"></div> \
    <div class="chip chip-4"></div> \
    <div class="chip chip-10"></div> \
    <div class="chip chip-20"></div> \
    <span class="money betAmount">Bet: <%= betAmount.toFixed(1) %></span> \
    <span class="money bank">Bank: <%= bank.toFixed(1) %> bitcoin</span> \
  '

  initialize: ->
    @render()

    @listenTo @model, 'change', @render
    @model.on 'double', () =>
      @calculate(@model.get 'betAmount')
      console.log 'doubling chips'
      @model.hit()
      @model.stand()

  render: ->
    @$el.html @template(@model.attributes)
    @$el.find '.chip-040'
      .on 'click', () =>
        @calculate .4

    @$el.find '.chip-1'
      .on 'click', () =>
        @calculate 1

    @$el.find '.chip-4'
      .on 'click', () =>
        @calculate 4

    @$el.find '.chip-10'
      .on 'click', () =>
        @calculate 10

    @$el.find '.chip-20'
      .on 'click', () =>
        @calculate 20

  calculate: (amount) ->
    if (@model.get 'bank') - amount >= 0
      @model.set 'betAmount', 
        (@model.get 'betAmount') + amount
      @model.set 'bank', 
        (@model.get 'bank') - amount
