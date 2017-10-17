# About domoticz-turris
OpenWRT Makefile for domoticz + turris dongle patchset + openzwave support

This is unofficial repository for openwrt build files for OpenWRT used in Turris/Omnia routers.
You can find prebuild binaries in Releases. 

# Installation
 opkg install domoticz_xxx.ipk

# Compilation
 - add repository to feeds.conf.default
 - add name of the repository to lists/base.lua.m4
 - ./scripts/feeds update -a
 - ./scripts/feeds install -a
 - make menuconfig (enable domoticz)
 - make -j4 package/domoticz/{clean,compile,install} V=s
 - enjoy from ./bin/<your arch>/package/<repo name>/domoticz_xxx.ipk
