extensions := ddtrace

.DEFAULT_GOAL := build
.PHONY: build publish $(extensions)

publish build: $(extensions)

$(extensions):
	$(MAKE) -C $@ $(TARGET)

