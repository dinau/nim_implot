# Modified: for ImPlot by dinau 2023/09
# Copyright 2019, NimGL contributors.

import std/[math, random, sugar, sequtils]
import imgui, imgui/[impl_opengl, impl_glfw]
import nimgl/[opengl, glfw]
import implot

#---------------------
# Forward definitions
#---------------------
proc imPlotDemoTabs()
proc demo_LinePlots()
proc demo_SimplePlot()
proc demo_Histogram()
proc demo_simpleImGui()

var
  showDemoImplot: bool = true
  showDemoImgui: bool = false

#----------
# main()
#----------
proc main() =
  doAssert glfwInit()
  defer: glfwTerminate()

  glfwWindowHint(GLFWContextVersionMajor, 3)
  glfwWindowHint(GLFWContextVersionMinor, 3)
  glfwWindowHint(GLFWOpenglForwardCompat, GLFW_TRUE)
  glfwWindowHint(GLFWOpenglProfile, GLFW_OPENGL_CORE_PROFILE)
  glfwWindowHint(GLFWResizable, GLFW_TRUE)

  var glfwWindow: GLFWWindow = glfwCreateWindow(1080, 800)
  if glfwWindow == nil:
    quit(-1)
  glfwWindow.makeContextCurrent()
  defer: glfwWindow.destroyWindow()

  glfwSwapInterval(1) # Enable vsync

  doAssert glInit()

  let context = igCreateContext()
  defer: context.igDestroyContext()

  # setup ImPlot
  var imPlotContext = ipCreateContext()
  defer: imPlotContext.ipDestroyContext()

  doAssert igGlfwInitForOpenGL(glfwWindow, true)
  defer: igGlfwShutdown()
  #
  doAssert igOpenGL3Init()
  defer: igOpenGL3Shutdown()

  #implot.igStyleColorsCherry()
  #imgui.igStyleColorsCherry()

  #-----------
  # Main loop
  #-----------
  while not glfwWindow.windowShouldClose:
    glfwPollEvents()

    igOpenGL3NewFrame()
    igGlfwNewFrame()
    igNewFrame()

    if showDemoImgui:
      igShowDemoWindow(showDemoImgui.addr)
    if showDemoImplot:
      ipShowDemoWindow(showDemoImplot.addr)

    #-------------
    # Demo Window
    #-------------
    block:
      igSetNextWindowPos(ImVec2(x: 25, y: 25), FirstUseEver)
      igSetNextWindowSize(ImVec2(x: 400, y: 400), FirstUseEver)
      igBegin("This Demos have been written in Nim language.")
      defer: igEnd()
      igText("Application average %.3f ms/frame (%.1f FPS)",
                 1000.0f / igGetIO().framerate, igGetIO().framerate)
      # ImPlot test window
      imPlotDemoTabs()

    igRender()
    glClearColor(0.45f, 0.55f, 0.60f, 1.00f)
    glClear(GL_COLOR_BUFFER_BIT)
    igOpenGL3RenderDrawData(igGetDrawData())
    glfwWindow.swapBuffers()

#---------------
# demoHeaeder()
#---------------
proc demoHeader(label: string, demo: proc()) =
  if igTreeNodeEx(label.cstring):
    demo()
    igTreePop()

#------------------
# imPlotDemoTabs()
#------------------
proc imPlotDemoTabs() =
  if igBeginTabBar("ImPlotDemoTabs"):
    defer: igEndTabBar()
    if (igBeginTabItem("ImPlot")):
      defer: igEndTabItem()
      demoHeader("Simple Plots", demo_SimplePlot)
      demoHeader("Line Plots", demo_LinePlots)
      demoHeader("Histogram", demo_Histogram)
    if (igBeginTabItem("ImGui")):
      defer: igEndTabItem()
      demoHeader("Simple demo", demo_simpleImGui)

#------------------
# demo_LinePlots()
#------------------
proc demo_LinePlots() =
  var
    xs1{.global.}: array[1001, float]
    ys1{.global.}: array[1001, float]
  for i in 0..<1001:
    xs1[i] = i.float * 0.001f
    ys1[i] = 0.5f + 0.5f * sin(50 * (xs1[i] + igGetTime().float / 10))
  var
    xs2{.global.}: array[20, float64]
    ys2{.global.}: array[20, float64]
  for i in 0..<20:
    xs2[i] = i.float * 1/19.0f
    ys2[i] = xs2[i] * xs2[i]
  if ipBeginPlot("Line Plots"):
    defer: ipEndPlot()
    ipSetupAxes("x", "y")
    ipPlotLine("f(x)", addr xs1[0], addr ys1[0], 1001)
    ipSetNextMarkerStyle(Circle)
    ipPlotLine("g(x)", addr xs2[0], addr ys2[0], 20, Segments)

#------------------
# demo_Histogram()
#------------------
proc demo_Histogram() =
  const
    mu: double = 5
    sigma: double = 2
  var
    dist      {.global.}: seq[cfloat64]
    hist_flags{.global.} = Density.int32
    bins      {.global.}: ImPlotBin = cast[ImPlotBin](50)
  once:
    discard initRand()
    dist = collect(for i in 0..<10000: gauss(mu, sigma).cfloat64)

  igSetNextItemWidth(200)
  if igRadioButton("Sqrt", bins == Sqrt): bins = Sqrt
  igSameLine()
  if igRadioButton("Sturges", bins == Sturges): bins = Sturges
  igSameLine()
  if igRadioButton("Rice", bins == Rice): bins = Rice
  igSameLine()
  if igRadioButton("Scott", bins == Scott): bins = Scott
  #igSameLine()
  if igRadioButton("N Bins", bins.int32 >= 0): bins = cast[ImPlotBin](50)
  if bins.int32 >= 0:
    igSameLine()
    igSetNextItemWidth(200)
    igSliderInt("##Bins", cast[ptr int32](addr bins), 1, 100)

  igCheckboxFlags("Horizontal", addr hist_flags, ImPlotHistogramFlags.Horizontal.int32)
  igSameLine()
  igCheckboxFlags("Density", addr hist_flags, Density.int32)
  igSameLine()
  igCheckboxFlags("Cumulative", addr hist_flags, Cumulative.int32)

  var frange{.global.} = false
  igCheckbox("Range", addr frange)
  var
    rmin{.global.}: cfloat = -3
    rmax{.global.}: cfloat = 13
    range1{.global.} = [rmin, rmax]
  if frange:
    igSameLine()
    igSetNextItemWidth(200)
    igDragFloat2("##Range", range1, 0.1f, -3, 13)
    rmin = range1[0]
    rmax = range1[1]
    igSameLine()
    igCheckboxFlags("Exclude Outliers", addr hist_flags, NoOutliers.int32)

  #static NormalDistribution<10000> dist(mu, sigma)
  var
    x{.global.}: array[100, double]
    y{.global.}: array[100, double]
  if 0 != (hist_flags and Density.int32):
    for i in 0..<100:
      x[i] = -3 + 16 * i.double / 99.0
      y[i] = exp( - (x[i] - mu) * (x[i] - mu) / (2 * sigma * sigma)) / (sigma * sqrt(2 * 3.141592653589793238))
    if 0 != (hist_flags and Cumulative.int32):
      for i in 1..<100:
        y[i] += y[i-1]
      for i in 0..<100:
        y[i] /= y[99]

  if ipBeginPlot("##Histograms"):
    defer: ipEndPlot()
    ipSetupAxes(nil, nil, AutoFit, AutoFit)
    const IMPLOT_AUTO_COL =  ImVec4(x: 0,y: 0,z: 0,w: -1)
    ipSetNextFillStyle(IMPLOT_AUTO_COL,0.5f)
    #ipSetNextFillStyle(ImVec4(x: 0, y: 0, z: 0, w: -1), 0.5f)
    ipPlotHistogram("Empirical", addr dist[0], 10000.int, bins.int,
                    1.0.cfloat64, (if frange: ImPlotRange(min: rmin, max: rmax) else: ImPlotRange()),
                    hist_flags.ImPlotHistogramFlags)
    if (0 != (hist_flags and Density.int32)) and not (0 != (hist_flags and NoOutliers.int32)):
      if 0 != (hist_flags and ImPlotHistogramFlags.Horizontal.int32):
        ipPlotLine("Theoretical", addr y[0], addr x[0], 100)
      else:
        ipPlotLine("Theoretical", addr x[0], addr y[0], 100)

#-------------------
# demo_SimplePlot()
#-------------------
proc demo_SimplePlot() =
  var
    bar_data{.global.}:seq[cint]
    x_data{.global.}:seq[cint]
    y_data{.global.}:seq[cint]
  once:
    discard initRand()
    bar_data = collect(for i in 0..10: rand(100).cint)
    x_data = collect(for i in 0..10: i.cint)
    y_data = x_data.mapIt((it * it).cint) # y = x^2

  if ipBeginPlot("My Plot"):
    defer: ipEndPlot()
    ipPlotBars("My Bar Plot", addr bar_data[0], bar_data.len)
    ipPlotLine("My Line Plot", addr x_data[0], addr y_data[0], xdata.len)

#--------------------
# demo_simpleImGui()
#--------------------
proc demo_simpleImGui() =
  var
    somefloat{.global.} = 0.0f
    counter{.global.} = 0

  igText("This is some useful text.")
  igCheckbox("ImPlot Demo Window", showDemoImPlot.addr)
  igCheckbox("ImGui Demo Window", showDemoImgui.addr)
  igSliderFloat("float", somefloat.addr, 0.0f, 1.0f)
  if igButton("Button", ImVec2(x: 0, y: 0)):
    counter.inc
  igSameLine()
  igText("counter = %d", counter)

#--------
# main()
#--------
main()
