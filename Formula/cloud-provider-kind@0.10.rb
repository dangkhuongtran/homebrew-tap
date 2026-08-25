class CloudProviderKindAT010 < Formula
  desc "Cloud provider for KIND clusters"
  homepage "https://kubernetes-sigs.github.io/cloud-provider-kind/"
  url "https://github.com/kubernetes-sigs/cloud-provider-kind/archive/refs/tags/v0.10.0.tar.gz"
  sha256 "db9829197b1940d5cce0a39c352d9d15adb58877b82431cf2fdc0e7f874253ba"
  license "Apache-2.0"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args

    generate_completions_from_executable(
      bin/"cloud-provider-kind",
      shell_parameter_format: :cobra,
    )
  end

  test do
    ENV["DOCKER_HOST"] = "unix://#{testpath}/invalid.sock"
    status_output = shell_output("#{bin}/cloud-provider-kind 2>&1", 1)

    if OS.mac?
      assert_match "Error: please run this again with `sudo`", status_output
    elsif OS.linux?
      assert_match "no supported container runtime found", status_output
    end
  end
end
