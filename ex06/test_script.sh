#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Run norminette check
echo "Running norminette check..."
output=$(norminette 2>&1)
if [ $? -ne 0 ]; then
	echo "$output" | grep -E --color=always "Error|Warning|Norme"
	echo -e "${RED}Norminette check failed${NC}"
#	exit 1
else
	echo -e "${GREEN}Norminette check passed${NC}"
fi

# Compile the files
echo "Compiling files..."
cc -Wall -Wextra -Werror -o ft_sort_string_tab ft_sort_string_tab.c main.c
if [ $? -ne 0 ]; then
	echo -e "${RED}Compilation failed${NC}"
	exit 1
else
	echo -e "${GREEN}Compilation succeded${NC}"
fi

# Function to generate a separator line of a given length
generate_separator() {
	local length=$1
	local separator=""
	for ((i=0; i<length; i++)); do
		separator="${separator}="
	done
	echo "$separator"
}

# Assign the longest test to a variable
longest_test="$> ./ft_sort_string_tab \"apple\" \"apple\" \"banana\" \"banana\""
# Add some padding for better visuals and generate the separator
separator=$(generate_separator $((${#longest_test} + 2)))

# Function to format arguments with quotes
format_args() {
	local args=("$@")
	local formatted_args=""
	for arg in "${args[@]}"; do
		formatted_args="$formatted_args \"$arg\""
	done
	# Remove the leading space
	formatted_args=$(echo $formatted_args | sed 's/^ //')
	echo "$formatted_args"
}

# Function to run a test and check the result
run_test() {
	local args=("$@")
	local expected="${args[-1]}"
	unset 'args[-1]'

	echo "$separator"
	echo "$> ./ft_sort_string_tab $(format_args "${args[@]}")"

	output=$(./ft_sort_string_tab "${args[@]}")

	if [ "$output" == "$expected" ]; then
		echo -e "${GREEN}Test passed${NC}"
		#echo -e "-> Actual output:\n$output"
		return 0
	else
		echo -e "${RED}Test failed${NC}"
		echo -e "-> Expected output:\n$expected"
		echo -e "-> Actual output:\n$output"
		return 1
	fi
}

# Run tests
all_tests_passed=true

# Test: Single string argument
run_test "abc" "abc" || all_tests_passed=false
# Test: Multiple string arguments in alphabetical order
run_test "a" "bb" "ccc" "a, bb, ccc" || all_tests_passed=false
# Test: Multiple string arguments in reverse alphabetical order
run_test "ccc" "bb" "a" "a, bb, ccc" || all_tests_passed=false
# Test: Multiple string arguments in random order
run_test "bb" "ccc" "a" "a, bb, ccc" || all_tests_passed=false
# Test: Multiple string arguments not sorted
run_test "banana" "cherry" "apple" "apple, banana, cherry" || all_tests_passed=false
# Test: Multiple string arguments with duplicates
run_test "apple" "apple" "banana" "banana" "apple, apple, banana, banana" || all_tests_passed=false
# Test: Multiple string arguments with mixed case
run_test "Banana" "apple" "Cherry" "Banana, Cherry, apple" || all_tests_passed=false
# Test: Arguments multiples avec des caractères non imprimables
run_test "abc" "$(printf '\x80')" "def" "$(printf '\xFF')" "abc, def, $(printf '\x80'), $(printf '\xFF')" || all_tests_passed=false
# Test: All arguments are the same
run_test "same" "same" "same" "same, same, same" || all_tests_passed=false
# Test: NULL string argument
run_test "NULL" "(null)" || all_tests_passed=false

# Final result
echo "$separator"
if $all_tests_passed; then
	echo -e "${GREEN}All tests passed: OK${NC}"
else
	echo -e "${RED}Some tests failed: KO${NC}"
fi
echo "$separator"

# Clean up compiled files
rm ft_sort_string_tab