class Qli < Formula
  desc "Polyglot code-analysis CLI and any-language extension framework."
  homepage "https://github.com/QLangstaff/qli"
  version "0.1.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/QLangstaff/qli/releases/download/v0.1.2/qli-aarch64-apple-darwin.tar.xz"
      sha256 "19a554b45252c9570689bd014f27ec96d9e937baf5d4841050e2b18627caad9c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/QLangstaff/qli/releases/download/v0.1.2/qli-x86_64-apple-darwin.tar.xz"
      sha256 "39010adfb188d2b86fc24caebc4e08d1348962f7080843d1cca7675d20aab2ff"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/QLangstaff/qli/releases/download/v0.1.2/qli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "56b74ea89ee65f196e41d4c71f5ed2afa5ffdff42f83765a3885a97cf784b8e9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/QLangstaff/qli/releases/download/v0.1.2/qli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "8a01c182956ab25524d7a9ab136e8eae70e5db29d96a02240963f460a220ac47"
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
    bin.install "qli" if OS.mac? && Hardware::CPU.arm?
    bin.install "qli" if OS.mac? && Hardware::CPU.intel?
    bin.install "qli" if OS.linux? && Hardware::CPU.arm?
    bin.install "qli" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
