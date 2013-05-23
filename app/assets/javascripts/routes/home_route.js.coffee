Invitr.HomeRoute  = Ember.Route.extend
  model: ->
    Invitr.Rsvp.find()