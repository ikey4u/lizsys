export SCRIPT_DIR=$(cd $(dirname ${BASH_SOURCE}); pwd -P)
source ${SCRIPT_DIR}/../builtin/env.sh

function llvm_install() {
    local appdir=${LIZSYS_APP_DIR}/llvm
    mkdir -p ${appdir}
    cd ${appdir}

    if [[ ${LIZSYS_OS} == Linux ]]; then
        local name=clang+llvm-16.0.0-x86_64-linux-gnu-ubuntu-18.04
        if [[ ! -d "${name}" ]]; then
            curl -LO https://github.com/llvm/llvm-project/releases/download/llvmorg-16.0.0/clang+llvm-16.0.0-x86_64-linux-gnu-ubuntu-18.04.tar.xz
            tar Jxvf clang+llvm-16.0.0-x86_64-linux-gnu-ubuntu-18.04.tar.xz &> /dev/null
        fi
        rm -rf current
        ln -sfn ${appdir}/${name} current
    else
        echo "[x] OS is not supported: ${LIZSYS_OS}"
        return 1
    fi

    if ! grep -q LIZSYS_LLVM_MARK ${LIZSYS_SHELL_CONF}; then
        cat >> ${LIZSYS_SHELL_CONF} <<EOF
# LIZSYS_LLVM_MARK
export LLVM_HOME=${appdir}/current
EOF
    fi
}

llvm_install
