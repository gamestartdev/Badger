@Example = new Meteor.Collection 'example'

# Allow
Example.allow
  insert: (userId, doc) ->
      # ...
  update: (userId, doc, fields, modifier) ->
      # ...
  remove: (userId, doc) ->
      # ...
  fetch: ['owner'],
  transform: () ->
      # ...

# Deny
Example.deny
  insert: (userId, doc) ->
      # ...
  update: (userId, doc, fields, modifier) ->
      # ...
  remove: (userId, doc) ->
      # ...
  fetch: ['locked']
  transform: () ->
      # ...

@images = new Mongo.Collection("images")
@orginizations = new Mongo.Collection("issuerOrganizations")
@badgeClasses = new Mongo.Collection("badgeClasses")
