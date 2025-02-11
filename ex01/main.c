/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: mahug <marvin@42.fr>                       +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/02/11 06:54:28 by mahug             #+#    #+#             */
/*   Updated: 2025/02/11 06:54:30 by mahug            ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <stdio.h>
#include <stdlib.h>

int	*ft_map(int *tab, int length, int (*f)(int));

int	multiply_by_two(int n)
{
	return (n * 2);
}

int	*allocate_and_fill_array(int argc, char **argv, int *length)
{
	int	*tab;
	int	i;

	*length = argc - 1;
	tab = (int *)malloc(sizeof(int) * (*length));
	if (!tab)
	{
		printf("Memory allocation Failed\n");
		return (NULL);
	}
	i = 0;
	while (i < *length)
	{
		tab[i] = atoi(argv[i + 1]);
		i++;
	}
	return (tab);
}

void	print_array(int *tab, int length)
{
	int	i;

	i = 0;
	while (i < length)
	{
		printf("%d ", tab[i]);
		i++;
	}
	printf("\n");
}

int	main(int argc, char **argv)
{
	int	*tab;
	int	*result_tab;
	int	len;

	if (argc < 2)
	{
		printf("Usage: %s <int_1> [<int_2> ... <int_n>]\n", argv[0]);
		return (0);
	}
	tab = allocate_and_fill_array(argc, argv, &len);
	if (!tab)
		return (1);
	result_tab = ft_map(tab, len, &multiply_by_two);
	if (!result_tab)
	{
		printf("Memory allocation Failed\n");
		free(tab);
		return (1);
	}
	print_array(result_tab, len);
	free(tab);
	free(result_tab);
	return (0);
}
