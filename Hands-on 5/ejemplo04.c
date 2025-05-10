#include <stdio.h>
#include <unistd.h>

int main() {
	pid_t pid = fork();

	if (pid == 0) {
		execlp("ls", "ls", "-l", NULL);
	} else {
		wait(NULL);
		printf("Proceso padre esperando al hijo.\n");
	}

	return 0;
}
