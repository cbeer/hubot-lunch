chai = require 'chai'
sinon = require 'sinon'
chai.use require 'sinon-chai'

expect = chai.expect

describe 'hubot-lunch', ->
  beforeEach ->
    @robot =
      respond: sinon.spy()
      hear: sinon.spy()

    require('../src/lunch')(@robot)

  describe 'lunch?', ->
    it 'registers a hear listener for "lunch?"', ->
      expect(@robot.hear).to.have.been.calledWith(/lunch\?/i)
