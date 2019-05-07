###
WebRTC shims for multiple browsers.
###

if module?.exports
  window = {}
  document =
    getElementById: () -> null,
  location = ''

  if not TESTING? or not TESTING
    webrtc = require 'wrtc'

    PeerConnection = webrtc.RTCPeerConnection
    IceCandidate = webrtc.RTCIceCandidate
    SessionDescription = webrtc.RTCSessionDescription

    WebSocket = require 'ws'
    { XMLHttpRequest } = require 'xmlhttprequest'

    process.nextTick () -> init

else
  window = this
  document = window.document
  location = window.location.search.substr(1)

  PeerConnection = window.RTCPeerConnection || window.mozRTCPeerConnection ||
    window.webkitRTCPeerConnection
  IceCandidate = window.RTCIceCandidate || window.mozRTCIceCandidate
  SessionDescription = window.RTCSessionDescription ||
    window.mozRTCSessionDescription

  if typeof PeerConnection isnt 'function'
    console.log 'webrtc feature not detected. shutting down'
    return

  WebSocket = window.WebSocket
  XMLHttpRequest = window.XMLHttpRequest
