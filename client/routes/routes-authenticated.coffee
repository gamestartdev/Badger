Router.route('create',
  path: '/create'
  template: 'create'
  waitOn: ->
    Meteor.subscribe 'userData'
  onBeforeAction: ->
    Session.set 'currentRoute', 'create'
    @next()
)

Router.route('account',
  path: '/account'
  template: 'account'
  waitOn: ->
    Meteor.subscribe 'userData'
    Meteor.subscribe 'orginizations'
  onBeforeAction: ->
    Session.set 'currentRoute', 'account'
    @next()
)
