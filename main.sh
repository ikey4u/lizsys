set -e

source $(dirname ${BASH_SOURCE})/src/builtin/env.sh

function main() {
    case "$1" in
        python)
            bash ${LIZSYS_HOME}/src/python/python.sh
            ;;
        rust)
            bash ${LIZSYS_HOME}/src/rust/rust.sh
            ;;
        neovim)
            bash ${LIZSYS_HOME}/src/neovim/neovim.sh
            ;;
        tmux)
            bash ${LIZSYS_HOME}/src/tmux/tmux.sh
            ;;
        rime)
            bash ${LIZSYS_HOME}/src/rime/rime.sh
            ;;
        llvm)
            bash ${LIZSYS_HOME}/src/llvm/llvm.sh
            ;;
        appimage.qqmusic|appimage.keepassxc|appimage.wezterm|appimage.koodoreader)
            bash ${LIZSYS_HOME}/src/appimage/appimage.sh $1
            ;;
    esac
}

if [[ "${LIZSYS_OS}" == Darwin ]]; then
    if [[ ! -x $(command -v brew) ]]; then
        echo "macOS requires brew, install it now ..."
        bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ${LIZSYS_SHELL_CONF}
        source ${LIZSYS_SHELL_CONF}
    fi

    if [[ ! -x $(command -v cmake) ]]; then
        brew install cmake
    fi
fi
main $*
