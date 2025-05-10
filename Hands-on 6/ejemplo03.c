#include <stdio.h>
#include <pthread.h>
int contador = 0;

void *incrementar(void *arg)
{
	for (int i = 0; i < 100000; i++)
	{
		contador++;
	}
	return NULL;
}
int main()
{
	pthread_t h1, h2;
	pthread_create(&h1, NULL, incrementar, NULL);
	pthread_create(&h2, NULL, incrementar, NULL);
	pthread_join(h1, NULL);
	pthread_join(h2, NULL);
	printf("Valor final del contador: %d\n", contador);
	return 0;
}