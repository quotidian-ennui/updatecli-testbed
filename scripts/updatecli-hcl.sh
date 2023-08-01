#!/usr/bin/env bash
# Uses
#
# $1 = the operation
# $2 = the version number
# HCL_FILE_TO_EDIT = the file to edit
# HCL_ATTRIBUTE=resource.helm_release.reloader.version
set -eo pipefail

HCLEDIT="hcledit"
TFUPDATE="tfupdate"

TERRAFORM_DIR=$(dirname "$HCL_FILE_TO_EDIT")

function update_help()
{
  cat << EOF

Usage: updatecli-hcl.sh provider|hcl version number
  provider    : Updates a terraform provider via tfupdate
  hcl         : Updates HCL configuration via hcledit

EOF
 exit 1
}

diff_hcl() {
  currentVersion=$("$HCLEDIT" attribute get "$HCL_ATTRIBUTE" -f "${HCL_FILE_TO_EDIT}" | sed -e "s/\"//g")
  detectedVersion=$(internal::trim "$1")
  # if the current version != detectedVersion then do the thing.
  if [[ "$currentVersion" != "$detectedVersion" ]]; then
    echo "Update to $detectedVersion"
  fi
}

update_hcl() {
  currentVersion=$("$HCLEDIT" attribute get "$HCL_ATTRIBUTE" -f "${HCL_FILE_TO_EDIT}" | sed -e "s/\"//g")
  detectedVersion=$(internal::trim "$1")
  change_detected=$(diff_hcl "$1")
  if [[ ! -z "$change_detected" ]]; then
    echo "Updating $HCL_FILE_TO_EDIT [$HCL_ATTRIBUTE] to $detectedVersion"
    updateString="\"$detectedVersion\""
    "$HCLEDIT" attribute set "$HCL_ATTRIBUTE" "$updateString" -f "${HCL_FILE_TO_EDIT}" -u
  fi
}

update_provider() {
  detectedVersion=$(internal::trim "$1")
  change_detected=$(diff_provider "$1")
  if [[ ! -z "$change_detected" ]]; then
    echo "Updating $HCL_FILE_TO_EDIT [$HCL_ATTRIBUTE] to $detectedVersion"
    "$TFUPDATE" provider -v "$detectedVersion" "$HCL_ATTRIBUTE" "$HCL_FILE_TO_EDIT"
    "$TFUPDATE" lock --platform=windows_amd64 --platform=linux_amd64 --platform=darwin_amd64 --platform=darwin_arm64 "$TERRAFORM_DIR"
  fi
}

diff_provider() {
  detectedVersion=$(internal::trim "$1")
  changedFile=$(mktemp --tmpdir updatecli-hcl.XXXXXXXX)
  cp -f "$HCL_FILE_TO_EDIT" "$changedFile"
  "$TFUPDATE" provider -v "$detectedVersion" "$HCL_ATTRIBUTE" "$changedFile"
  origSha=$(sha256sum  "$HCL_FILE_TO_EDIT" | cut -f 1 -d' ')
  newSha=$(sha256sum  "$changedFile" | cut -f 1 -d' ')
  if [[ "$origSha" != "$newSha" ]]; then
    echo "Change detected; update to $detectedVersion"
  fi
}

internal::trim() {
  echo "$1" | sed -e "s/^[[:blank:]]*//" -e "s/[[:blank:]]*$//"
}


ACTION=$1 || true
ACTION=${ACTION:="help"}
if [[ "$#" -ne "0" ]]; then shift; fi
if [[ "$DRY_RUN" != "true" ]]; then
  "update_${ACTION}" "$@"
else
  "diff_${ACTION}" "$@"
fi
