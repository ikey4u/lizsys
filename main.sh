source $(dirname ${BASH_SOURCE})/src/builtin/env.sh

function main() {
    bash ${LIZSYS_HOME}/src/neovim/neovim.sh
    bash ${LIZSYS_HOME}/src/python/python.sh
    bash ${LIZSYS_HOME}/src/rust/rust.sh
    bash ${LIZSYS_HOME}/src/tmux/tmux.sh
}

main