function python_install() {
    if [[ ! -d "${HOME}/.pyenv" ]]; then
        git clone https://github.com/pyenv/pyenv.git ~/.pyenv
        if ! grep -q LIZSYS_PYENV_MARK ${HOME}/.bashrc; then
            cat >> ${HOME}/.bashrc <<EOF
# LIZSYS_PYENV_MARK
export PYENV_ROOT="\$HOME/.pyenv"
export PATH="\$PYENV_ROOT/bin:\$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
    eval "\$(pyenv init --path)"
fi
EOF
        fi
    fi

    local deps_done=NO
    if [[ -x $(command -v yum) ]]; then
        sudo yum install -y gcc gcc-c++ make git patch openssl-devel zlib-devel readline-devel sqlite-devel bzip2-devel zlib libffi-devel xz-devel
        deps_done=YES
    fi
    if [[ -x $(command -v apt-get) ]]; then
        sudo apt-get install -y make build-essential libssl-dev zlib1g-dev libbz2-dev \
        libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev \
        xz-utils tk-dev libffi-dev liblzma-dev
        deps_done=YES
    fi
    if [[ "${deps_done}" == NO ]]; then
        echo "[x] failed to install dependencies"
        return 1
    fi

    local pyver=3.9.5
    PYTHON_CONFIGURE_OPTS="--enable-shared" ${HOME}/.pyenv/bin/pyenv install ${pyver}
    pyenv global 3.9.5
}

python_install
