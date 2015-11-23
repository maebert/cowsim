cow_states =

  basic:
    title: "cow exists."
    apparel: "None"
    style: "None"
    actions:
      avoidant:
        label: "leave cow alone"
        results: "gone"
      controlling: "poke cow with a stick"

  contemplating_doom:
    title: "cow is contemplating impending doom."
    prerequisites:
      avoidance: 4
    actions:
      avoidant: "stare at cow"
      supportive: "tell cow to cheer up"

  gone:
    title: "cow is gone."
    style: "gone"
    flags: "gone"
    actions:
      avoidant:
        label: "wait"
        results: ["still_gone", "returned"]
      controlling:
        label: "find new cow"
        results: "basic"

  still_gone:
    title: "cow is still gone."
    style: "gone"
    prerequisites:
      flags: "gone"
    actions:
      avoidant:
        label: "wait"
        results: ["still_gone", "returned"]
      controlling:
        label: "find new cow"
        results: "basic"

  returned:
    title: "cow has returned"
    style: "None"
    flags: "-gone"
    prerequisites:
      flags: "gone"
    actions:
      supportive:  "welcome cow back"
      avoidant: "pretend you didn't notice cow was gone"

  funny:
    title: "cow looks funny."
    style: "funny"
    actions:
      avoidant: "pretend you didn't notice"
      controlling:
        label: "paint it black"
        style: "dark"

  abstract:
    title: "cow is an abstract representation of itself."
    style: "abstract"
    actions:
      avoidant: "cow is void of meaning"
      # @TODO

  vacation:
    title: "cow wants to go on vacation."
    prerequisites:
      supportive: 3
    apparel: "shirt"
    actions:
      supportive: "let cow go"
      controlling: "demand more milk"

  margritte:
    title: "ceci n'est pas un vache."
    actions:
      controlling: "le vache, c'est moi!"

  strike:
    title: "cow refuses to give milk"
    prerequisites:
      controlling: 4
    actions:
      supportive: "allow cow to unionise"
      controlling: "take what's yours"

  simulation:
    title: "cow is a complete simulation of itself"
    actions:
      supportive: "tell cow to simulate happiness"
      controlling: "demand simulated milk"

  fading:
    title: "cow is slowly fading from reality"
    prerequisites:
      avoidant: 5
    style: "fading"
    actions:
      supportive:
        label: "realise your loss"
        results: "gone"
      avoidant:
        label: "reject the notion of reality"
        results: "gone"

  terrified:
    title: "cow is terrified"
    prerequisites:
      avoiding: 3
    actions:
      supportive: "sing to cow"
      avoidant: "be terrified yourself"

  friend:
    title: "cow found a friend"
    global_style: "friend"
    prerequisites:
      supportive: 2
    actions:
      supportive: "welcome friend"
      controlling:
        label: "tell cow to be self-sufficient"
        results: "refuse"

  refuse:
    title: "cow refuses to let go"
    prerequisites:
      flags: "friend"
    actions:
      avoidant: "pretend friend doesn't exist"
      controlling:
        label: "take friend away"
        results: ["friend_gone", "rebel"]

  friend_gone:
    title: "cow's friend is gone'"
    prerequisites:
      flags: "friend"
    actions:
      supportive: "tell cow there are many fish in the sea"
      avoidant: "some day, cow will be gone too"

  rebel:
    title: "cow rejects your authority"
    prerequisites:
      controlling: "5"
    apparel: "ammunition_belt"
    headwear: "bandana"
    actions:
      controlling: "punish cow's insubordinance"
      avoidant: "ignore cow"

  incomplete:
    title: "cow feels incomplete"
    prerequisites:
      avoidant: "3"
    actions:
      avoidant: "cow is whatever cow is"
      supportive:
        label: "fill cow's void"
        style: "funny"

  darkness:
    title: "cow's inner darkness manifests itself"
    style: "dark"
    prerequisites:
      avoidant: "4"
    actions:
      controlling:
        label: "find a happier cow"
        results: "gone"
      avoidant: "realise that happiness is meaningless"


