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
        appimage.qqmusic|appimage.keepassxc)
            bash ${LIZSYS_HOME}/src/appimage/appimage.sh $1
            ;;
    esac
}

main $*
