export BUILTIN_DIR=$(cd $(dirname ${BASH_SOURCE}); pwd -P)
export LIZSYS_HOME=$(cd ${BUILTIN_DIR}/../..; pwd -P)
export LIZSYS_APP_DIR=${LIZSYS_HOME}/app && mkdir -p ${LIZSYS_APP_DIR}
