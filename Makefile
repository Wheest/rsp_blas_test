BUILD_DIR=build
include $(N64_INST)/include/n64.mk

all: rspexplore.z64

$(BUILD_DIR)/rspexplore.elf: $(BUILD_DIR)/rspqdemo.o $(BUILD_DIR)/rsp_vec.o $(BUILD_DIR)/vec.o

rspexplore.z64: N64_ROM_TITLE="RSPQ Demo"

clean:
	rm -rf $(BUILD_DIR) rspexplore.z64

-include $(wildcard $(BUILD_DIR)/*.d)

.PHONY: all clean
