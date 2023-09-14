TARGET = imPlotTest
OPT += --passC:-static --passL:-static
all:
	nim cpp -d:release -d:strip $(OPT) --nimcache:.nimcache $(TARGET).nim

run: all
	#rm imgui.ini
	./$(TARGET)

gen:
	(cd ..;nimble gen)

clean:
	-rm -fr .nimcache
	-rm $(TARGET).exe
