#!/bin/bash
# Unit tests for random-listening.sh

# Create a temporary test environment
setup_test_env() {
    mkdir -p test_env/content/genre
    mkdir -p test_env/content/recommendation
    mkdir -p test_env/content/instruments

    echo "[ ] Test file 1" > test_env/content/genre/prog-metal.md
    echo "[ ] Test file 2" > test_env/content/genre/prog-rock.md
    echo "[ ] Test file 3" > test_env/content/recommendation/greatest-prog-albums.md
    echo "[ ] Should be excluded" > test_env/content/instruments/excluded-file.md
}

# Clean up the test environment
cleanup_test_env() {
    rm -rf test_env
}

# Run a test case
run_test() {
    local description="$1"
    local command="$2"
    local expected="$3"

    echo "Running test: $description"
    output=$(eval "$command")
    if [[ "$output" == *"$expected"* ]]; then
        echo "PASS"
    else
        echo "FAIL: Expected '$expected', but got '$output'"
    fi
}

# Main test runner
main() {
    setup_test_env

    # Set the script path
    script="./random-listening.sh"

    # Test cases
    run_test "No arguments provided" \
        "$script" \
        "- ["

    run_test "Directory argument provided" \
        "$script genre" \
        "content/genre"

    run_test "String argument provided" \
        "$script genre Test" \
        "Test file"

    run_test "Excluded directories are not searched" \
        "$script instruments" \
        "No matches found."

    run_test "No matches found" \
        "$script genre 'nonexistent'" \
        "No matches found."

    run_test "Intentional failure to cover FAIL case" \
        "$script nonexistent" \
        "Nonexistent output"

    cleanup_test_env
}

main