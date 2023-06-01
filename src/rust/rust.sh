source $(dirname ${BASH_SOURCE})/../builtin/env.sh
SCRIPT_DIR=$(cd $(dirname ${BASH_SOURCE}); pwd -P)

function rust_install() {
    if [[ ! -x $(command -v cargo) ]]; then
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    fi

    local shconf=
    case "$(basename $SHELL)" in
        bash)
            shconf=${HOME}/.bashrc
            ;;
        zsh)
            shconf=${HOME}/.zshrc
            ;;
        *)
            echo "[x] unsupported shell $SHELL"
            return 1
        ;;
    esac
    # cargo
    if ! grep -q LIZSYS_RUST_MARK ${shconf}; then
        cat >> ${shconf} <<EOF
# LIZSYS_RUST_MARK
export PATH=\$HOME/.cargo/bin:\$PATH
EOF
    fi

    # starship
    ${HOME}/.cargo/bin/cargo install starship
    if ! grep -q LIZSYS_STARSHIP_MARK ${shconf}; then
        cat >> ${shconf} <<EOF
# LIZSYS_STARSHIP_MARK
eval "\$(starship init bash)"
EOF
    fi
    mkdir -p ${HOME}/.config
    rm -rf ${HOME}/.config/starship.toml
    ln -s ${SCRIPT_DIR}/starship.toml ${HOME}/.config/starship.toml

    # vivid
    ${HOME}/.cargo/bin/cargo install vivid
    if ! grep -q LIZSYS_VIVID_MARK ${shconf}; then
        cat >> ${shconf} <<EOF
# LIZSYS_VIVID_MARK
export LS_COLORS="\$(vivid generate dracula)"
export CLICOLOR=1
EOF
    fi

    # gitui
    ${HOME}/.cargo/bin/cargo install gitui
    mkdir -p $HOME/.config/gitui
    rm -rf $HOME/.config/gitui/key_bindings.ron
    ln -s ${SCRIPT_DIR}/key_bindings.ron $HOME/.config/gitui/key_bindings.ron
}

rust_install
