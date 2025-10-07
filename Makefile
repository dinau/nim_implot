all:
	@$(MAKE) -C examples/demo

clean:
	@$(MAKE) -C examples/demo $@

run:
	@$(MAKE) -C examples/demo $@
