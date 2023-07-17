source $(dirname ${BASH_SOURCE})/../builtin/env.sh
SCRIPT_DIR=$(cd $(dirname ${BASH_SOURCE}); pwd -P)

function rust_install() {
    if [[ ! -x $(command -v cargo) ]]; then
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    fi
    local shconf=${LIZSYS_SHELL_CONF}

    # cargo
    if ! grep -q LIZSYS_RUST_MARK ${shconf}; then
        cat >> ${shconf} <<EOF
# LIZSYS_RUST_MARK
export PATH=\$HOME/.cargo/bin:\$PATH
EOF
    fi

    # starship
    if ! grep -q LIZSYS_STARSHIP_MARK ${shconf}; then
        ${HOME}/.cargo/bin/cargo install starship
        cat >> ${shconf} <<EOF
# LIZSYS_STARSHIP_MARK
eval "\$(starship init ${LIZSYS_SHELL_NAME})"
EOF
    fi
    mkdir -p ${HOME}/.config
    rm -rf ${HOME}/.config/starship.toml
    ln -s ${SCRIPT_DIR}/starship.toml ${HOME}/.config/starship.toml

    # vivid
    if ! grep -q LIZSYS_VIVID_MARK ${shconf}; then
        ${HOME}/.cargo/bin/cargo install vivid
        cat >> ${shconf} <<EOF
# LIZSYS_VIVID_MARK
export LS_COLORS="\$(vivid generate dracula)"
export CLICOLOR=1
EOF
    fi

    # gitui
    if ! grep -q LIZSYS_GITUI_MARK ${shconf}; then
        ${HOME}/.cargo/bin/cargo install gitui
        cat >> ${shconf} <<EOF
# LIZSYS_GITUI_MARK
EOF
    fi
    mkdir -p $HOME/.config/gitui
    rm -rf $HOME/.config/gitui/key_bindings.ron
    ln -s ${SCRIPT_DIR}/key_bindings.ron $HOME/.config/gitui/key_bindings.ron

    # zoxide
    if ! grep -q LIZSYS_ZOXIDE_MARK ${shconf}; then
        ${HOME}/.cargo/bin/cargo install zoxide --locked
        cat >> ${shconf} <<EOF
# LIZSYS_ZOXIDE_MARK
eval "\$(zoxide init ${LIZSYS_SHELL_NAME} --cmd cd)"
EOF
    fi
}

rust_install
