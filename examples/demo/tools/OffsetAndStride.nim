import std/[math]
import imgui
import implot
import utils

#-----------------------------
# demo_Tools_OffsetAndStride()
#-----------------------------
proc demo_Tools_OffsetAndStride*() =
  const
    k_circles    = 11
    k_points_per = 50
    k_size       = 2 * k_points_per * k_circles
  var interleaved_data{.global.}:array[k_size,cdouble]
  for p in 0..<k_points_per:
    for c in 0..<k_circles:
      let r = c.cdouble / (k_circles - 1) * 0.2 + 0.2
      interleaved_data[p*2*k_circles + 2*c + 0] = 0.5 + r * cos(p.cdouble/k_points_per * 6.28)
      interleaved_data[p*2*k_circles + 2*c + 1] = 0.5 + r * sin(p.cdouble/k_points_per * 6.28)
  var offset = 0'i32
  igBulletText("Offsetting is useful for realtime plots (see above) and circular buffers.")
  igBulletText("Striding is useful for interleaved data (e.g. audio) or plotting structs.")
  igBulletText("Here, all circle data is stored in a single interleaved buffer:")
  igBulletText("[c0.x0 c0.y0 ... cn.x0 cn.y0 c0.x1 c0.y1 ... cn.x1 cn.y1 ... cn.xm cn.ym]")
  igBulletText("The offset value indicates which circle point index is considered the first.")
  igBulletText("Offsets can be negative and/or larger than the actual data count.")
  igSliderInt("Offset", offset.addr, -2*k_points_per, 2*k_points_per)
  if ipBeginPlot("##strideoffset",ImVec2(x: -1,y: 0),ImPlotFlags.Equal):
    defer: ipEndPlot()
    ipPushColormap(ImPlotColormap.Jet)
    var buff:array[32,cchar]
    for c in 0..<k_circles:
      discard snprintf(buff.ptz.cstringCast, sizeof(buff).cint, "Circle %d".cstring, c.cint)
      ipPlotLine(buff.ptz.cstringCast, interleaved_data[c*2 + 0].addr
                     , interleaved_data[c*2 + 1].addr
                     , k_points_per, 0.ImPlotLineFlags, offset, 2*k_circles*sizeof(double))
    ipPopColormap()
  #offset++ uncomment for animation!
