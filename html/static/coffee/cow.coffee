document.addEventListener "DOMContentLoaded", ->
  @STATE =
    avoidant: 0
    supportive: 0
    controlling: 0
    flags: []
    past_states: []
  get_state = =>
    return @STATE

  add_or_remove_flags = (flags) ->
    state = get_state()
    if typeof(flags) is "string"
      flags = [flags]
    for flag in flags or []
      remove = flag.substr(0, 1) is "-"
      if flag.substr(0, 1) in "+-" then flag = flag.substr 1
      if remove and flag in state.flags
        state.flags.pop(state.flags.indexOf(flag))
      else
        state.flags.push flag

  add_or_remove_apparel = (apparel) ->
    remove = apparel.substr(0, 1) is "-"
    if apparel.substr(0, 1) in "+-" then apparel = apparel.substr 1
    if not remove
      adiv = document.createElement "div"
      adiv.className = apparel
      document.getElementById("apparel").appendChild adiv
    else
      aps = document.getElementById("apparel").getElementsByClassName apparel
      adiv.remove() for adiv in document.getElementById("apparel").getElementsByClassName apparel

  set_style = (style) ->
    if style is "None"
      document.getElementById("cow").className = "cow"
    else if style?
      document.getElementById("cow").className = "cow #{style}"

  is_valid_state = (state_name) ->
    global = get_state()
    if state_name in global.past_states then return false
    state = cow_states[state_name]
    if state.prerequisites
      if global.avoidant < state.prerequisites.avoidant then return false
      if global.supportive < state.prerequisites.supportive then return false
      if global.controlling < state.prerequisites.controlling then return false
      if typeof(state.prerequisites.flags) is "string"
        if state.prerequisites.flags not in global.flags then return false
      else for flag in state.prerequisites.flags or []
        if flag not in global.flags then return false
    return true

  choice = (list) ->
    r = Math.floor(Math.random() * list.length)
    return list[r]

  random_state = ->
    valid_states = (state_name for state_name of cow_states when is_valid_state(state_name))
    console.log "Valid states", valid_states
    render_state choice valid_states

  pick_valid_state = (state_names) ->
    if not state_names? then return null
    if typeof(state_names) is "string"
      return if is_valid_state(state_names) then state_names else null
    valid_states = (state_name for state_name in state_names when is_valid_state(state_name))
    console.log "NOW VALID", valid_states
    if valid_states.length is 0 then return null
    return choice valid_states

  render_state = (state_name) ->
    state = cow_states[state_name]
    global = get_state()
    console.log global
    global.past_states.push state_name
    add_or_remove_flags state.flags
    console.log "Rendering #{state_name} -> #{state.title}"
    document.getElementById("title").innerText = state.title
    actions_div = document.getElementById "actions"
    actions_div.innerHTML = ""

    # apparel
    if state.apparel is "None"
      document.getElementById("apparel").innerHTML = ""
    else if typeof(state.apparel) is "string"
      add_or_remove_apparel state.apparel
    else
      add_or_remove_apparel(apparel) for apparel in (state.apparel or [])

    # global styles
    if state.style
      set_style state.style

    for type, action_set of state.actions

      adiv = document.createElement "div"
      adiv.setAttribute 'data-action-type', type

      if typeof(action_set) is "string"
        adiv.innerText = action_set
        adiv.onclick = (e) ->
          global[e.target.getAttribute 'data-action-type'] +=1
          random_state()
      else
        adiv.innerText = action_set.label
        next = pick_valid_state action_set.results
        console.log "next up", next
        adiv.setAttribute "data-style", action_set.style
        if next
          adiv.setAttribute "data-next", next
          adiv.onclick = (e) ->
            global[e.target.getAttribute 'data-action-type'] +=1
            if e.target.getAttribute "data-style"
              set_style action_set.style
            render_state e.target.getAttribute "data-next"
        else
          adiv.onclick = (e) ->
            global[e.target.getAttribute 'data-action-type'] +=1
            if e.target.getAttribute "data-style"
              set_style action_set.style
            random_state()
      adiv.className = 'action'
      actions_div.appendChild adiv
  render_state "basic"
