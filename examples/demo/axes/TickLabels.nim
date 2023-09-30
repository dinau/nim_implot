import imgui
import implot
import utils


#------------------------
# demo_Axes_TickLabels()
#------------------------
proc demo_Axes_TickLabels*()  =
  var
    custom_fmt   {.global} = true
    custom_ticks {.global} = false
    custom_labels{.global} = true
  igCheckbox("Show Custom Format", custom_fmt.addr)
  igSameLine()
  igCheckbox("Show Custom Ticks", custom_ticks.addr)
  if custom_ticks:
    igSameLine()
    igCheckbox("Show Custom Labels", custom_labels.addr)
  var pi = 3.14.cdouble
  var
    pi_str = "PI".cstring
    yticks{.global} = [100.cdouble,300,700,900]
  var ylabels = ["One".cstring,"Three","Seven","Nine"]
  var yticks_aux = [0.cdouble,2,0.4,0.6]
  var ylabels_aux = ["A".cstring,"B","C","D","E","F"]
  if ipBeginPlot("##Ticks"):
    defer: ipEndPlot()
    ipSetupAxesLimits(2.5,5,0,1000)
    ipSetupAxis(ImAxis.Y2, nullptr, ImPlotAxisFlags.AuxDefault)
    ipSetupAxis(ImAxis.Y3, nullptr, ImPlotAxisFlags.AuxDefault)
    if custom_fmt:
      ipSetupAxisFormat(ImAxis.X1, "%g ms")
      ipSetupAxisFormat(ImAxis.Y1, MetricFormatter, "Hz".cstring)
      ipSetupAxisFormat(ImAxis.Y2, "%g dB")
      ipSetupAxisFormat(ImAxis.Y3, MetricFormatter, "m".cstring)
    if custom_ticks:
      ipSetupAxisTicks(ImAxis.X1, pi.addr,1,if custom_labels : pi_str.addr else: nullptr, true)
      ipSetupAxisTicks(ImAxis.Y1, yticks.ptz, 4, if custom_labels : ylabels.ptz else: nullptr, false)
      ipSetupAxisTicks(ImAxis.Y2, yticks_aux.ptz, 3, if custom_labels : ylabels_aux.ptz else: nullptr, false)
      ipSetupAxisTicks(ImAxis.Y3, 0, 1, 6, if custom_labels : ylabels_aux.ptz else: nullptr, false)
