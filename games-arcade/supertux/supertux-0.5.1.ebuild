# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit cmake-utils flag-o-matic

MY_P="SuperTux-v${PV}-Source"

DESCRIPTION="A game similar to Super Mario Bros."
HOMEPAGE="http://supertuxproject.org/"
SRC_URI="https://github.com/SuperTux/${PN}/releases/download/v${PV}/${MY_P}.tar.gz"

LICENSE="GPL-2+ GPL-3+ ZLIB MIT CC-BY-SA-2.0 CC-BY-SA-3.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

RDEPEND="dev-games/physfs
	dev-libs/boost:=
	media-libs/glew:=
	virtual/opengl
	media-libs/libvorbis
	media-libs/openal
	>=media-libs/libsdl2-2.0.1[joystick,video]
	>=media-libs/sdl2-image-2.0.0[png,jpeg]
	>=net-misc/curl-7.21.7"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

S="${WORKDIR}/${MY_P}"

PATCHES=(
	"${FILESDIR}"/${PN}-0.4.0-{desktop,license,icon}.patch
	"${FILESDIR}"/${PN}-0.5.0-{obstack,tinygettext}.patch
)

src_prepare() {
	default

	# This is not a developer release so switch the logo to the non-dev one.
	sed 's@logo_dev@logo@' \
		-i data/images/objects/logo/logo.sprite || die
}

src_configure() {
	append-cxxflags -std=c++11
	local mycmakeargs=(
		-DWERROR=OFF
		-DINSTALL_SUBDIR_BIN=bin
		-DINSTALL_SUBDIR_DOC=share/doc/${PF}
		-DINSTALL_SUBDIR_SHARE=share/${PN}2
		-DENABLE_SQDBG="$(usex debug)"
		-DUSE_DEBUG="$(usex debug)"
		-DENABLE_BOOST_STATIC_LIBS=OFF # bug! Please check if this is still required.
	)

	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
}

src_install() {
	cmake-utils_src_install
}
