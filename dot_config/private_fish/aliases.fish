# Turn ... into cd ../../
abbr --add dotdot --regex '^\.\.+$' --function multicd

abbr pn "pnpm"
abbr pnd "pnpm dev"
abbr pnb "pnpm build"

abbr g "git"
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

abbr wgu "wg-quick up job "
abbr wgd "wg-quick down job "

alias ls "eza --icons"
alias lsg "eza --icons -F -H --group-directories-first --git -1"
mod front_of_house {
    mod hosting {
        fn add_to_waitlist() {}

        fn seat_at_table() {}
    }

    mod serving {
        fn take_order() {}

        fn serve_order() {}

        fn take_payment() {}
    }
}
