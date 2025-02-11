/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: mahug <marvin@42.fr>                       +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/02/11 06:54:42 by mahug             #+#    #+#             */
/*   Updated: 2025/02/11 06:54:44 by mahug            ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <stdio.h>
#include <string.h>
#include <ctype.h>

int	ft_any(char **tab, int (*f)(char *));

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
	int		any_is_numeric;

	if (argc < 2)
	{
		printf("Usage: %s <str_1> [<str_2> ... <str_n>]\n", argv[0]);
		return (0);
	}
	if (argc == 2 && strcmp(argv[1], "NULL") == 0)
		argv[1] = NULL;
	any_is_numeric = ft_any(argv + 1, &str_is_numeric);
	printf("%d\n", any_is_numeric);
	return (0);
}
