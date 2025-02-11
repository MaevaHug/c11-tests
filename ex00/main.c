/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: mahug <marvin@42.fr>                       +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/02/11 06:54:10 by mahug             #+#    #+#             */
/*   Updated: 2025/02/11 06:54:12 by mahug            ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <stdio.h>
#include <stdlib.h>

void	ft_foreach(int *tab, int length, void (*f)(int));

void	ft_putnbr_nl(int n)
{
	printf("%d\n", n);
}

int	main(int argc, char **argv)
{
	int	*tab;
	int	len;
	int	i;

	if (argc < 2)
	{
		printf("Usage: %s <int_1> [<int_2> ... <int_n>]\n", argv[0]);
		return (0);
	}
	len = argc - 1;
	tab = (int *)malloc(sizeof(int) * len);
	if (!tab)
	{
		printf("Memory allocation error\n");
		return (2);
	}
	i = 0;
	while (i < len)
	{
		tab[i] = atoi(argv[i + 1]);
		i++;
	}
	ft_foreach(tab, len, &ft_putnbr_nl);
	free(tab);
	return (0);
}
