@images = new Mongo.Collection "images", {idGeneration: 'STRING'}
@issuerOrganizations = new Mongo.Collection "issuerOrganizations", {idGeneration: 'STRING'}
@badgeClasses = new Mongo.Collection "badgeClasses", {idGeneration: 'STRING'}
@badgeAssertions = new Mongo.Collection "badgeAssertions", {idGeneration: 'STRING'}

AccountsTemplates.configure
  lowercaseUsername: true
AccountsTemplates.removeField('email');
AccountsTemplates.removeField('password');
AccountsTemplates.addFields [
  _id: 'email'
  type: 'email'
  required: true
  displayName: "email"
  re: /.+@(.+){2,}\.(.+){2,}/
  errStr: 'Invalid emaisdasfdlkl'
,
  _id: "username"
  type: "text"
  displayName: "username"
  required: true
  minLength: 5
,
  _id: 'username_and_email'
  type: 'text'
  required: true
  displayName: "Login"
  placeholder:
    signIn: "Username or email"
,
  _id: 'password'
  type: 'password'
  placeholder:
    signUp: "At least six characters"
  required: true
,
  _id: 'earnername'
  type: 'text'
  required: true
  displayName: "Name of Earner"
  re: /^[a-z ,.'-]+$/i
  errStr: 'Invalid Earner Name'
  placeholder: "Earner Full Name"
,
  _id: 'parentname'
  type: 'text'
  displayName: "Name of Parent if earner is under 13"
  errStr: 'Invalid Parent Name Name'
  placeholder: "Parent Full Name"
,
  _id: "gender"
  type: "select"
  displayName: "Gender"
  select: [
    text: ""
    value: ""
  ,
    text: "Male"
    value: "male"
  ,
    text: "Female"
    value: "female"
  ]
,
  _id: "age"
  type: "select"
  displayName: "Age"
  select: { text: n.toString(), value: n } for n in [4..18]
,
  _id: "zip"
  type: "text"
  displayName: "Zip Code"
  re: /\d{5}(?:[-\s]\d{4})?/
  errStr: 'Invalid zip code'
]