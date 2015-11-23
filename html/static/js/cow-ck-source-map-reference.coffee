@cow_states =
  basic:
    title: "cow exists."
    actions:
      "leave cow alone": "basic"
      "poke cow with a stick": "basic"
  vacation:
    title: "cow wants to go on vacation."
    apparel: "shirt"
    actions:
      "let cow go": "basic"
      "demand more milk": "basic"


document.addEventListener "DOMContentLoaded", ->
  @cow_states:
    basic:
      title: "cow exists."
      actions:
        "leave cow alone": "basic"
        "poke cow with a stick": "basic"
    vacation:
      title: "cow wants to go on vacation."
      apparel: "shirt"
      actions:
        "let cow go": "basic"
        "demand more milk": "basic"
  @title = document.getElementById "title"
  @actions = document.getElementById "actions"

  render_state = (state_name) =>
    console.log "Rendering #{state_name}"
    state = @cow_states[state_name]
    @title.innerHTML = state.title
    @actions.innerHTML = ""
    for action, result of state.actions
      adiv = document.createElement "div"
      adiv.className = 'action'
      adiv.innerHTML = action
      adiv.onclick = => render_state result
      @acctions.appendChild adiv
  render_state "basic"


