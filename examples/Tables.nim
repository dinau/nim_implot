import std/[random]
import imgui
import implot
import utils


#-----------------
# demo_Tables()
#-----------------
proc demo_Tables*() =
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
      randomize(row) # srand() : C++
      for i in 0..<100:
        data[i] = RandomRange(0.0f,10.0f)
      igTableSetColumnIndex(0)
      igText("EMG %d", row)
      igTableSetColumnIndex(1)
      igText("%.3f V", data[offset])
      igTableSetColumnIndex(2)
      igPushID(row)
      var map:ImVec4
      ipGetColormapColorNonUDT(addr map,row)
      sparkline("##spark",addr data[0],100,0,11.0f,offset.int32,map,ImVec2(x: -1, y: 35))
      igPopID()

    igEndTable()
