# Modified: for ImPlot by dinau 2023/09
# Copyright 2019, NimGL contributors.

import imgui, imgui/[impl_opengl, impl_glfw]
import nimgl/[opengl, glfw]
import implot

import indexDemo

#---------------------
# Forward definitions
#---------------------

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
  glfwWindowHint(GLFWVisible, GLFW_FALSE) # Hide main window at start up time. See TODO 1

  var glfwWindow: GLFWWindow = glfwCreateWindow(1080, 800)
  if glfwWindow == nil:
    quit(-1)
  glfwWindow.makeContextCurrent()
  defer: glfwWindow.destroyWindow()

  glfwSwapInterval(1) # Enable vsync

  doAssert glInit()

  var context = igCreateContext()
  defer: context.igDestroyContext()

  # setup ImPlot
  var imPlotContext = ipCreateContext()
  defer: imPlotContext.ipDestroyContext()

  doAssert igGlfwInitForOpenGL(glfwWindow, true)
  defer: igGlfwShutdown()
  #
  doAssert igOpenGL3Init()
  defer: igOpenGL3Shutdown()

  #imgui.igStyleColorsCherry()

  var
    showDemoImplot: bool = true
    showDemoImgui: bool = false
    showWindowDelay = 1 # TODO 1

  #-----------
  # Main loop
  #-----------
  while not glfwWindow.windowShouldClose:
    glfwPollEvents()

    igOpenGL3NewFrame()
    igGlfwNewFrame()
    igNewFrame()

    if showDemoImplot:
      ipShowDemoWindow(showDemoImplot.addr)
    if showDemoImgui:
      igShowDemoWindow(showDemoImgui.addr)

    #-------------
    # Demo Window
    #-------------
    igSetNextWindowPos(ImVec2(x: 25, y: 25), FirstUseEver)
    igSetNextWindowSize(ImVec2(x: 580, y: 400), FirstUseEver)
    block:
      igBegin("All Demos have been written in Nim language." & "  [ Nim-" & Nimversion & " ]")
      defer: igEnd()
      igText("Application average %.3f ms/frame (%.1f FPS)",
                 1000.0f / igGetIO().framerate, igGetIO().framerate)
      igCheckbox("ImPlot Demo", showDemoImPlot.addr)
      igSameLine()
      igCheckbox("ImGui Demo", showDemoImgui.addr)

      # ImPlot test window
      imPlotDemoTabs()

    #
    igRender()
    glClearColor(0.45f, 0.55f, 0.60f, 1.00f)
    glClear(GL_COLOR_BUFFER_BIT)
    igOpenGL3RenderDrawData(igGetDrawData())
    glfwWindow.swapBuffers()
    #
    if showWindowDelay > 0:
      dec showWindowDelay
    else:
      once: # Avoid flickering screen at startup.
        glfwWindow.showWindow()

#--------
# main()
#--------
main()
