import imgui
import implot

#---------------
# demo_Images()
#---------------
proc demo_Images*() =
  igBulletText("Below we are displaying the font texture, which is the only texture we have\naccess to in this demo.")
  igBulletText("Use the 'ImTextureID' type as storage to pass pointers or identifiers to your\nown texture data.")
  igBulletText("See ImGui Wiki page 'Image Loading and Displaying Examples'.")
  var
    bmin{.global.} = [0.cfloat, 0]
    bmax{.global.} = [1.cfloat, 1]
    uv0 {.global.} = [0.cfloat, 0]
    uv1 {.global.} = [1.cfloat, 1]
    tint{.global.} = [1.cfloat, 1, 1, 1]

  igSliderFloat2("Min", bmin, -2, 2, "%.1f")
  igSliderFloat2("Max", bmax, -2, 2, "%.1f")
  igSliderFloat2("UV0", uv0,  -2, 2, "%.1f")
  igSliderFloat2("UV1", uv1,  -2, 2, "%.1f")
  igColorEdit4("Tint",tint)

  if ipBeginPlot("##image"):
    var # TODO
      bminPoint = ImPlotPoint(x: bmin[0], y: bmin[1])
      bmaxPoint = ImPlotPoint(x: bmax[0], y: bmax[1])
      uv0Vec2   = ImVec2(x: uv0[0], y: uv0[1])
      uv1Vec2   = ImVec2(x: uv1[0], y: uv1[1])
      tintVec4  = ImVec4( x: tint[0], y: tint[1], z: tint[2], w: tint[3])
    ipPlotImage("my image",igGetIO().fonts.texID
                 , bminPoint, bmaxPoint
                 , uv0Vec2 , uv1Vec2
                 , tintVec4)
    ipEndPlot()
