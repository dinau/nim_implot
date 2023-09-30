import imgui
import implot

#------------------------
# demo_Help_Help() {
#------------------------
proc demo_Help_Help*() =
    igText("ABOUT THIS DEMO:")
    igBulletText("Sections below are demonstrating many aspects of the library.")
    igBulletText("""The \"Tools\" menu above gives access to: Style Editors (ImPlot/ImGui)\n"
                        "and Metrics (general purpose Dear ImGui debugging tool).""")
    igSeparator()
    igText("PROGRAMMER GUIDE:")
    igBulletText("See the ShowDemoWindow() code in implot_demo.cpp. <- you are here!")
    igBulletText("If you see visual artifacts, do one of the following:")
    igIndent()
    igBulletText("Handle ImGuiBackendFlags_RendererHasVtxOffset for 16-bit indices in your backend.")
    igBulletText("Or, enable 32-bit indices in imconfig.h.")
    igBulletText("Your current configuration is:")
    igIndent()
    igBulletText("ImDrawIdx: %d-bit", (int)(sizeof(ImDrawIdx) * 8))
    igBulletText("ImGuiBackendFlags_RendererHasVtxOffset: %s"
               , if 0 != (igGetIO().backendFlags.uint32 and ImGuiBackendFlags.RendererHasVtxOffset.uint32) : "True".cstring else: "False".cstring)
    igUnindent()
    igUnindent()
    igSeparator()
    igText("USER GUIDE:")
    ipShowUserGuide()
