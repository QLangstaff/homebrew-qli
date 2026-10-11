class Qli < Formula
  desc "Polyglot code-analysis CLI and any-language extension framework."
  homepage "https://github.com/QLangstaff/qli"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/QLangstaff/qli/releases/download/v0.2.0/qli-aarch64-apple-darwin.tar.xz"
      sha256 "a0ccc8936680a346f808a9355e2a8ac130f8e96923837a336de8141e2d0d6dc7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/QLangstaff/qli/releases/download/v0.2.0/qli-x86_64-apple-darwin.tar.xz"
      sha256 "9aa434c2128d581fd5d87f17eb3254a8d80740e1ad52f4cce00dc4438ff94bdf"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/QLangstaff/qli/releases/download/v0.2.0/qli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "7855fed53ab2eeab47d45fe5872a99ddf62d3e9ff8c837befb1b74179de19939"
    end
    if Hardware::CPU.intel?
      url "https://github.com/QLangstaff/qli/releases/download/v0.2.0/qli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "60724b61b79bd1db3feca9e15e3b0a4ec2eaeac195f920d514caf78faec6a543"
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
