#!/bin/bash
#|---/ /+----------------------------------------+---/ /|#
#|--/ /-| Script to install pkgs from input list |--/ /-|#
#|-/ /--| Prasanth Rangan                        |-/ /--|#
#|/ /---+----------------------------------------+/ /---|#

echo "Installing packages..";
cd $(chezmoi source-path);
echo $PWD;

if [ $? -ne 0 ] ; then
    echo "Error: unable to source global_fn.sh, please execute from $(dirname $(realpath $0))..."
    exit 1
fi

install_list="${1:-.install_pkg.lst}"

pkg_installed()
{
    local PkgIn=$1

    if pacman -Qi $PkgIn &> /dev/null
    then
        #echo "${PkgIn} is already installed..."
        return 0
    else
        #echo "${PkgIn} is not installed..."
        return 1
    fi
}

pkg_available()
{
    local PkgIn=$1

    if pacman -Si $PkgIn &> /dev/null
    then
        #echo "${PkgIn} available in arch repo..."
        return 0
    else
        #echo "${PkgIn} not available in arch repo..."
        return 1
    fi
}

aur_available()
{
    local PkgIn=$1

    if pkg_installed yay
    then
        if yay -Si $PkgIn &> /dev/null
        then
            #echo "${PkgIn} available in aur repo..."
            return 0
        else
            #echo "${PkgIn} not available in aur repo..."
            return 1
        fi
    else
        #echo "yay is not installed..."
        return 1
    fi
}

if ! pkg_installed git
    then
    echo "installing dependency git..."
    sudo pacman -S git
fi


while read pkg
do
    if pkg_installed ${pkg}
        then
        echo "skipping ${pkg}..."

    elif pkg_available ${pkg}
        then
        echo "queueing ${pkg} from arch repo..."
        pkg_arch=`echo $pkg_arch ${pkg}`

    elif aur_available ${pkg}
        then
        echo "queueing ${pkg} from aur..."
        pkg_aur=`echo $pkg_aur ${pkg}`

    else
        echo "error: unknown package ${pkg}..."
    fi
done < $install_list


if [ `echo $pkg_arch | wc -w` -gt 0 ]
then
    echo "installing $pkg_arch from arch repo..."
    sudo pacman -S $pkg_arch
fi

if [ `echo $pkg_aur | wc -w` -gt 0 ]
then
    echo "installing $pkg_aur from aur..."
    yay -S $pkg_aur
fi


