# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

CMAKE_REQUIRED="never"
NO_WAF_LIBDIR="true"
PYTHON_COMPAT=( python2_7 )
PYTHON_REQ_USE="threads(+),xml"
inherit python-single-r1 kde4-base waf-utils

DESCRIPTION="Mindmapping-like tool for document generation"
HOMEPAGE="https://waf.io/semantik.html https://github.com/ita1024/semantik"
SRC_URI="https://waf.io/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="
	${PYTHON_DEPS}
	dev-qt/qtcore:4
	dev-qt/qtgui:4
	dev-qt/qtsvg:4
	dev-qt/qtwebkit:4
"
RDEPEND="${DEPEND}"

DOCS=( ChangeLog README TODO )

PATCHES=( "${FILESDIR}/${PN}-0.9.0-wscript_ldconfig.patch" )

pkg_setup() {
	python-single-r1_pkg_setup
	kde4-base_pkg_setup
}

src_prepare() {
	# no cmake build sys
	default
}
