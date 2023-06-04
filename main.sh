source $(dirname ${BASH_SOURCE})/src/builtin/env.sh

function main() {
    bash ${LIZSYS_HOME}/src/python/python.sh
    bash ${LIZSYS_HOME}/src/neovim/neovim.sh
    bash ${LIZSYS_HOME}/src/rust/rust.sh
    bash ${LIZSYS_HOME}/src/tmux/tmux.sh
    bash ${LIZSYS_HOME}/src/llvm/llvm.sh
    bash ${LIZSYS_HOME}/src/rime/rime.sh
    bash ${LIZSYS_HOME}/src/appimage/appimage.sh
}

main
