import imgui
import implot
import utils

var msvcRandState {.global.}: uint32

proc msvcSrand(seed: uint32) =
  msvcRandState = seed

proc msvcRand(): cint =
  # Match the MSVC CRT rand sequence used by the C++ demo.
  msvcRandState = msvcRandState * 214013'u32 + 2531011'u32
  result = ((msvcRandState shr 16) and 0x7FFF'u32).cint

#-----------------------
# demo_Subplots_Tables()
#-----------------------
proc demo_Subplots_Tables*() =
  var
    flags{.global.} = ImGuiTableFlags.BordersOuter or ImGuiTableFlags.BordersV or
                      ImGuiTableFlags.RowBg or ImGuiTableFlags.Resizable or
                      ImGuiTableFlags.Reorderable
    anim{.global.} = true
    offset{.global.} = 0

  igBulletText("Plots can be used inside of ImGui tables as another means of creating subplots.")
  igCheckbox("Animate",addr anim)
  if anim:
      offset = (offset + 1) mod 100
  if igBeginTable("##table", 3, flags, ImVec2(x: -1,y: 0)):
    igTableSetupColumn("Electrode", ImGuiTableColumnFlags.WidthFixed, 75.0f)
    igTableSetupColumn("Voltage", ImGuiTableColumnFlags.WidthFixed, 75.0f)
    igTableSetupColumn("EMG Signal")
    igTableHeadersRow()
    ipPushColormap(ImPlotColormap.Cool)
    for row in 0..<10.int32:
      igTableNextRow()
      var data{.global.}: array[100,cfloat]
      msvcSrand(row.uint32)
      for i in 0..<100:
        let scale = msvcRand().cfloat / 32767.0f
        data[i] = scale * 10.0f
      igTableSetColumnIndex(0)
      igText("EMG %d", row)
      igTableSetColumnIndex(1)
      igText("%.3f V", data[offset])
      igTableSetColumnIndex(2)
      igPushID(row)
      var map:ImVec4
      ipGetColormapColorNonUDT(addr map,row)
      sparkline("##spark",data.ptz,100,0,11.0f,offset.int32,map,ImVec2(x: -1, y: 35))
      igPopID()

    ipPopColormap()
    igEndTable()
