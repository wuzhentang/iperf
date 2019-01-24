LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

define all-c-files-under
	$(patsubst ./%,%, $(shell find $(LOCAL_PATH) -name  "examples" -prune -o  -name "*.c" \
		-and -not -name ".*" \
		-and -not -name "t_timer.c"  \
		-and -not -name "t_api.c" \
		-and -not -name "t_units.c" \
		-and -not -name "t_uuid.c"))
endef
	  
define all-subdir-c-files
	$(call all-c-files-under,.)
endef
			   
#C_FILES := $(filter-out "$(LOCAL_PATH)/src/t_timer.c" "$(LOCAL_PATH)/src/t_api.c" "$(LOCAL_PATH)/src/t_uuid.c" , $(call all-subdir-c-files))
C_FILES := $(call all-subdir-c-files)

#$(warning $(C_FILES)
  
LOCAL_SRC_FILES := $(C_FILES:$(LOCAL_PATH)/%=%)

LOCAL_C_INCLUDES += \
			$(LOCAL_PATH) \
			$(LOCAL_PATH)/include

LOCAL_CFLAGS += -O2 
LOCAL_CFLAGS += -DHAVE_CONFIG_H 
LOCAL_CFLAGS += -Iexternal/openssl/include
LOCAL_SHARED_LIBRARIES := libc libm libcutils libnetutils libcrypto 

LOCAL_MODULE := iperf 
LOCAL_MODULE_TAGS := debug 

include $(BUILD_EXECUTABLE) 
