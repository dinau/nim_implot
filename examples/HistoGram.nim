import std/[math, random, sugar]
import imgui
import implot
import utils

#------------------
# demo_Histogram()
#------------------
proc demo_Histogram*() =
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

#------------------
# demo_Histogram2D()
#------------------
proc demo_Histogram2D*() =
  var
    count{.global.}     = 50000.int32
    xybins{.global.} = [100.int32,100]
    hist_flags{.global.} = 0.int32
    dist1      {.global.}: seq[cfloat64]
    dist2      {.global.}: seq[cfloat64]
  once:
    discard initRand()
    dist1 = collect(for i in 0..<100000: gauss(1, 2).cfloat64)
    dist2 = collect(for i in 0..<100000: gauss(1, 1).cfloat64)

  igSliderInt("Count",addr count,100,100000)
  igSliderInt2("Bins", xybins,1,500)
  igSameLine()
  igCheckboxFlags("Density", addr hist_flags, Density.int32)
  #static NormalDistribution<100000> dist1(1, 2)
  #static NormalDistribution<100000> dist2(1, 1)
  var max_count = 0.cfloat64
  var flags = AutoFit.int32 or ImPlotAxisFlags.Foreground.int32
  ipPushColormap("Hot")
  var regn = ImVec2()
  igGetContentRegionAvailNonUDT(addr regn)
  if ipBeginPlot("##Hist2D",ImVec2(x: regn.x - 100 - igGetStyle().itemSpacing.x,y: 0)):
    ipSetupAxes(nullptr, nullptr, flags.ImPlotAxisFlags , flags.ImPlotAxisFlags )
    ipSetupAxesLimits(-6,6,-6,6)
    max_count = ipPlotHistogram2D("Hist2D"
                    ,addr dist1[0]
                    ,addr dist2[0]
                    ,count.int
                    ,xybins[0].int
                    ,xybins[1].int
                    ,ImPlotRect(x: ImPlotRange(min: -6,max: 6) ,y: ImPlotRange(min: -6,max: 6))
                    ,hist_flags.ImPlotHistogramFlags)
    ipEndPlot()
  igSameLine()
  ipColormapScale((if 0 != (hist_flags and Density.int32) : "Density" else: "Count").cstring
                   ,0,max_count,ImVec2(x: 100,y: 0))
  ipPopColormap()
