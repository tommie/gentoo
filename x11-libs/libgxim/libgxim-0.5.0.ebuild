# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"
USE_RUBY="ruby21 ruby22 ruby23 ruby24"

inherit autotools ltprune ruby-single

DESCRIPTION="GObject-based XIM protocol library"
HOMEPAGE="https://tagoh.bitbucket.io/libgxim"
SRC_URI="https://bitbucket.org/tagoh/${PN}/downloads/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="${USE_RUBY//ruby/ruby_targets_ruby} static-libs test"

RDEPEND="dev-libs/dbus-glib
	dev-libs/glib:2
	sys-apps/dbus
	virtual/libintl
	x11-libs/gtk+:2"
DEPEND="${RDEPEND}
	${RUBY_DEPS}
	dev-util/intltool
	sys-devel/autoconf-archive
	sys-devel/gettext
	virtual/pkgconfig
	test? ( dev-libs/check )"

AT_M4DIR="m4macros"

src_prepare() {
	sed -i \
		-e "/PKG_CHECK_MODULES/s/\(check\)/$(usex test '\1' _)/" \
		-e "/^GNOME_/d" \
		-e "/^CFLAGS/s/\$WARN_CFLAGS/-Wall -Wmissing-prototypes/" \
		configure.ac

	sed -i "/^ACLOCAL_AMFLAGS/,/^$/d" Makefile.am

	local ruby
	for ruby in ${USE_RUBY}; do
		if use ruby_targets_${ruby}; then
			sed -i "1s/ruby/${ruby}/" ${PN}/mkacc.rb
			break
		fi
	done

	default
	eautoreconf
}

src_configure() {
	econf $(use_enable static-libs static)
}

src_install() {
	default
	prune_libtool_files
}
