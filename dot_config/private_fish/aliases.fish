# Turn ... into cd ../../
abbr --add dotdot --regex '^\.\.+$' --function multicd

abbr pn "pnpm"
abbr pnd "pnpm dev"
abbr pnb "pnpm build"
abbr pni "pnpm install"

abbr xclip "xclip -selection c"
abbr cz "chezmoi"
abbr j "joshuto"
abbr pac "sudo pacman -S "
abbr pacr "sudo pacman -R "
abbr yays "yay -Syu "
abbr icat "kitty +kitten icat"
abbr c. "code ."
abbr n. "nvim ."
abbr h. "nvim ~/.config/hypr"

abbr mvd "mullvad disconnect"
abbr mvc "mullvad connect"
abbr mvs "mullvad status"

abbr lsgr "ls | rg "


abbr wgu "wg-quick up job "
abbr wgd "wg-quick down job "

abbr g "git"
abbr gitc "git-clone-and-cd"
abbr gitf "git add -A && git commit -m 'commit save point' && git push"
abbr gitp "git pull"
