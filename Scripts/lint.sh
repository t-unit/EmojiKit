#!/bin/bash

# convert output into GitHub Actions Logging commands
# https://help.github.com/en/github/automating-your-workflow-with-github-actions/development-tools-for-github-actions#logging-commands

function stripPWD() {
    sed -E "s/$(pwd|sed 's/\//\\\//g')\///"
}

function convertToGitHubActionsLoggingCommands() {
    sed -E 's/^(.*):([0-9]+):([0-9]+): (warning|error|[^:]+): (.*)/::\4 file=\1,line=\2,col=\3::\5/'
}

# set -o pipefail && swiftlint --path . --config .swiftlint.yml | stripPWD | convertToGitHubActionsLoggingCommands
set -o pipefail && swiftformat . --swiftversion 5 --lint 2> >(stripPWD) | convertToGitHubActionsLoggingCommands