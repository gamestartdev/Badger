Meteor.subscribe 'userData'
Meteor.subscribe 'allUsers'
Meteor.subscribe 'organizations'
Meteor.subscribe 'badgeClasses'
Meteor.subscribe 'badgeAssertions'

Router.configure
  notFoundTemplate: 'notFound'
  layoutTemplate: 'layout'

Router.route 'index',
  path: '/'
  template: 'index'
  onBeforeAction: ->
    # Code to run before route goes here.
    Session.set 'currentRoute', 'index'
    @next()

Router.route 'create',
  path: '/create'
  template: 'create'
  onBeforeAction: ->
    Session.set 'currentRoute', 'create'
    @next()

Router.route 'organization',
  path: '/organization'
  template: 'organization'
  onBeforeAction: ->
    Session.set 'currentRoute', 'organization'
    @next()

Router.route 'view_badge',
  path: '/view_badge/:badgeId'
  template: 'view_badge'
  data: ->
    return {
      badge: badgeClasses.findOne({_id: @params.badgeId})
    }
  onBeforeAction: ->
    Session.set 'currentRoute', 'view_badge'
    @next()

checkUserLoggedIn = ->
  if not Meteor.loggingIn() and not Meteor.user()
    Router.go '/'
  else
    @next()

bounceNonAdmin = ->
  if not Meteor.loggingIn() and Meteor.user() and Roles.userIsInRole(Meteor.user(), ['admin'])
    Router.go '/view'
  else
    @next()

Router.onBeforeAction checkUserLoggedIn, except: [
  'index',
]

#Router.onBeforeAction userAuthenticated, only: [
#  'index',
#  'signup',
#  'login',
#  'recover-password',
#  'reset-password'
#]