all:
	@$(MAKE) -C examples/demo

clean:
	@$(MAKE) -C examples/demo $@

run:
	@$(MAKE) -C examples/demo $@

EXT_LIB_DIR = ../../imguin_git/libs
TARGET_DIR = src/implot/private

update: implot


implot:
	@echo [ CImPlot ] copying...
	@-mkdir -p $(TARGET_DIR)/c$@/$@
	@cp -f $(EXT_LIB_DIR)/c$@/{LICENSE,*.cpp,*.h,README.md}    $(TARGET_DIR)/c$@/
	@cp -f $(EXT_LIB_DIR)/c$@/$@/{LICENSE,*.cpp,*.h,README.md} $(TARGET_DIR)/c$@/$@/
