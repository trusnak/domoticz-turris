#
# Copyright (C) 2015 CZ.NIC, z. s. p. o. (https://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=domoticz
PKG_VERSION:=3.4834
PKG_RELEASE:=5
PKG_LICENSE:=GPL-3.0
PKG_LICENSE_FILES:=License.txt
PKG_MAINTAINER:=Pavel Spirek <pavel.spirek@nic.cz>

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/domoticz/domoticz.git
PKG_SOURCE_VERSION:=76374d093c98e78dc21f404a85555410b97e0d98
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)

CMAKE_INSTALL:=1

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/cmake.mk

define Package/domoticz
  SECTION:=utils
  CATEGORY:=Utilities
  SUBMENU:=Home Automation
  TITLE:=Domoticz Home Automation
  DEPENDS:=+zlib +libusb-1.0 +libusb-compat +libcurl +libsqlite3 +libopenssl +boost-system +boost-thread +boost-date_time +lm-sensors +udev
  URL:=https://domoticz.com/
endef

define Package/domoticz/description
  Domoticz is a Home Automation System that lets you monitor and configure various devices like:
  Lights, Switches, various sensors/meters like Temperature, Rain, Wind, UV, Electra, Gas, Water and much more.
  Notifications/Alerts can be sent to any mobile device.
endef

CMAKE_OPTIONS += \
	-DCMAKE_BUILD_TYPE=Release . \
	-DCPACK_STRIP_FILES=1

define Build/Prepare
	$(call Build/Prepare/Default)
#	echo "#define SVNVERSION  $(PKG_REV)-$(PKG_RELEASE)" > $(PKG_BUILD_DIR)/svnversion.h
endef

define Package/domoticz/conffiles
/etc/config/domoticz
endef

define Package/domoticz/install
	$(INSTALL_DIR) $(1)/usr/share/domoticz
	#$(CP) $(PKG_INSTALL_DIR)/usr/domoticz/svnversion.h $(1)/usr/share/domoticz/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/domoticz $(1)/usr/share/domoticz/
	$(CP) $(PKG_INSTALL_DIR)/usr/www $(1)/usr/share/domoticz/

	$(INSTALL_DIR) $(1)/usr/share/domoticz/scripts/lua/
	$(CP) $(PKG_INSTALL_DIR)/usr/scripts/lua/ $(1)/usr/share/domoticz/lua/

	$(INSTALL_DIR) $(1)/usr/bin/
	ln -sf ../share/domoticz/domoticz $(1)/usr/bin/domoticz

	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/domoticz.init $(1)/etc/init.d/domoticz

	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) ./files/domoticz.conf $(1)/etc/config/domoticz
endef

$(eval $(call BuildPackage,domoticz))
