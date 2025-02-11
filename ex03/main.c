/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: mahug <marvin@42.fr>                       +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/02/11 06:54:51 by mahug             #+#    #+#             */
/*   Updated: 2025/02/11 06:54:53 by mahug            ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <stdio.h>
#include <string.h>
#include <ctype.h>

int	ft_count_if(char **tab, int length, int (*f)(char *));

int	str_is_numeric(char *str)
{
	if (!str || !*str)
		return (0);
	while (*str)
	{
		if (!isdigit(*str))
			return (0);
		str++;
	}
	return (1);
}

int	main(int argc, char **argv)
{
	int	length;
	int	numeric_count;

	if (argc < 2)
	{
		printf("Usage: %s <str_1> [<str_2> ... <str_n>]\n", argv[0]);
		return (0);
	}
	length = argc - 1;
	if (argc == 2 && strcmp(argv[1], "NULL") == 0)
		argv[1] = NULL;
	numeric_count = ft_count_if(argv + 1, length, &str_is_numeric);
	printf("%d\n", numeric_count);
	return (0);
}
