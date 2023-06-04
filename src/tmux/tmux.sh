source $(dirname ${BASH_SOURCE})/../builtin/env.sh

set -e
SCRIPT_DIR=$(cd $(dirname ${BASH_SOURCE}); pwd -P)

function install_tmux() {
    local appdir=${LIZSYS_APP_DIR}/tmux
    local tmpdir=${appdir}/tmp
    mkdir -p ${tmpdir} && cd ${appdir}

    # TODO: check if tmux exists and install if does not exist
    if [[ ! -x "$(command -v tmux)" ]]; then
        if [[ ! -d tmp ]]; then
            git clone https://github.com/tmux/tmux.git ${tmpdir}
        fi
        if [[ -x $(command -v apt-get) ]]; then
            sudo apt-get install -y automake libevent-dev ncurses-dev build-essential bison pkg-config
        fi
        if [[ -x $(command -v yum) ]]; then
            sudo yum install -y automake libevent-devel ncurses-devel gcc make bison pkg-config 
        fi
        cd ${tmpdir}
        git checkout tags/3.3a
        bash autogen.sh
        ./configure --prefix=${appdir}/3.3a
        make -j8
        make install
    fi
    if ! grep -q LIZSYS_TMUX_MARK ${LIZSYS_SHELL_CONF}; then
        cat >> ${LIZSYS_SHELL_CONF} <<EOF
# LIZSYS_TMUX_MARK
export PATH=\${PATH}:${appdir}/3.3a/bin
EOF
    fi

    local confpath=${HOME}/.tmux.conf
    if [[ -L "${confpath}" ]]; then
        rm -rf ${confpath}
    fi
    if [[ -e "${confpath}" ]]; then
        echo "[x] found existed tmux configuration: ${confpath}"
        return 1
    fi
    ln -s ${SCRIPT_DIR}/tmux.conf ${confpath}

    if [[ ! -d "${HOME}/.tmux/plugins/tpm" ]]; then
        mkdir -p ${HOME}/.tmux/plugins
        git clone https://github.com/tmux-plugins/tpm ${HOME}/.tmux/plugins/tpm
    fi
    if [[ "$(uname)" == Linux ]]; then
        if [[ ! -x "$(command -v xsel)" ]]; then
            command -v yum && sudo yum install xsel
            command -v apt && sudo apt install xsel
        fi
    fi
}

install_tmux
