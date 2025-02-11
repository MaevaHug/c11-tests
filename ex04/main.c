/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: mahug <marvin@42.fr>                       +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/02/11 06:55:01 by mahug             #+#    #+#             */
/*   Updated: 2025/02/11 06:55:03 by mahug            ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

int	ft_is_sort(int *tab, int length, int (*f)(int, int));

int	ft_int_compare(int a, int b)
{
	return (a - b);
}

int	str_is_numeric(char *str)
{
	if (!str || !*str)
		return (0);
	if (*str == '-' || *str == '+')
		str++;
	while (*str)
	{
		if (!isdigit(*str))
			return (0);
		str++;
	}
	return (1);
}

int	*allocate_and_fill_array(int argc, char **argv, int *length)
{
	int	*tab;
	int	i;

	*length = argc - 1;
	tab = (int *)malloc(*length * sizeof(int));
	if (!tab)
	{
		printf("Memory allocation failed.\n");
		return (NULL);
	}
	i = 0;
	while (++i < argc)
	{
		if (!str_is_numeric(argv[i]))
		{
			printf("Invalid argument: '%s'.\n", argv[i]);
			free(tab);
			return (NULL);
		}
		tab[i - 1] = atoi(argv[i]);
	}
	return (tab);
}

int	main(int argc, char **argv)
{
	int	length;
	int	*tab;
	int	is_sorted;

	if (argc < 2)
	{
		printf("Usage: %s <number_1> [<number_2> ... <number_n>]\n", argv[0]);
		return (0);
	}
	tab = allocate_and_fill_array(argc, argv, &length);
	if (!tab)
		return (1);
	is_sorted = ft_is_sort(tab, length, &ft_int_compare);
	printf("%d\n", is_sorted);
	free(tab);
	return (0);
}
