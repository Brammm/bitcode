#!/usr/bin/env bash

set -e

assert_page_contains() {
    local expected_content="$1"
    local response=`curl -s http://localhost:8080`

    if grep -q -e '$expected_content' <<<$response; then
        echo $?
        echo "It's not there: $expected_content"
    else
        echo $?
        echo "It's there: $expected_content"
    fi

    exit;
}

assert_page_contains 'Bram'