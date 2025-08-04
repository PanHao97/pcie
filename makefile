# 编译器设置
CC = gcc
CFLAGS = -Wall -Wextra -I./drv -D_DEBUG_
LDFLAGS = -lpthread -lrt  # 添加pthread库链接
LIB_PATH = -L./lib 
LIB_NAMES = -lpthread -lextended_pico_cell -lm

# 源文件和目录设置
SRC_DIR = src
DRV_DIR = drv
BUILD_DIR = build

# 获取所有源文件
SRC_FILES = $(wildcard $(SRC_DIR)/*.c)
DRV_FILES = $(wildcard $(DRV_DIR)/*.c)
ALL_SOURCES = $(SRC_FILES) $(DRV_FILES)

# 生成对应的目标文件列表
OBJ_FILES = $(patsubst %.c,$(BUILD_DIR)/%.o,$(notdir $(ALL_SOURCES)))

# 最终目标
TARGET = pcie2000

.PHONY: all clean

all: $(BUILD_DIR) $(TARGET)

# 创建构建目录
$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

# 链接生成最终目标
$(TARGET): $(OBJ_FILES)
	$(CC) $^ $(LIB_PATH) $(LIB_NAMES) -o $@ $(LDFLAGS)

# 编译src目录下的源文件
$(BUILD_DIR)/%.o: $(SRC_DIR)/%.c
	$(CC) $(CFLAGS) -c $< $(LIB_PATH) $(LIB_NAMES) -o $@

# 编译drv目录下的源文件
$(BUILD_DIR)/%.o: $(DRV_DIR)/%.c
	$(CC) $(CFLAGS) -c $< $(LIB_PATH) $(LIB_NAMES) -o $@

# 清理生成的文件
clean:
	rm -rf $(BUILD_DIR) $(TARGET)