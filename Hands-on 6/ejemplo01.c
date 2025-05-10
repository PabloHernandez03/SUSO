#include <stdio.h>
#include <pthread.h>

void* tarea(void* arg) {
	printf("Hola desde el hilo!\n");
	return NULL;
}

int main() {
	pthread_t hilo;
	pthread_create(&hilo, NULL, tarea, NULL);
	pthread_join(hilo, NULL);
	printf("Hilo finalizado.");
	return 0;
}