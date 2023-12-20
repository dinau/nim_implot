TARGET = ImPlotDemo
OPT += -d:release
OPT += -d:strip
#OPT += --cc:vcc
all:
	nim cpp  $(OPT) --nimcache:.nimcache $(TARGET).nim

run: all
	#rm imgui.ini
	./$(TARGET)

gen:
	(cd ../..;nimble gen)

clean:
	-rm -fr .nimcache
	-rm $(TARGET)
