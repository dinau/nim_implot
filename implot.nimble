# Package

version     = "1.2.0-wip"
author      = "dinau"
description = "ImPlot bindings for Nim"
license     = "MIT"
srcDir      = "src"
skipDirs    = @["tests","examples","img"]

# Dependencies

requires "nim >= 2.2.10"
requires "https://github.com/nimgl/imgui == 1.93.1"
requires "nimgl >= 1.3.2"


import std/[strutils]
task gen, "Generate bindings from source":
  exec("nim c -r tools/generator.nim")

let opt = "-d:strip"
task test, "Create window with implot demo":
  exec("nim cpp -r $# examples/demo/imPlotDemo.nim" % [opt])
