import imgui

const IMPLOT_AUTO_COL* =  ImVec4(x: 0,y: 0,z: 0,w: -1)

# define CHECKBOX_FLAG(flags, flag) ImGui::CheckboxFlags(#flag, (unsigned int*)&flags, flag)
template CHECKBOX_FLAG*(flags, flag: untyped) =
  igCheckboxFlags($flag, cast[ptr int32](addr flags), flag.int32)

const RAND_MAX* = 0x7FFF.int
template RandomRange*[T](vmin, vmax: T): T =
  let scale: T = T(rand(RAND_MAX)) / T(RAND_MAX)
  vmin + scale * (vmax - vmin)
