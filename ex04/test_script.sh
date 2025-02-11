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
cc -Wall -Wextra -Werror -o ft_is_sort ft_is_sort.c main.c
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
longest_test="The function should return 1 if the array is sorted, 0 otherwise."
# Add some padding for better visuals and generate the separator
separator=$(generate_separator $((${#longest_test} + 2)))

# Function to run a test and check the result
run_test() {
	local args=("$@")
	local expected="${args[-1]}"
	unset 'args[-1]'

	echo "$separator"
	echo "$> ./ft_is_sort ${args[@]}"

	output=$(./ft_is_sort "${args[@]}")

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

echo "$separator"
echo "Running tests for \`ft_is_sort\` function."
echo "The function should return 1 if the array is sorted, 0 otherwise."

# Run tests
all_tests_passed=true

# Test: Single numeric argument
run_test 123 "1" || all_tests_passed=false
# Test: Multiple numeric arguments in ascending order
run_test 123 456 789 "1" || all_tests_passed=false
# Test: Multiple numeric arguments in descending order
run_test 789 456 123 "1" || all_tests_passed=false
# Test: Multiple numeric arguments not sorted
run_test 123 789 456 "0" || all_tests_passed=false
# Test: Multiple numeric arguments with duplicates
run_test 123 123 456 456 "1" || all_tests_passed=false
# Test: Multiple numeric arguments with negative numbers
run_test -3 -2 -1 0 1 2 3 "1" || all_tests_passed=false
# Test: Multiple numeric arguments with mixed order
run_test 1 3 2 4 5 "0" || all_tests_passed=false
# Test: Multiple consecutive same arguments
run_test 1 1 1 1 2 "1" || all_tests_passed=false
# Test: All arguments are the same
run_test 5 5 5 5 5 "1" || all_tests_passed=false

# Final result
echo "$separator"
if $all_tests_passed; then
	echo -e "${GREEN}All tests passed: OK${NC}"
else
	echo -e "${RED}Some tests failed: KO${NC}"
fi
echo "$separator"

# Clean up compiled files
rm ft_is_sort