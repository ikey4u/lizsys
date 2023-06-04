export SCRIPT_DIR=$(cd $(dirname ${BASH_SOURCE}); pwd -P)
source ${SCRIPT_DIR}/../builtin/env.sh

function rime_install() {
    if [[ -x $(command -v apt-get) ]]; then
        if [[ ! -x $(command -v fcitx5-configtool) ]];  then
            sudo apt-get install fcitx5 fcitx5-chinese-addons \
            fcitx5-frontend-qt5 fcitx5-module-xorg \
            kde-config-fcitx5 im-config \
            fcitx5-rime
            echo "[rime] logout and login back, then run fcitx5-configtool to configure fcitx5-rime"
        fi
    fi

    mkdir -p ~/.config/fcitx5/conf
    rm -f ~/.config/fcitx5/conf/classicui.conf
    ln -s ${SCRIPT_DIR}/fcitx5/classicui.conf ~/.config/fcitx5/conf/classicui.conf

    mkdir -p ~/.local/share/fcitx5
    rm -rf ~/.local/share/fcitx5/themes
    ln -s ${SCRIPT_DIR}/fcitx5/themes ~/.local/share/fcitx5/themes

    fcitx5_rime_confdir=~/.local/share/fcitx5/rime
    if [[ -e "${fcitx5_rime_confdir}" ]]; then
        rm -rf ${fcitx5_rime_confdir}
    fi
    mkdir -p ${fcitx5_rime_confdir}

    dstdir=${fcitx5_rime_confdir}
    for yaml in ${SCRIPT_DIR}/*.yaml
    do
        yaml=$(basename $yaml)
        if [[ -L $dstdir/$yaml || -e $dstdir/$yaml ]]; then
            rm $dstdir/$yaml
        fi
        ln -s ${SCRIPT_DIR}/$yaml $dstdir/$yaml
    done
}
rime_install
