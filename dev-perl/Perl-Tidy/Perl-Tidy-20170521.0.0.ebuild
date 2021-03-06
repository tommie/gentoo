# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DIST_AUTHOR=SHANCOCK
DIST_VERSION=20170521
DIST_EXAMPLES=( "examples/*" )
inherit perl-module

DESCRIPTION="Perl script indenter and beautifier"
HOMEPAGE="http://perltidy.sourceforge.net/ ${HOMEPAGE}"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
	virtual/perl-ExtUtils-MakeMaker
"

src_install() {
	perl-module_src_install

	# Compressing pod is bad because perldoc can't decompress
	# bzip2 automatically, and `less` can't render perldoc
	docompress -x /usr/share/doc/${PF}/stylekey.pod
	docompress -x /usr/share/doc/${PF}/tutorial

	docinto ''
	dodoc docs/stylekey.pod

	docinto tutorial
	dodoc docs/tutorial.pod docs/testfile.pl
}
