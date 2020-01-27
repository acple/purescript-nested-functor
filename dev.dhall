let conf = ./spago.dhall

in conf //
  { dependencies = conf.dependencies #
    [ "console"
    , "effect"
    , "either"
    , "identity"
    , "psci-support"
    , "unsafe-coerce"
    ]
  , sources = conf.sources # [ "test/**/*.purs" ]
  }
