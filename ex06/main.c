/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: mahug <marvin@42.fr>                       +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/02/11 06:55:15 by mahug             #+#    #+#             */
/*   Updated: 2025/02/11 06:55:16 by mahug            ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <stdlib.h>
#include <stdio.h>
#include <string.h>

void	ft_sort_string_tab(char **tab);

void	print_string_tab(char **tab, int size)
{
	int		i;

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
	ft_sort_string_tab(tab);
	print_string_tab(tab, size);
	return (0);
}
