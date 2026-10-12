class Qli < Formula
  desc "Polyglot code-analysis CLI and any-language extension framework."
  homepage "https://github.com/QLangstaff/qli"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/QLangstaff/qli/releases/download/v0.3.0/qli-aarch64-apple-darwin.tar.xz"
      sha256 "0663d24440d551e8c39ccfe4efc8456a7c121c1b9e17ed41991a640fe87e1913"
    end
    if Hardware::CPU.intel?
      url "https://github.com/QLangstaff/qli/releases/download/v0.3.0/qli-x86_64-apple-darwin.tar.xz"
      sha256 "02c76f19d4ea3cd4280edf2f6a70f1078a75f3841707d1e1a1b10acb5f3a6f3c"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/QLangstaff/qli/releases/download/v0.3.0/qli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "a8bf5739c73e37d1612959a95b3c7b17825afc282eb3ef62b66a31a5f2553c2b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/QLangstaff/qli/releases/download/v0.3.0/qli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "3d11dcc549348bcbb793589cdf4d51987f1dd3f1c503e602643901fe5f747215"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "qli"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "qli"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "qli"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "qli"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
