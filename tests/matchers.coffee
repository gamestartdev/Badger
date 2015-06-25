beforeEach ->
  jasmine.addMatchers
    hasProperty: ->
      return {
      compare: (actual, expected) ->
        return { pass: actual[expected]? }
      }