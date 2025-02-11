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

# Compile the files using make
echo "Compiling the program..."
make > /dev/null 2> make_errors.log
if [ $? -ne 0 ]; then
	echo -e "${RED}Compilation failed${NC}"
	cat make_errors.log
	rm -f make_errors.log
	exit 1
else
	rm -f make_errors.log
	echo -e "${GREEN}Compilation succeeded${NC}"
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
longest_test="$> ./do-op \"42amis\" \"-\" \"--+-20toto12\"  | cat -e"
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
	echo "$> ./do-op $(format_args "${args[@]}") | cat -e"

	output=$(./do-op "${args[@]}" | cat -e)

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

# Test: too many arguments, should return nothing
run_test 1 + 1 1 "" || all_tests_passed=false
# Test: Simple addition
run_test 1 + 1 "2$" || all_tests_passed=false
# Test: Complex input with non-numeric characters, should ignore them and perform subtraction
run_test 42amis - --+-20toto12 "62$" || all_tests_passed=false
# Test: Unknown operator, should return 0
run_test 1 p 1 "0$" || all_tests_passed=false
# Test: Addition with non-numeric characters in the second operand, should ignore them
run_test 1 + toto3 "1$" || all_tests_passed=false
# Test: Addition with non-numeric characters in the first operand, should ignore them
run_test toto3 + 4 "4$" || all_tests_passed=false
# Test: Completely invalid input, should return 0
run_test foo plus bar "0$" || all_tests_passed=false
# Test: Invalid input with a valid operator, should return 0
run_test 42 ++ 42 "0$" || all_tests_passed=false
# Test: Division by zero, should return an error message
run_test 25 / 0 "Stop : division by zero$" || all_tests_passed=false
# Test: Modulo by zero, should return an error message
run_test 25 % 0 "Stop : modulo by zero$" || all_tests_passed=false
# Test: Simple multiplication
run_test 6 "*" 7 "42$" || all_tests_passed=false
# Test: Simple division
run_test 20 / 4 "5$" || all_tests_passed=false
# Test: Simple modulo operation
run_test 20 % 3 "2$" || all_tests_passed=false


# Final result
echo "$separator"
if $all_tests_passed; then
	echo -e "${GREEN}All tests passed: OK${NC}"
else
	echo -e "${RED}Some tests failed: KO${NC}"
fi
echo "$separator"

# Clean up compiled files
make fclean > /dev/null
