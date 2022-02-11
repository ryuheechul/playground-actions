#!/usr/bin/env bash

# name input arguments and "constants"
templates_path="$(dirname "$0")"
filename="$1"
name="$2"
extension="${filename##*.}"
usage="usage: $0 [filename] [name]"
where_to_run='kustomization.yaml is not found. Run this script inside the target directory'

# fail when there is no kustomization.yaml in target directory
! test -f kustomization.yaml && echo "${where_to_run}" && exit 1
# fail when wrong inputs
test -z "${filename}" && echo "${usage}" && exit 1
test "yaml" != ${extension} && echo 'filename must end with `yaml`' && exit 1
test -z "${name}" && echo "${usage}" && exit 1

# edit name and create/overwrite to a file
cat "${templates_path}/namespace.yaml" | yq ".metadata.name = \"${name}\"" > "${filename}"
# add to kustomization.yaml
kustomize edit add resource "./${filename}"

# success feedback
echo "${filename} is created and added to kustomization.yaml"
