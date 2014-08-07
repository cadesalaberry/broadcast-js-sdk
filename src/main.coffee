requiresInit = ->
  throw new Error("CineIO.init(CINE_IO_PUBLIC_KEY) has not been called.") unless CineIO.config.publicKey

CineIO =
  config: {}
  init: (publicKey, options)->
    throw new Error("Public Key required") unless publicKey
    CineIO.config.publicKey = publicKey
    for prop, value of options
      CineIO.config[prop] = value

  reset: ->
    CineIO.config = {}

  publish: (streamId, password, domNode, publishOptions={})->
    requiresInit()
    throw new Error("Stream ID required.") unless streamId
    throw new Error("Password required.") unless password
    throw new Error("DOM node required.") unless domNode
    publishStream.new(streamId, password, domNode, publishOptions)

  play: (streamId, domNode, playOptions={})->
    requiresInit()
    throw new Error("Stream ID required.") unless streamId
    throw new Error("DOM node required.") unless domNode
    playStream.live(streamId, domNode, playOptions)

  playRecording: (streamId, recordingName, domNode, playOptions={})->
    requiresInit()
    throw new Error("Stream ID required.") unless streamId
    throw new Error("Recording name required.") unless recordingName
    throw new Error("DOM node required.") unless domNode
    playStream.recording(streamId, recordingName, domNode, playOptions)

  getStreamDetails: (streamId, callback)->
    requiresInit()
    throw new Error("Stream ID required.") unless streamId
    ApiBridge.getStreamDetails(streamId, callback)

  getStreamRecordings: (streamId, callback)->
    requiresInit()
    throw new Error("Stream ID required.") unless streamId
    ApiBridge.getStreamRecordings(streamId, callback)

window.CineIO = CineIO if typeof window isnt 'undefined'

module.exports = CineIO

playStream = require('./play_stream')
publishStream = require('./publish_stream')
ApiBridge = require('./api_bridge')