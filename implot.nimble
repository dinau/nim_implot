# Package

version     = "0.16.8"
author      = "dinau"
description = "ImPlot bindings for Nim"
license     = "MIT"
srcDir      = "src"
skipDirs    = @["tests","examples","img"]

# Dependencies

requires "nim >= 1.6.0" # Depends on [HoleEnumConv] warning
requires "nimgl >= 1.3.2"
requires "https://github.com/dinau/nimgl-imgui == 1.89.9.6"


import std/[strutils]
task gen, "Generate bindings from source":
  exec("nim c -r tools/generator.nim")

let opt = "-d:strip"
task test, "Create window with implot demo":
  exec("nim cpp -r $# examples/demo/imPlotDemo.nim" % [opt])
