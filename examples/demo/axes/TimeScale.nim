import std/[math,times]
import imgui
import implot

#[// Huge data used by Time Formatting example (~500 MB allocation!)
struct HugeTimeData {
    HugeTimeData(double min) {
        Ts = new double[Size];
        Ys = new double[Size];
        for (int i = 0; i < Size; ++i) {
            Ts[i] = min + i;
            Ys[i] = GetY(Ts[i]);
        }
    }
    ~HugeTimeData() { delete[] Ts;  delete[] Ys; }
    static double GetY(double t) {
        return 0.5 + 0.25 * sin(t/86400/12) +  0.005 * sin(t/3600);
    }
    double* Ts;
    double* Ys;
    static const int Size = 60*60*24*366;
}; ]#

const Size = 60*60*24*366;
type
  HugeTimeData = ref object
    Ts*: array[Size,cdouble]
    Ys*: array[Size,cdouble]

proc GetY(t:cdouble) : cdouble =
  0.5 + 0.25 * sin(t/86400/12) +  0.005 * sin(t/3600);
proc newHugeTimeData(minf:cdouble): HugeTimeData =
  result.new
  for i in 0..<Size:
    result.Ts[i] = minf + i.cdouble
    result.Ys[i] = GetY(result.Ts[i])

#-----------------------
# demo_Axed_TimeScale()
#-----------------------
proc demo_Axes_TimeScale*() =
  var
    t_min{.global.} = 1609459200.cdouble #// 01/01/2021 @ 12:00:00am (UTC)
    t_max{.global.} = 1640995200.cdouble#// 01/01/2022 @ 12:00:00am (UTC)

  igBulletText("""When ImPlotAxisFlags_Time is enabled on the X-Axis, values are interpreted as\n
                      "UNIX timestamps in seconds and axis labels are formated as date/time.""") #
  igBulletText("By default, labels are in UTC time but can be set to use local time instead.")

  igCheckbox("Local Time",ipGetStyle().useLocalTime.addr)
  igSameLine()
  igCheckbox("ISO 8601",ipGetStyle().useISO8601.addr)
  igSameLine()
  igCheckbox("24 Hour Clock",ipGetStyle().use24HourClock.addr)

  var  data{.global.}: HugeTimeData = nullptr
  var sdata{.global.}: HugeTimeData
  if data == nullptr:
    igSameLine()
    if igButton("Generate Huge Data (~500MB!)"):
      once:
        sdata = newHugeTimeData(t_min) # TODO: Use --mm:refc
      data = sdata

  if ipBeginPlot("##Time", ImVec2(x: -1,y: 0)):
    ipSetupAxisScale(ImAxis.X1, ImPlotScale.Time)
    ipSetupAxesLimits(t_min,t_max,0,1)
    if data != nullptr:
      #// downsample our data
      var rect:ImPlotRect
      ipGetPlotLimitsNonUDT(rect.addr)
      var  start = (rect.x.min - t_min).int32
      var downsample = (rect.x.addr.size() / 1000 + 1).int32
      start = if start < 0 : 0 else: (if start > Size - 1 : Size - 1 else: start)
      var endi = ((rect.x.max - t_min) + 1000).int32
      endi = if endi < 0 : 0 else: (if endi > Size - 1 : Size - 1 else: endi)
      var size = (endi - start) div downsample
      #// plot it
      ipPlotLine("Time Series", data.Ts[start].addr
                              , data.Ys[start].addr
                              , size, 0.ImPlotLineFlags, 0, sizeof(cdouble) * downsample)
    #// plot time now
    var t_now = epochtime().cdouble
    var y_now = GetY(t_now)
    ipPlotScatter("Now",t_now.addr,y_now.addr,1)
    var vec4:ImVec4
    ipGetLastItemColorNonUdT(vec4.addr)
    ipAnnotation(t_now,y_now,vec4,ImVec2(x: 10,y: 10),false,"Now")
    ipEndPlot()
