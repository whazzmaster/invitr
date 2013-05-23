Invitr.HomeController = Ember.ArrayController.extend Ember.Evented,
  totalAttending: (->
    @getEach('attending').reduce ((accum, val) ->
        accum + val), 0
  ).property('@each.attending')

  attendingDesignator: (->
    if @get('length') == 1 then 'person' else 'people'
  ).property('@each')

  addRsvp: (name, attending, message) ->
    rsvp = Invitr.Rsvp.createRecord(name: name, attending: attending, message: message)
    rsvp.addObserver 'id', this, 'updateCookies'
    @get('store').commit()

  updateCookies: (rsvp) ->
    ownedIds = $.cookie('rsvps')
    ownedIds ?= []
    rsvpId = rsvp.id
    if !ownedIds? or ownedIds.indexOf(rsvpId) is -1
      ownedIds.push(rsvpId)
      $.cookie('rsvps', ownedIds)


  resetErrors: ->
    @set('nameError', '')
    @set('attendingError', '')
    @set('messageError', '')

  validateAndSubmitForm: (name, attending, message) ->
    @resetErrors()

    result = {
      valid: true,
      errors: []
    }

    if Ember.isEmpty(name)
      result.valid = false
      result.errors.push { field: 'name', message: 'Please enter a name'}
      @set('nameError', 'Please enter a name')

    parsedAttending = parseInt(attending)
    if Ember.isEmpty(attending) or isNaN(parsedAttending) or parsedAttending < 1
      result.valid = false
      result.errors.push { field: 'attending', message: 'Please enter a number > 0'}
      @set('attendingError', 'Please enter a number > 0')

    if !Ember.isEmpty(message) and message.length > 255
      result.valid = false
      result.errors.push { field: 'message', message: 'Please limit your message to 255 characters'}
      @set('messageError', 'Please limit your message to 255 characters')

    if result.valid
      @addRsvp(name, attending, message)
      @trigger('validationDidSucceed', result)
    else
      @trigger('validationDidFail', result)

    false


