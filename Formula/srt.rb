class Srt < Formula
  desc "Secure, Reliable, Transport"
  homepage "http://srtalliance.org"
  url "https://github.com/Haivision/srt/archive/v1.2.0.tar.gz"
  sha256 "ca22506cfafa18fb1f9c6dd5ceebe5e56c1b205105b2dd3736701aeea3f4145a"

  head do
    url "https://github.com/Haivision/srt.git"
  end

  depends_on "pkg-config" => :build
  depends_on "cmake" => :build
  depends_on "openssl"

  def install
    openssl = Formula["openssl"].opt_prefix

    system "./configure", "--prefix=#{prefix}",
                          "--with-openssl-includedir=#{openssl}/include",
                          "--with-openssl-libdir=#{openssl}/lib"
    system "make"
    system "make", "install"
  end

  test do
    shell_output("#{bin}/stransmit", 1)
  end
end
