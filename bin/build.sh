#!/bin/bash

DIR_ROOT=$( cd "$(dirname "${BASH_SOURCE[0]}")" && cd .. && pwd )

# shellcheck disable=SC1091
source "${DIR_ROOT}"/bin/common.sh


function zip_project() {
  project_name="$1"
  if cd "${DIR_ROOT}" && tar -zcvf "${project_name}".zip ./target/"${project_name}"; then
    info "success zip ${project_name}"
  else
    msg="zip ${project_name} failed."
    error "${msg}"
  fi
}

zip_project "$1"