# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="5"

JAVA_PKG_IUSE="doc examples source test"

inherit eutils java-pkg-2 java-ant-2

MY_P="${P}-src"

DESCRIPTION="Reads XML configuration files to provide initialization of various Java objects"
HOMEPAGE="http://commons.apache.org/digester/"
SRC_URI="mirror://apache/commons/digester/source/${MY_P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="2.1"
KEYWORDS="amd64 ppc64 x86 ~x86-fbsd"

CDEPEND="dev-java/commons-beanutils:1.7
	>=dev-java/commons-collections-2.1:0
	>=dev-java/commons-logging-1.0.2:0"

RDEPEND=">=virtual/jre-1.6
	${CDEPEND}"

DEPEND=">=virtual/jdk-1.6
	${CDEPEND}
	test? (
		dev-java/junit:0
		dev-java/ant-junit:0
	)"

S="${WORKDIR}/${P}-src"

JAVA_ANT_REWRITE_CLASSPATH="true"
EANT_GENTOO_CLASSPATH="commons-beanutils-1.7,commons-collections,commons-logging"

java_prepare() {
	cp "${FILESDIR}"/${P}-build.xml build.xml || die
}

EANT_TEST_GENTOO_CLASSPATH="${EANT_GENTOO_CLASSPATH},junit"

src_test() {
	java-pkg-2_src_test
}

src_install() {
	java-pkg_newjar target/${PN}.jar

	dodoc RELEASE-NOTES.txt

	use doc && java-pkg_dojavadoc target/site/apidocs
	use source && java-pkg_dosrc src/main/java/org
	use examples && java-pkg_doexamples src/examples
}
