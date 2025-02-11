/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: mahug <marvin@42.fr>                       +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/02/11 06:55:25 by mahug             #+#    #+#             */
/*   Updated: 2025/02/11 06:55:27 by mahug            ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <stdlib.h>
#include <stdio.h>
#include <string.h>

void	ft_advanced_sort_string_tab(char **tab, int (*cmp)(char *, char *));

int	ft_strcmp(char *s1, char *s2)
{
	while (*s1 && *s2 && (*s1 == *s2))
	{
		s1++;
		s2++;
	}
	return (*(unsigned char *)s1 - *(unsigned char *)s2);
}

void	print_string_tab(char **tab, int size)
{
	int	i;

	i = 0;
	while (i < size)
	{
		printf("%s", tab[i]);
		if (i < size - 1)
			printf(", ");
		else
			printf("\n");
		i++;
	}
}

int	main(int argc, char **argv)
{
	char	**tab;
	int		size;

	if (argc < 2)
	{
		printf("Usage: %s <str_1> [<str_2> ... <str_n>]\n", argv[0]);
		return (0);
	}
	size = argc - 1;
	if (size == 1 && strcmp(argv[1], "NULL") == 0)
		argv[1] = NULL;
	tab = argv + 1;
	ft_advanced_sort_string_tab(tab, &ft_strcmp);
	print_string_tab(tab, size);
	return (0);
}
