#!/bin/bash

DIR_ROOT=$( cd "$(dirname "${BASH_SOURCE[0]}")" && cd .. && pwd )

# shellcheck disable=SC1091
source "${DIR_ROOT}"/bin/common.sh


function zip_project() {
  project_name="$1"
  cd "${DIR_ROOT}" || exit
  if [ -f ./target/"${project_name}".zip ]; then
    rm -rf ./target/"${project_name}".zip
  fi

  if zip -r ./target/"${project_name}".zip ./"${project_name}"; then
    info "success zip ${project_name}"
  else
    msg="zip ${project_name} failed."
    error "${msg}"
  fi
}

zip_project "$1"