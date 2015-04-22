'use strict'
define ->
  create = ( providedStates )->

    if !providedStates?
      throw new Error('provide states')
    # init
    states = {}
    stateNames = {}
    classNames = {}
    api = {}
    nodes = []
    classCache = undefined
    for state, value of providedStates
      states[state] = {className : value, enabled : false}
      stateNames[state] = state
      classNames[value] = state

    # internal functions
    get = ->
      return classCache if classCache?
      stateClass = ""
      separator = ""
      for state, value of states
        if value.enabled
          stateClass += separator + value.className
        separator = " "
      classCache = stateClass

    isNode = (node)->
      node.nodeType?

    applyToNode = (node)->
      if !node.previousState? or !node.defaultClasses? or node.previousState != node.node.className
        node.defaultClasses = getDefaultClasses(node.node.className)
      classNamesState = get()
      node.previousState = node.node.className = node.defaultClasses + " " + classNamesState
      true

    apply = ->
      for node in nodes
        applyToNode node

    getDefaultClasses = (strClassNames)->
      arrayNames = strClassNames.split(' ')
      value = ""
      separator = ""
      for name in arrayNames
        if !classNames[name]?
          value += separator + name
          separator = " "
      value

    # exposed functions
    isState = (state) ->
      typeof state == "string" and states[state]?

    setState = (state, enabled=true)->
      return false if !isState state
      states[state].enabled = enabled

    enable = ->
      classCache = undefined
      for state in arguments
        setState state
      api

    disable = (status)->
      classCache = undefined
      for state in arguments
        setState state, false
      api

    reset = ->
      classCache = undefined
      for state in states
        setState state, false
      api

    enabled = (state)->
      return undefined if !isState state
      states[state].enabled

    disabled = (state)->
      !enabled state

    registerNode = (node)->
      return if !isNode node
      nodes.push {node: node}
      true

    clearNodes = ->
      nodes = []

    api.enable = enable
    api.enabled = enabled
    api.disable = disable
    api.disabled = disabled
    api.reset = reset
    api.registerNode = registerNode
    api.clearNodes = clearNodes
    api.apply = apply
    api.states = stateNames
    api

  create : create

#  console.clear()
#  # init the state obj
#  state = styleState {active: "class-active", initial: "class-initial", rooted: "class-rooted"}
#  # get a dom
#  node = document.getElementById 'thisisit'
#  state.registerNode node
#  # disable active and apply to node
#  state.enable(state.states.active, state.states.initial, state.states.rooted).disable(state.states.active).apply()











