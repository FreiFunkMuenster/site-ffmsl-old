GLUON_SITE_PACKAGES := \
	gluon-respondd\
	gluon-autoupdater \
	gluon-config-mode-autoupdater \
	gluon-config-mode-contact-info \
	gluon-config-mode-core \
	gluon-config-mode-geo-location \
	gluon-config-mode-hostname \
	gluon-ebtables-filter-multicast \
	gluon-ebtables-filter-ra-dhcp \
	gluon-ebtables-source-filter \
	gluon-web-admin \
	gluon-web-autoupdater \
	gluon-web-network \
	gluon-web-private-wifi \
	gluon-web-wifi-config \
	gluon-mesh-batman-adv-15 \
	gluon-mesh-vpn-tunneldigger \
	gluon-radvd \
	gluon-setup-mode \
	gluon-status-page \
	haveged \
	iptables \
	gluon-mesh-vpn-core \
	iwinfo \
	gluon-ssid-changer \
	gluon-config-mode-show-mac \
	gluon-rfkill-disable

GLUON_PRIORITY ?= 3
GLUON_LANGS ?= en de
GLUON_ATH10K_MESH := ibss
GLUON_REGION := eu
