@images = new Mongo.Collection("images")
@organizations = new Mongo.Collection("issuerOrganizations")
@badgeClasses = new Mongo.Collection("badgeClasses")
@badgeAssertions = new Mongo.Collection("badgeAssertions")
@identityObjects = new Mongo.Collection("identityObjects")

AccountsTemplates.removeField('email');
AccountsTemplates.removeField('password');

AccountsTemplates.addFields [
  {
    _id: 'email',
    type: 'email',
    required: true,
    displayName: "email",
    re: /.+@(.+){2,}\.(.+){2,}/,
    errStr: 'Invalid email',
  },
  {
    _id: "username",
    type: "text",
    displayName: "username",
    required: true,
    minLength: 5,
  },
  {
    _id: 'username_and_email',
    type: 'text',
    required: true,
    displayName: "Login",
    placeholder: {
      signIn: "Username or email"
    },
  },
  {
    _id: 'password',
    type: 'password',
    placeholder: {
      signUp: "At least six characters"
    },
    required: true,
  }
]