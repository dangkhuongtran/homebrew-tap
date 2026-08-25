class CloudProviderKindAT010 < Formula
  desc "Cloud provider for KIND clusters"
  homepage "https://kubernetes-sigs.github.io/cloud-provider-kind/"
  url "https://github.com/kubernetes-sigs/cloud-provider-kind/archive/refs/tags/v0.10.0.tar.gz"
  sha256 "447ce982e8103934c92a466438cad961a7ca3f817534c3b53c80b12929679b95"
  license "Apache-2.0"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args
  end

  test do
    # Test that the binary runs (help command)
    output = shell_output("#{bin}/cloud-provider-kind --help")
    assert_equal 0, $CHILD_STATUS.exitstatus
  end
end
