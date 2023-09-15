# Package

version     = "0.16"
author      = "dinau"
description = "ImPlot bindings for Nim"
license     = "MIT"
srcDir      = "src"
skipDirs    = @["tests"]

# Dependencies

requires "nim >= 1.6.0" # Depends on [HoleEnumConv] warning
requires "nimgl >= 1.3.2"
requires "https://github.com/dinau/nimgl-imgui >= 1.89.9.1"


import std/[strutils]
task gen, "Generate bindings from source":
  exec("nim c -r tools/generator.nim")

let opt = "-d:strip"
task test, "Create window with implot demo":
  exec("nim cpp -r $# tests/imPlotTest.nim" % [opt])

