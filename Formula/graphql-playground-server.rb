require "language/node"

class GraphqlPlaygroundServer < Formula
    desc "Standalone GraphQL Playground server"
    homepage "https://github.com/Batterii/graphql-playground-server"
    url "https://registry.npmjs.org/graphql-playground-server/-/graphql-playground-server-0.1.6.tgz"
    version "0.1.6"
    sha256 "b6b51645612153908a9d8e890331698a74e7b68254481aa7240aab0ffe1ec989"

    depends_on "node"

    def install
        system "npm", "install", *Language::Node.std_npm_install_args(libexec)
        bin.install_symlink Dir["#{libexec}/bin/*"]
    end

    def plist
        <<~EOS
          <?xml version="1.0" encoding="UTF-8"?>
          <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
          <plist version="1.0">
            <dict>
              <key>Label</key>
              <string>#{plist_name}</string>
              <key>KeepAlive</key>
              <true/>
              <key>ProgramArguments</key>
              <array>
                <string>#{HOMEBREW_PREFIX}/bin/node</string>
                <string>#{opt_bin}/graphql-playground-server</string>
                <string>-c</string>
                <string>#{etc}/graphql-playground-server.conf.yaml</string>
              </array>
              <key>StandardErrorPath</key>
              <string>#{var}/log/graphql-playground-server.log</string>
              <key>StandardOutPath</key>
              <string>#{var}/log/graphql-playground-server.log</string>
            </dict>
          </plist>
        EOS
    end

    test do
        system bin/"graphql-playground-server", "-V"
    end
end
