describe 'models/', ->
  describe 'user', ->
    User = require '../app/models/user'

    it 'should check hashed passwords correctly', (done) ->
      testUser = new User name: 'test', email: 'test@example.com'
      testUser.setPassword 'complicated', ->
        testUser.checkPassword 'complicated', (err, res) ->
          res.should.equal true
          done()
