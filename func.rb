require 'fileutils'

class Func < Formula
  v = "v1.10.0"
  plugin_name = "func"
  path_name = "#{plugin_name}"
  file_name = "#{plugin_name}"
  base_url = "https://github.com/knative/#{path_name}/releases/download/knative-#{v}"

  homepage "https://github.com/knative/#{path_name}"

  version v

  if OS.mac?
    if `uname -m`.chomp  == "arm64"
      url "#{base_url}/#{file_name}_darwin_arm64"
      sha256 "740bef3723a30861149e86ea0505e32be74112bafa892a8d0a86d2526c41cf71"
    else
      url "#{base_url}/#{file_name}_darwin_amd64"
      sha256 "de953a9167f28af5c1f0acfe67e2c851e999aa1f6efed5a326083ba569cc2381"
    end
  end

  if OS.linux?
    if `uname -m`.chomp  == "arm64"
      url "#{base_url}/#{file_name}_linux_arm64"
      sha256 "9004e811ad5cfe042e4e2009735447c9e1a60ea8b1a3c2c824dbf117eead7c22"
    else
      url "#{base_url}/#{file_name}_linux_amd64"
      sha256 "5069e5fb8d1b3742c4df8e8bbbeb7737f3bf7aab175bd8e76a900b86bc28239a"
    end
  end

  def install
    if OS.mac?
      if `uname -m`.chomp == "arm64"
        FileUtils.mv("func_darwin_arm64", "kn-func")
      else
        FileUtils.mv("func_darwin_amd64", "kn-func")
      end
    end
    if OS.linux?
      if `uname -m`.chomp == "arm64"
        FileUtils.mv("func_linux_arm64", "kn-func")
      else
        FileUtils.mv("func_linux_amd64", "kn-func")
      end
    end
    p "Installing kn-func binary in " + bin
    bin.install "kn-func"
    p "Installing func symlink in " + bin
    ln_s "kn-func", bin/"func"
  end

  test do
    system "#{bin}/kn-func", "version"
  end
end

