export SCRIPT_DIR=$(cd $(dirname ${BASH_SOURCE}); pwd -P)
source ${SCRIPT_DIR}/../builtin/env.sh

function neovim_install() {
    local appdir=${LIZSYS_APP_DIR}/neovim
    local version=v0.9.1
    mkdir -p ${appdir}
    local dlurl=""
    if [[ ${LIZSYS_OS} = "Darwin" ]]; then
        dlurl=https://github.com/neovim/neovim/releases/download/${version}/nvim-macos.tar.gz
    elif [[ ${LIZSYS_OS} = "Linux" ]]; then
        dlurl=https://github.com/neovim/neovim/releases/download/${version}/nvim-linux64.tar.gz
    else
        echo "[x] OS ${LIZSYS_OS} is not supported"
        return 1
    fi

    if [[ ! -d ${appdir}/${version} ]] ; then
        if ! curl -sS -L ${dlurl} -o ${appdir}/app.tar.gz; then
            echo "[x] failed to download from ${dlurl}"
            return 1
        fi
    fi
    mkdir -p ${appdir}/${version}
    tar zxvf ${appdir}/app.tar.gz -C ${appdir}/${version} --strip-components=1 &> /dev/null
    rm -rf ${appdir}/app.tar.gz
    ln -sfn ${appdir}/${version} ${appdir}/current
    if ! grep "LIZSYS_NEOVIM_MARK" -q ${LIZSYS_SHELL_CONF}; then
        cat >> ${LIZSYS_SHELL_CONF} <<EOF
# LIZSYS_NEOVIM_MARK
export PATH=\${PATH}:${LIZSYS_APP_DIR}/neovim/current/bin
# open with servername (neovim-remote)
alias xvim="nvim --listen /tmp/nvim "
# split open
alias xvims="nvr --servername /tmp/nvim -o "
# vertical split open
alias xvimvs="nvr --servername /tmp/nvim -O "
# tab open
alias xvimt="nvr --servername /tmp/nvim --remote-tab "
EOF
    fi
    if [[ -L "${HOME}/.config/nvim" ]]; then
        rm -rf ${HOME}/.config/nvim
    fi
    ln -sf ${SCRIPT_DIR}/nvim ${HOME}/.config/nvim

    if [[ -d "${HOME}/.pyenv" ]] && [[ -e "${HOME}/.pyenv/shims/python3" ]]; then
        ${HOME}/.pyenv/shims/python3 -m pip install pynvim neovim neovim-remote
    else
        echo "[!] please install pyenv then python3"
    fi
}

neovim_install
