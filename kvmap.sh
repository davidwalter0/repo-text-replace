#!/bin/bash

declare -A SEARCH_REPLACE_MAP
declare -A FILE_REMOVE_MAP
function setup-kv-map
{
    f1="search-1"
    r1="replace-1"
    f2="search-2"
    r2="replace-2"
    SEARCH_REPLACE_MAP=(
        ["${f1}"]=${r1}
        [${f2}]=${r2}
    )
}

function setup-file-map
{
    f1="go.mod"
    f2="go.sum"
    FILE_REMOVE_MAP=(
        ["${f1}"]=""
        ["${f2}"]=""
    )
}

function list-kv-map
{
    if (( ! ${#} )); then
        Error1 function list-kv-map: No argument given
    fi
    local name="${1}"
    local -n KV_MAP="${name}"
    
    echo "+-------------------------------------------------------------------+"
    echo "|                      REPO REPAIR CHANGE TABLE                     |"
    echo "+-------------------------------------------------------------------+"
    printf "| %-32.32s| %-32.32s|\n" Search Replace
    echo "+-------------------------------------------------------------------+"

    for key in "${!KV_MAP[@]}"; do
        printf "| %-32.32s| %-32.32s|\n" "${key}" "${KV_MAP[${key}]}"
    done
    echo "+-------------------------------------------------------------------+"
}


function list-file-kv-map
{
    if (( ! ${#} )); then
        Error1 function list-kv-map: No argument given
    fi
    local name="${1}"
    local -n KV_MAP="${name}"
    
    echo "+-------------------------------------------------------------------+"
    echo "|                   REPO REPAIR FILE DELETIONS                      |"
    echo "+-------------------------------------------------------------------+"
    printf "| %-64.64s  |\n" "Remove File"
    echo "+-------------------------------------------------------------------+"

    for key in "${!KV_MAP[@]}"; do
        printf "| %-64.64s  |\n" "${key}" 
    done
    echo "+-------------------------------------------------------------------+"
}

