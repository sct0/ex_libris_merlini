# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools out-of-source

DESCRIPTION="Universal Non-Uniform Random number generator"
HOMEPAGE="https://statmath.wu.ac.at/unuran/"
SRC_URI="https://statmath.wu.ac.at/unuran/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="doc examples gsl prng +rngstreams"

DEPEND="
	gsl? ( sci-libs/gsl:= )
	prng? ( sci-mathematics/prng )
	rngstreams? ( sci-mathematics/rngstreams:= )"
RDEPEND="${DEPEND}"

#PATCHES=(
#	"${FILESDIR}"/${PN}-1.9.0-configure-clang16.patch
#)

src_prepare() {
	default

	# Clang 16
	eautoreconf
}

my_src_configure() {
	local udefault=builtin
	use rngstreams && udefault=rngstream

	CONFIG_SHELL="${BROOT}"/bin/bash econf \
		--enable-shared \
		--disable-static \
		--with-urng-default="${udefault}" \
		$(use_with gsl urng-gsl) \
		$(use_with prng urng-prng) \
		$(use_with rngstreams urng-rngstream)
}

my_src_install_all() {
	use doc && dodoc doc/${PN}.pdf
	einstalldocs

	if use examples; then
		rm examples/Makefile* || die
		dodoc -r examples
		docompress -x /usr/share/doc/${PF}/examples
	fi

	# no static archives
	find "${D}" -name '*.la' -delete || die
}
