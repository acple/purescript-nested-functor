let conf = ./spago.dhall

in conf // {
  dependencies = conf.dependencies # [ "console", "effect", "either", "identity", "psci-support" ]
, sources = conf.sources # [ "test/**/*.purs" ]
}
