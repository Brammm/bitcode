#!/usr/bin/env bash

set -e

assert_page_contains() {
    local expected_content="$1"
    local response=`curl -s http://localhost:8080`

    if grep -q -e '$expected_content' <<<$response; then
        echo "It's not there: $expected_content" && exit 1
    fi

    echo "It's there: $expected_content" && exit 0
}

## Should fail
assert_page_contains 'FOO'
## Should pass
assert_page_contains 'Bram Van der Sype'
