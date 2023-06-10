# Other scripts can include this script use the follwoing command
#
# export SCRIPT_DIR=$(cd $(dirname ${BASH_SOURCE}); pwd -P)
# source ${SCRIPT_DIR}/../builtin/env.sh

export LIZSYS_SHELL_CONF=
export LIZSYS_SHELL_NAME=
case "$(basename $SHELL)" in
    bash)
        LIZSYS_SHELL_CONF=${HOME}/.bashrc
        LIZSYS_SHELL_NAME=bash
        ;;
    zsh)
        LIZSYS_SHELL_CONF=${HOME}/.zshrc
        LIZSYS_SHELL_NAME=zsh
        ;;
    *)
        echo "[x] unsupported shell $SHELL"
        exit 1
    ;;
esac
export LIZSYS_OS=
case "$(uname)" in
    Linux)
        LIZSYS_OS=Linux
        ;;
    Darwin)
        LIZSYS_OS=Darwin
        ;;
    *)
        echo "[x] unsupported OS"
        exit 1
        ;;
esac
export BUILTIN_DIR=$(cd $(dirname ${BASH_SOURCE}); pwd -P)
export LIZSYS_HOME=$(cd ${BUILTIN_DIR}/../..; pwd -P)
export LIZSYS_APP_DIR=${LIZSYS_HOME}/app && mkdir -p ${LIZSYS_APP_DIR}
