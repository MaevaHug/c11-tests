/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: mahug <marvin@42.fr>                       +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/02/11 06:55:25 by mahug             #+#    #+#             */
/*   Updated: 2025/02/12 21:54:19 by mahug            ###   ########.fr       */
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

int	length_cmp(char *s1, char *s2)
{
	return (strlen(s1) - strlen(s2));
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

void	print_usage(char *exec)
{
	printf("Usage: %s <sort_type> <str_1> [<str_2> ... <str_n>]\n", exec);
	printf("sort_type: 'alpha' for alphabetical or "\
		"'length' for length-based sorting\n");
}

int	main(int argc, char **argv)
{
	char	**tab;
	int		size;
	int		(*cmp)(char *, char *);

	if (argc < 3)
	{
		print_usage(argv[0]);
		return (0);
	}
	if (strcmp(argv[1], "alpha") == 0)
		cmp = &ft_strcmp;
	else if (strcmp(argv[1], "length") == 0)
		cmp = &length_cmp;
	else
	{
		printf("Invalid sort type. Use 'alpha' or 'length'\n");
		return (1);
	}
	size = argc - 2;
	tab = argv + 2;
	if (size == 1 && strcmp(tab[0], "NULL") == 0)
		tab[0] = NULL;
	ft_advanced_sort_string_tab(tab, cmp);
	print_string_tab(tab, size);
	return (0);
}
