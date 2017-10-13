class Vlc < Formula
  desc ""
  homepage ""
  url "http://get.videolan.org/vlc/2.2.6/vlc-2.2.6.tar.xz"
  sha256 "c403d3accd9a400eb2181c958f3e7bc5524fe5738425f4253d42883b425a42a8"

  head do
    url "    https://git.videolan.org/git/vlc.git"
    
    depends_on "autoconf" => :build
    depends_on "automake" => :build

    depends_on "srt" => :optional
  end

  depends_on "libtool" => :build
  depends_on "pkg-config" => :build

  depends_on "a52dec"
  depends_on "faad2"
  depends_on "ffmpeg@2.8"
  depends_on "libdca"
  depends_on "libdvbpsi"
  depends_on "libdvdnav"
  depends_on "libmatroska"
  depends_on "libmpeg2"
  depends_on "libproxy"
  depends_on "libshout"
  depends_on "libtar"
  depends_on "libupnp"
  depends_on "lua"
  depends_on "mad"
  depends_on "opus"
  depends_on "qt"

  depends_on "jack" => :optional
  depends_on "libssh2" => :optional

  def install
    args = %W[
      --prefix=#{prefix}
    ]

    if build.head?
      system "./bootstrap"

      # Only master has srt modules
      args << "--enable-srt" if build.with? "srt"
    end

    args << "--enable-sftp" if build.with? "libssh2"

    system "./configure", *args

    system "make"
    system "make", "install"
  end

  test do
    shell_output("#{bin}/vlc --help", 1)
  end
end
