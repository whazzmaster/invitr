Invitr.NewRsvpView = Ember.View.extend
  templateName: 'new_rsvp'
  tagName: 'form'

  didInsertElement: ->
    @get('controller').on('validationDidSucceed', $.proxy(@validationSucceeded, this))
    @get('controller').on('validationDidFail', $.proxy(@validationFailed, this))

  submit: ->
    name = @get('newRsvpName')
    attending = @get('newRsvpAttending')
    message = @get('newRsvpMessage')
    @get('controller').send('validateAndSubmitForm', name, attending, message)
    false

  validationSucceeded: (result) ->
    # alert('Validation succeeded!')

    # Clear the form elements
    @set('newRsvpName', '')
    @set('newRsvpAttending', '')
    @set('newRsvpMessage', '')

    $("body").animate
      scrollTop: $("footer").position().top
      1000

  validationFailed: (result) ->
    # alert('Validation failed!')
    for error in result.errors
      $(@get('element')).find("##{error.field}Error").text(error.message)
