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
cc -Wall -Wextra -Werror -o ft_foreach ft_foreach.c main.c
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
longest_test="Running tests for ft_foreach function with \`ft_putnbr_nl\` as the callback function."
# Add some padding for better visuals and generate the separator
separator=$(generate_separator $((${#longest_test} + 2)))

# Function to run a test and check the result
run_test() {
	local args=("$@")
	local expected="${args[-1]}"
	unset 'args[-1]'

	echo "$separator"
	echo "$> ./ft_foreach ${args[@]} | cat -e"

	output=$(./ft_foreach "${args[@]}" | cat -e)

	if [ "$output" == "$(echo -e "$expected")" ]; then
		echo -e "${GREEN}Test passed${NC}"
		#echo -e "-> Actual output:\n$output"
		return 0
	else
		echo -e "${RED}Test failed${NC}"
		echo -e "-> Expected output:\n$(echo -e "$expected" | cat -e)"
		echo -e "-> Actual output:\n$output"
		return 1
	fi
}

# Run tests
all_tests_passed=true

echo "$separator"
echo "Running tests for ft_foreach function with \`ft_putnbr_nl\` as the callback function."
echo "The function will iterate over the array and print each element with a newline."

# Test 1: Single integer
run_test 42 "42$" || all_tests_passed=false
# Test 2: Multiple integers
run_test 1 2 3 4 5 "1$\n2$\n3$\n4$\n5$" || all_tests_passed=false
# Test 3: Negative integers
run_test -1 -2 -3 -4 -5 "-1$\n-2$\n-3$\n-4$\n-5$" || all_tests_passed=false
# Test 4: Mixed integers
run_test 0 -1 2 -3 4 "0$\n-1$\n2$\n-3$\n4$" || all_tests_passed=false

# Final result
echo "$separator"
if $all_tests_passed; then
	echo -e "${GREEN}All tests passed: OK${NC}"
else
	echo -e "${RED}Some tests failed: KO${NC}"
fi
echo "$separator"

# Clean up compiled files
rm ft_foreach