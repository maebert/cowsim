// Generated by CoffeeScript 1.8.0
var __indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

document.addEventListener("DOMContentLoaded", function() {
  var add_or_remove_apparel, add_or_remove_flags, choice, get_state, is_valid_state, pick_valid_state, random_state, render_state, set_style;
  this.STATE = {
    avoidant: 0,
    supportive: 0,
    controlling: 0,
    flags: [],
    past_states: []
  };
  get_state = (function(_this) {
    return function() {
      return _this.STATE;
    };
  })(this);
  add_or_remove_flags = function(flags) {
    var flag, remove, state, _i, _len, _ref, _ref1, _results;
    state = get_state();
    if (typeof flags === "string") {
      flags = [flags];
    }
    _ref = flags || [];
    _results = [];
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      flag = _ref[_i];
      remove = flag.substr(0, 1) === "-";
      if (_ref1 = flag.substr(0, 1), __indexOf.call("+-", _ref1) >= 0) {
        flag = flag.substr(1);
      }
      if (remove && __indexOf.call(state.flags, flag) >= 0) {
        _results.push(state.flags.pop(state.flags.indexOf(flag)));
      } else {
        _results.push(state.flags.push(flag));
      }
    }
    return _results;
  };
  add_or_remove_apparel = function(apparel) {
    var adiv, aps, remove, _i, _len, _ref, _ref1, _results;
    remove = apparel.substr(0, 1) === "-";
    if (_ref = apparel.substr(0, 1), __indexOf.call("+-", _ref) >= 0) {
      apparel = apparel.substr(1);
    }
    if (!remove) {
      adiv = document.createElement("div");
      adiv.className = apparel;
      return document.getElementById("apparel").appendChild(adiv);
    } else {
      aps = document.getElementById("apparel").getElementsByClassName(apparel);
      _ref1 = document.getElementById("apparel").getElementsByClassName(apparel);
      _results = [];
      for (_i = 0, _len = _ref1.length; _i < _len; _i++) {
        adiv = _ref1[_i];
        _results.push(adiv.remove());
      }
      return _results;
    }
  };
  set_style = function(style) {
    if (style === "None") {
      return document.getElementById("cow").className = "cow";
    } else if (style != null) {
      return document.getElementById("cow").className = "cow " + style;
    }
  };
  is_valid_state = function(state_name) {
    var flag, global, state, _i, _len, _ref, _ref1;
    global = get_state();
    if (__indexOf.call(global.past_states, state_name) >= 0) {
      return false;
    }
    state = cow_states[state_name];
    if (state.prerequisites) {
      if (global.avoidant < state.prerequisites.avoidant) {
        return false;
      }
      if (global.supportive < state.prerequisites.supportive) {
        return false;
      }
      if (global.controlling < state.prerequisites.controlling) {
        return false;
      }
      if (typeof state.prerequisites.flags === "string") {
        if (_ref = state.prerequisites.flags, __indexOf.call(global.flags, _ref) < 0) {
          return false;
        }
      } else {
        _ref1 = state.prerequisites.flags || [];
        for (_i = 0, _len = _ref1.length; _i < _len; _i++) {
          flag = _ref1[_i];
          if (__indexOf.call(global.flags, flag) < 0) {
            return false;
          }
        }
      }
    }
    return true;
  };
  choice = function(list) {
    var r;
    r = Math.floor(Math.random() * list.length);
    return list[r];
  };
  random_state = function() {
    var state_name, valid_states;
    valid_states = (function() {
      var _results;
      _results = [];
      for (state_name in cow_states) {
        if (is_valid_state(state_name)) {
          _results.push(state_name);
        }
      }
      return _results;
    })();
    console.log("Valid states", valid_states);
    return render_state(choice(valid_states));
  };
  pick_valid_state = function(state_names) {
    var state_name, valid_states;
    if (state_names == null) {
      return null;
    }
    if (typeof state_names === "string") {
      if (is_valid_state(state_names)) {
        return state_names;
      } else {
        return null;
      }
    }
    valid_states = (function() {
      var _i, _len, _results;
      _results = [];
      for (_i = 0, _len = state_names.length; _i < _len; _i++) {
        state_name = state_names[_i];
        if (is_valid_state(state_name)) {
          _results.push(state_name);
        }
      }
      return _results;
    })();
    console.log("NOW VALID", valid_states);
    if (valid_states.length === 0) {
      return null;
    }
    return choice(valid_states);
  };
  render_state = function(state_name) {
    var action_set, actions_div, adiv, apparel, global, next, state, type, _i, _len, _ref, _ref1, _results;
    state = cow_states[state_name];
    global = get_state();
    console.log(global);
    global.past_states.push(state_name);
    add_or_remove_flags(state.flags);
    console.log("Rendering " + state_name + " -> " + state.title);
    document.getElementById("title").innerText = state.title;
    actions_div = document.getElementById("actions");
    actions_div.innerHTML = "";
    if (state.apparel === "None") {
      document.getElementById("apparel").innerHTML = "";
    } else if (typeof state.apparel === "string") {
      add_or_remove_apparel(state.apparel);
    } else {
      _ref = state.apparel || [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        apparel = _ref[_i];
        add_or_remove_apparel(apparel);
      }
    }
    if (state.style) {
      set_style(state.style);
    }
    _ref1 = state.actions;
    _results = [];
    for (type in _ref1) {
      action_set = _ref1[type];
      adiv = document.createElement("div");
      adiv.setAttribute('data-action-type', type);
      if (typeof action_set === "string") {
        adiv.innerText = action_set;
        adiv.onclick = function(e) {
          global[e.target.getAttribute('data-action-type')] += 1;
          return random_state();
        };
      } else {
        adiv.innerText = action_set.label;
        next = pick_valid_state(action_set.results);
        console.log("next up", next);
        adiv.setAttribute("data-style", action_set.style);
        if (next) {
          adiv.setAttribute("data-next", next);
          adiv.onclick = function(e) {
            global[e.target.getAttribute('data-action-type')] += 1;
            if (e.target.getAttribute("data-style")) {
              set_style(action_set.style);
            }
            return render_state(e.target.getAttribute("data-next"));
          };
        } else {
          adiv.onclick = function(e) {
            global[e.target.getAttribute('data-action-type')] += 1;
            if (e.target.getAttribute("data-style")) {
              set_style(action_set.style);
            }
            return random_state();
          };
        }
      }
      adiv.className = 'action';
      _results.push(actions_div.appendChild(adiv));
    }
    return _results;
  };
  return render_state("basic");
});


//# sourceMappingURL=cow.js.map