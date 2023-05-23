##	gluon site.mk makefile 

##	GLUON_FEATURES
#		Specify Gluon features/packages to enable;
#		Gluon will automatically enable a set of packages
#		depending on the combination of features listed

GLUON_FEATURES := \
	autoupdater \
	config-mode-domain-select \
	config-mode-geo-location-osm \
	ebtables-filter-multicast \
	ebtables-filter-ra-dhcp \
	ebtables-limit-arp \
	ebtables-source-filter \
	mesh-batman-adv-15 \
	mesh-vpn-fastd-l2tp \
	radvd \
	radv-filterd \
	respondd \
	status-page \
	web-advanced \
	web-logging \
        web-private-wifi \
	web-wizard \
	advancedstats \
        config-mode-statistics \
	ssid-changer \
        rfkill-disable

GLUON_FEATURES_standard := \
	web-cellular \
	wireless-encryption-wpa3

##	GLUON_SITE_PACKAGES
#		Specify additional Gluon/OpenWrt packages to include here;
#		A minus sign may be prepended to remove a packages from the
#		selection that would be enabled by default or due to the
#		chosen feature flags

GLUON_SITE_PACKAGES := \
	ca-bundle \
	iwinfo \
	libustream-wolfssl \
	respondd-module-airtime

GLUON_SITE_PACKAGES_standard := \
	ffda-gluon-usteer

##	DEFAULT_GLUON_RELEASE
#		version string to use for images
#		gluon relies on
#			opkg compare-versions "$1" '>>' "$2"
#		to decide if a version is newer or not.

DEFAULT_GLUON_RELEASE := 2022.1at$(shell date '+%Y%m%d')
DEFAULT_GLUON_PRIORITY := 0

# Variables set with ?= can be overwritten from the command line

# Allow overriding the release number from the command line
GLUON_RELEASE ?= $(DEFAULT_GLUON_RELEASE)
GLUON_PRIORITY ?= ${DEFAULT_GLUON_PRIORITY}

# Region code required for some images; supported values: us eu
GLUON_REGION ?= eu

# Languages to include
GLUON_LANGS ?= en de

# Don't build factory firmware for deprecated devices
GLUON_DEPRECATED ?= upgrade
