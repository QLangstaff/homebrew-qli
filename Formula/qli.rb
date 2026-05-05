class Qli < Formula
  desc "Polyglot code-analysis CLI and any-language extension framework."
  homepage "https://github.com/QLangstaff/qli"
  version "0.1.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/QLangstaff/qli/releases/download/v0.1.1/qli-aarch64-apple-darwin.tar.xz"
      sha256 "2b18b8d2ced3d8dc706a528fd2729359be10a5f8f4c62f6679168185f1ea30ed"
    end
    if Hardware::CPU.intel?
      url "https://github.com/QLangstaff/qli/releases/download/v0.1.1/qli-x86_64-apple-darwin.tar.xz"
      sha256 "d85c20342b604998fe75aa1d4715e1d8141ee14f304f9f9342522f929c96bf0a"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/QLangstaff/qli/releases/download/v0.1.1/qli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "ff14c39c8d73ae5d464c6439819e0a61e7f2d5fafdb54505a66bdc8fcbde62cb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/QLangstaff/qli/releases/download/v0.1.1/qli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "2af87be4978bd58d4f1fdc317c88e905fafe7f2b9ab26d9bc9f6bf3088b6ef84"
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
