#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#define NUM_HILOS 4
#define REPETICIONES 50000
typedef struct
{
	int id;
	int *contador_global;
	pthread_mutex_t *mutex;
} DatosHilo;
void *tarea(void *arg)
{
	DatosHilo *datos = (DatosHilo *)arg;
	for (int i = 0; i < REPETICIONES; i++)
	{
		pthread_mutex_lock(datos->mutex);
		(*datos->contador_global)++;
		pthread_mutex_unlock(datos->mutex);
	}
printf("Hilo %d finalizado.
", datos->id);
return NULL;
}
int main()
{
	pthread_t hilos[NUM_HILOS];
	DatosHilo datos[NUM_HILOS];
	int contador = 0;
	pthread_mutex_t mutex;
	pthread_mutex_init(&mutex, NULL);
	for (int i = 0; i < NUM_HILOS; i++)
	{
		datos[i].id = i;
		datos[i].contador_global = &contador;
		datos[i].mutex = &mutex;
		pthread_create(&hilos[i], NULL, tarea, &datos[i]);
	}
	for (int i = 0; i < NUM_HILOS; i++)
	{
		pthread_join(hilos[i], NULL);
	}
	pthread_mutex_destroy(&mutex);
printf("Contador final: %d
", contador);
return 0;
}