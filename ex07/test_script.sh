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
cc -Wall -Wextra -Werror -o ft_advanced_sort_string_tab ft_advanced_sort_string_tab.c main.c
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
longest_test="$> ./ft_advanced_sort_string_tab alpha \"apple\" \"apple\" \"banana\" \"banana\""
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

run_test() {
	local sort_type="$1"
	shift
	local args=("$@")
	local expected="${args[-1]}"
	unset 'args[-1]'

	echo "$separator"
	echo "$> ./ft_advanced_sort_string_tab $sort_type $(format_args "${args[@]}")"

	output=$(./ft_advanced_sort_string_tab "$sort_type" "${args[@]}")

	if [ "$output" == "$expected" ]; then
		echo -e "${GREEN}Test passed${NC}"
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

echo "Testing alphabetical sorting..."
# Alphabetical sorting tests
run_test "alpha" "abc" "abc" || all_tests_passed=false
run_test "alpha" "a" "bb" "ccc" "a, bb, ccc" || all_tests_passed=false
run_test "alpha" "ccc" "bb" "a" "a, bb, ccc" || all_tests_passed=false
run_test "alpha" "bb" "ccc" "a" "a, bb, ccc" || all_tests_passed=false
run_test "alpha" "banana" "cherry" "apple" "apple, banana, cherry" || all_tests_passed=false
run_test "alpha" "apple" "apple" "banana" "banana" "apple, apple, banana, banana" || all_tests_passed=false
run_test "alpha" "Banana" "apple" "Cherry" "Banana, Cherry, apple" || all_tests_passed=false
run_test "alpha" "abc" "$(printf '\x80')" "def" "$(printf '\xFF')" "abc, def, $(printf '\x80'), $(printf '\xFF')" || all_tests_passed=false
run_test "alpha" "same" "same" "same" "same, same, same" || all_tests_passed=false
run_test "alpha" "NULL" "(null)" || all_tests_passed=false

echo "Testing length-based sorting..."
# Length-based sorting tests
run_test "length" "Qeubj" "urS1f6q0" "qTuL5QBx" "mDJx5qQ" "XZOTtB" "lfw" "zt5" "3RgO" "OGMCixm0w" "wa2E" "qWr" "h" "F" "SOFL0tfczxW" "m" "IlR" \
			"h, F, m, lfw, zt5, qWr, IlR, 3RgO, wa2E, Qeubj, XZOTtB, mDJx5qQ, urS1f6q0, qTuL5QBx, OGMCixm0w, SOFL0tfczxW" || all_tests_passed=false

# Final result
echo "$separator"
if $all_tests_passed; then
	echo -e "${GREEN}All tests passed: OK${NC}"
else
	echo -e "${RED}Some tests failed: KO${NC}"
fi
echo "$separator"

# Clean up compiled files
rm ft_advanced_sort_string_tab