include $(TOPDIR)/rules.mk

PKG_NAME:=open-zwave
PKG_VERSION:=1.5
PKG_RELEASE:=1

PKG_BUILD_DIR:=$(BUILD_DIR)/${PKG_NAME}-$(PKG_VERSION)
PKG_SOURCE:=V$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://github.com/OpenZWave/open-zwave/archive/


include $(INCLUDE_DIR)/package.mk

define Package/open-zwave
	SECTION:=libs
	CATEGORY:=Libraries
	DEPENDS:=+eudev +libstdcpp
	TITLE:=Open Z Wave Stack library
endef

define Package/openzwave/description
  Open Z-Wave Stack library
endef

define Build/Compile
	sed -i -e "s|-ludev|-ludev -L$(wildcard $(BUILD_DIR)/udev-*)/libudev/.libs -L$(STAGING_DIR)/lib|" \
		$(PKG_BUILD_DIR)/cpp/build/Makefile

	sed -i -e "s|-pthread|-pthread -ludev -L$(wildcard $(BUILD_DIR)/udev-*)/libudev/.libs -L$(STAGING_DIR)/lib|" \
		$(PKG_BUILD_DIR)/cpp/examples/MinOZW/Makefile

	$(MAKE) CROSS_COMPILE="$(TARGET_CROSS)" -C $(PKG_BUILD_DIR) all
endef

define Package/open-zwave/install
	$(INSTALL_DIR) $(1)/bin
	$(INSTALL_DIR) $(1)/etc/hotplug.d/usb
	$(INSTALL_DIR) $(1)/usr/lib
	$(INSTALL_DIR) $(1)/usr/share/openzwave

	$(INSTALL_DATA) ./files/20-zstick $(1)/etc/hotplug.d/usb
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/.lib/MinOZW $(1)/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/libopenzwave.s* $(1)/usr/lib
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/libopenzwave.a $(1)/usr/lib

	$(CP) $(PKG_BUILD_DIR)/config/* $(1)/usr/share/openzwave
endef

$(eval $(call BuildPackage,open-zwave))
