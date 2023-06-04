export SCRIPT_DIR=$(cd $(dirname ${BASH_SOURCE}); pwd -P)
source ${SCRIPT_DIR}/../builtin/env.sh

DESKTOP_ENTRY_DIR=${HOME}/.local/share/applications && mkdir -p ${DESKTOP_ENTRY_DIR}
function appimage_install_keepassxc() {
    local appdir=${LIZSYS_APP_DIR}/keepasssxc
    mkdir -p ${appdir} && cd ${appdir}
    local pkgname=KeePassXC-2.7.5-x86_64.AppImage
    if [[ ! -e "${pkgname}" ]]; then
        curl -LO https://github.com/keepassxreboot/keepassxc/releases/download/2.7.5/${pkgname}
    fi
    chmod +x ${pkgname}
    cat > ${DESKTOP_ENTRY_DIR}/keepassxc.desktop <<EOF
#!/usr/bin/env xdg-open
[Desktop Entry]
Name=KeePassXC
Path=${appdir}
Exec=${appdir}/${pkgname}
Terminal=false
Type=Application
Categories=Utility;
Keywords=keepassxc;keepass;
EOF
}

function appimage_install_qqmusic() {
    local appdir=${LIZSYS_APP_DIR}/qqmusic
    mkdir -p ${appdir} && cd ${appdir}
    local pkgname=qqmusic-1.1.5.AppImage
    if [[ ! -e "${pkgname}" ]]; then
        curl -LO https://dldir1.qq.com/music/clntupate/linux/AppImage/${pkgname}
    fi
    chmod +x ${pkgname}
    cat > ${DESKTOP_ENTRY_DIR}/qqmusic.desktop <<EOF
#!/usr/bin/env xdg-open
[Desktop Entry]
Name=QQ Music
Path=${appdir}
Exec=${appdir}/${pkgname}
Terminal=false
Type=Application
Categories=Utility;
Keywords=music;qq;qqmusic;
EOF
}

if [[ -x $(command -v apt-get) ]]; then
    sudo apt-get install desktop-file-utils
fi
appimage_install_keepassxc
appimage_install_qqmusic
update-desktop-database ${DESKTOP_ENTRY_DIR}
