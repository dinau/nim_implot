import imgui

#--------------------
# demo_simpleImGui()
#--------------------
proc demo_simpleImGui*() =
  var
    somefloat{.global.} = 0.0f
    counter{.global.} = 0

  igText("This is some useful text.")
  igSliderFloat("float", somefloat.addr, 0.0f, 1.0f)
  if igButton("Button", ImVec2(x: 0, y: 0)):
    counter.inc
  igSameLine()
  igText("counter = %d", counter)

