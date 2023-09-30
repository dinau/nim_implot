import std/[math]
import imgui
import implot
import utils

#// Example for Custom Data and Getters section.
type
  Vector2f = object
    x, y:cfloat

proc Spiral(data: pointer, idx: cint , point: ptr ImPlotPoint) : pointer {.cdecl.} =
  var
    r = 0.9f            #// outer radius
    a = 0f              #// inner radius
    b = 0.05f           #// increment per rev
    n = (r - a) / b     #// number  of revolutions
  let th = (2 * n * 3.14).cdouble;  #// angle
  let Th = (th * idx.cdouble / (1000 - 1)).cfloat
  point.x = (0.5f + (a + b*Th / (2.0f * 3.14))*cos(Th)).cfloat
  point.y = (0.5f + (a + b*Th / (2.0f * 3.14))*sin(Th)).cfloat

#-----------------------------------
# demo_Custom_CustomDataAndGetters()
#-----------------------------------
proc demo_Custom_CustomDataAndGetters*() =
  igBulletText("You can plot custom structs using the stride feature.")
  igBulletText("Most plotters can also be passed a function pointer for getting data.")
  igIndent()
  igBulletText("You can optionally pass user data to be given to your getter function.")
  igBulletText("C++ lambdas can be passed as function pointers as well!")
  igUnindent()

  var vec2_data = [ Vector2f(x: 0,y: 0), Vector2f(x:1,y: 1) ]

  if ipBeginPlot("##Custom Data"):
    defer: ipEndPlot()
    #// custom structs using stride example:
    ipPlotLine("Vector2f", vec2_data[0].x.addr, vec2_data[0].y.addr
                         , 2
                         , 0.ImPlotLineFlags, 0, #[sizeof(Vector2f).int32]# (sizeof(cfloat) * 2).int32 )

    #// custom getter example 1:
    ipPlotLineG("Spiral", Spiral, nullptr, 1000)

      #// custom getter example 2:
    var
      data1 = WaveData(X: 0.001, Amp: 0.2, Freq: 2, Offset: 0.75)
      data2 = WaveData(X: 0.001, Amp: 0.2, Freq: 4, Offset: 0.25)
    ipPlotLineG("Waves", SineWave2, data1.addr, 1000)
    ipPlotLineG("Waves", SawWave, data2.addr, 1000)
    ipPushStyleVar(ImPlotStyleVar.FillAlpha, 0.25f)
    ipPlotShadedG("Waves", SineWave2, data1.addr, SawWave, data2.addr, 1000)
    ipPopStyleVar()

    #// you can also pass C++ lambdas:
    #// auto lamda = [](void* data, int idx) { ... return ImPlotPoint(x,y); }
    #// ipPlotLine("My Lambda", lambda, data, 1000)
