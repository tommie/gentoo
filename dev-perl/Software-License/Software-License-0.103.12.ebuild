# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
EAPI=6
DIST_AUTHOR=RJBS
DIST_VERSION=0.103012
inherit perl-module

DESCRIPTION="packages that provide templated software licenses"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

# r: IO::Dir -> IO
# r: strict, warnings -> perl
RDEPEND="
	virtual/perl-Carp
	dev-perl/Data-Section
	virtual/perl-File-Spec
	virtual/perl-IO
	virtual/perl-Module-Load
	dev-perl/Text-Template
	virtual/perl-parent
"
DEPEND="
	>=virtual/perl-ExtUtils-MakeMaker-6.300.0
	test? (
		>=virtual/perl-Test-Simple-0.960.0
		dev-perl/Try-Tiny
	)
"
