#!/usr/bin/env bash
set -e

PKGS=$(go list ./... | grep -v /examples)
FORMATTABLE="$(ls -d */)"
LINTABLE=$(go list ./...)

go test $PKGS -cover
go vet $PKGS

echo "Checking gofmt..."
fmtRes=$(gofmt -l $FORMATTABLE)
if [ -n "${fmtRes}" ]; then
  echo -e "gofmt checking failed:\n${fmtRes}"
  exit 2
fi

# echo "Checking golint..."
# lintRes=$(echo $LINTABLE | xargs -n 1 golint)
# if [ -n "${lintRes}" ]; then
#   echo -e "golint checking failed:\n${lintRes}"
#   exit 2
# fi
