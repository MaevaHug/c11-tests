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
cc -Wall -Wextra -Werror -o ft_any ft_any.c main.c
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
longest_test="Running tests for \`ft_any\` function with \`str_is_numeric\` as the callback function."
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
	echo "$> ./ft_any $(format_args "${args[@]}")"

	output=$(./ft_any "${args[@]}")
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

echo "$separator"
echo "Running tests for \`ft_any\` function with \`str_is_numeric\` as the callback function."
echo "The function will iterate over the array and check if any element is numeric."

# Test: Single numeric argument
run_test 123 "1" || all_tests_passed=false
# Test: Single non-numeric argument
run_test abc "0" || all_tests_passed=false
# Test: Multiple numeric arguments
run_test 123 456 789 "1" || all_tests_passed=false
# Test: Multiple non-numeric arguments
run_test abc def ghi "0" || all_tests_passed=false
# Test: Mixed numeric and non-numeric arguments
run_test 123 abc 456 def "1" || all_tests_passed=false
# Test: Argument "NULL"
run_test NULL "0" || all_tests_passed=false

# Final result
echo "$separator"
if $all_tests_passed; then
	echo -e "${GREEN}All tests passed: OK${NC}"
else
	echo -e "${RED}Some tests failed: KO${NC}"
fi
echo "$separator"

# Clean up compiled files
rm ft_any