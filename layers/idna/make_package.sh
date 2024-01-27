#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

HERE="$(dirname "$( realpath "$0" )" )"

if finch -v 2>/dev/null ; then
    finch vm start 2>/dev/null || true
    finch run -it --rm -v "${HERE}:/workdir" public.ecr.aws/sam/build-python3.11 bash -c "cd /workdir && bash $(basename $0)"
    exit $?
fi

uname -a

PIP="$(which pip3 2>/dev/null)" || PIP="pip"

TMPDIR="$(mktemp -d -t lambda_package_layer.XXXXXXXXXX)" || exit 1

$PIP install --platform manylinux2014_aarch64 --platform manylinux2014_x86_64 --implementation cp --python-version 3.11 --only-binary=:all: --target "${TMPDIR}/python" -r "${HERE}/requirements.txt"

cd "${TMPDIR}"

rm -f "${HERE}/package.zip"

zip -q -r "${HERE}/package.zip" . -x '*/__pycache__/*'

ls -l "${HERE}/package.zip"

cd /

rm -rf "${TMPDIR}"
