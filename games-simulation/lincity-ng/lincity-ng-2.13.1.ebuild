# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

#inherit cmake

DESCRIPTION="City simulation game"
HOMEPAGE="https://github.com/lincity-ng/lincity-ng"
SRC_URI="https://github.com/lincity-ng/lincity-ng/archive/lincity-ng-${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${P/_/-}"

LICENSE="GPL-2+ BitstreamVera CC-BY-SA-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	>=dev-libs/libxml2-2.13.0
	>=dev-cpp/libxmlpp-5.0.0
	>=media-libs/sdl2-gfx-1.0
	>=media-libs/sdl2-image-2.0.0[png]
	>=media-libs/sdl2-mixer-2.0.0[vorbis]
	>=media-libs/sdl2-ttf-2.0.12
	>=sys-libs/zlib-1.0.0"

DEPEND="${RDEPEND}"
BDEPEND="
	dev-libs/libxslt
	sys-devel/gettext
	dev-util/include-what-you-use
	virtual/pkgconfig"

src_prepare() {
	default
#	cmake_src_prepare
#	cmake_src_configure
#	cmake_src_build

	cmake -B build -DCMAKE_BUILD_TYPE=RelWithDebInfo

}

src_install() {
#	cmake_src_install
	cmake --build build --parallel
	sudo cmake --install build
}
