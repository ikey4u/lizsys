source $(dirname ${BASH_SOURCE})/../builtin/env.sh

set -e
SCRIPT_DIR=$(cd $(dirname ${BASH_SOURCE}); pwd -P)

function install_tmux() {
    # TODO: check if tmux exists and install if does not exist

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
