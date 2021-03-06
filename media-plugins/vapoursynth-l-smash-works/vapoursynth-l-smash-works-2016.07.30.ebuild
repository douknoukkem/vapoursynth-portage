# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit toolchain-funcs multilib git-r3

DESCRIPTION="Works based on L-SMASH project"
HOMEPAGE="https://github.com/VFR-maniac/L-SMASH-Works"

EGIT_REPO_URI="https://github.com/VFR-maniac/L-SMASH-Works.git"
EGIT_COMMIT="dfea5072734e9b9022c53412229be0a0675f45f4"

LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"
IUSE="-debug"
SLOT="0"

RDEPEND+="
	media-video/ffmpeg
	media-libs/l-smash
"
DEPEND="${RDEPEND}
	virtual/pkgconfig
"

S="${WORKDIR}/${P}/VapourSynth"

src_prepare() {
	eapply_user
	chmod +x configure
	sed -i -e "s:CC=\"gcc\":CC=\"$(tc-getCC)\":" configure || die
	sed -i -e "s:LD=\"gcc\":LD=\"$(tc-getCC)\":" configure || die
}

src_configure() {
	./configure --prefix="${ROOT}/usr" --extra-cflags="${CFLAGS}" --extra-ldflags="${LDFLAGS}" || die
}
