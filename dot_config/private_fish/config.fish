# Autostart Hyprland at login
if status --is-interactive
  if test -z "$DISPLAY" -a $XDG_VTNR = 1
	echo "Fish: Autostarting Hyprland from fish config.."
    exec Hyprland
  end
end


# VS Code shell integration - see https://code.visualstudio.com/docs/terminal/shell-integration
string match -q "$TERM_PROGRAM" "vscode"
and . (code --locate-shell-integration-path fish)


# Rust
source "$HOME/.cargo/env.fish"

# pnpm
set -gx PNPM_HOME "$HOME/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end


set -gx EDITOR nvim
set -gx SUDO_EDITOR nvim
set -gx VISUAL nvim
# set -gx MANPAGER most
set -Ux MANPAGER "nvim +Man!"
# set -Ux MANWIDTH "999"
set -Ux fifc_editor nvim
set -gx TERM kitty
set -Ux TERM kitty

source ~/.config/fish/functions.fish
source ~/.config/fish/themes/gruvbox_material.fish


# Commands to run in interactive sessions can go here
if status is-interactive
	source ~/.config/fish/aliases.fish
    fish_vi_key_bindings
	atuin init fish | source
	starship init fish | source # prompt
    zoxide init fish --cmd cd | source # folder auto jumping


end

function fish_greeting
  # kitty icat --align left "/home/vdawg/.local/share/chezmoi/.other/assets/see_you.png"  2> /dev/null
end


# Created by `pipx` on 2024-10-05 22:27:21
set PATH $PATH /home/vdawg/.local/bin
