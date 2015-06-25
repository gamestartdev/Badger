describe 'createBadgeAssertion', ->

  beforeEach ->
    Meteor.users.remove({})
    badgeAssertions.remove({})
    expectedUser =
      username: 'nate'
      email: 'shouldntUseThisOne'
    this.userId = Accounts.createUser expectedUser

  it 'uses ? syntax', ->
    expect({a: 1}.a).toBeTruthy()
    expect({a: 1}.a?).toBeTruthy()
    expect({a: ""}.a?).toBeTruthy()

    expect({a: ""}.a).toBeFalsy()
    expect({a: undefined}.a).toBeFalsy()
    expect({a: null}.a).toBeFalsy()
    expect({}.a).toBeFalsy()

  it 'should create a BadgeAssertion without an email', ->
    Meteor.call 'createBadgeAssertion', this.userId, "a", "b"
    expect(badgeAssertions.find().count()).toBe(1)
    actualAssertion = badgeAssertions.find().fetch()[0]
    expect(actualAssertion.userId).toBe(this.userId)
    expect(actualAssertion.email).toBeNull()

  it 'should create a BadgeAssertion with provided email', ->
    email = "thedenrei@gmail.com"
    Meteor.call 'createBadgeAssertion', this.userId, "a", "b", email
    expect(badgeAssertions.find().count()).toBe(1)
    actualAssertion = badgeAssertions.find().fetch()[0]
    expect(actualAssertion.userId).toBe(this.userId)
    expect(actualAssertion.email).toBe(email)

  it 'should create a BadgeAssertion without user', ->
    email = "thedenrei@gmail.com"
    Meteor.call 'createBadgeAssertion', undefined, "a", "b", email
    expect(badgeAssertions.find().count()).toBe(1)
    actualAssertion = badgeAssertions.find().fetch()[0]
    expect(actualAssertion.userId).toBeNull()
    expect(actualAssertion.email).toBe(email)