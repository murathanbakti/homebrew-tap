cask "nubrix" do
  version "0.5.0"
  sha256 "f5fa0e8e0c4b33fb63a5cd5454e59291e819ec632901da5418ef942b5e227ac0"

  url "https://github.com/murathanbakti/nubrix/releases/download/v#{version}/Nubrix-#{version}.zip"
  name "Nubrix"
  desc "Notch bar for developers with Claude Code session status"
  homepage "https://github.com/murathanbakti/nubrix"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sonoma

  app "Nubrix.app"

  uninstall quit: "dev.nubrix.app"

  zap trash: [
    "~/.config/nubrix",
    "~/.config/nubrix-run",
    "~/Library/Application Scripts/dev.nubrix.app",
    "~/Library/Containers/dev.nubrix.app",
  ]

  caveats <<~EOS
    Optional Claude Code hooks (session status in the notch):
      bash "#{appdir}/Nubrix.app/Contents/Resources/nubrix-hooks/scripts/install-hooks.sh"
    The script prints a snippet to add to ~/.claude/settings.json and never edits that file.
    Run it again after every upgrade to refresh the installed copies.

    Nubrix also updates itself by default; turn that off in Settings, About, Updates.
    brew upgrade --cask nubrix keeps working either way.

    Before "brew uninstall --zap nubrix", remove the Nubrix entries from
    ~/.claude/settings.json, otherwise Claude Code keeps calling hook scripts that no longer exist.
  EOS
end
