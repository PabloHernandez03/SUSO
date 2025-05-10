#include <stdio.h>
#include <unistd.h>
#include <sys/wait.h>

int main() {
	pid_t pid = fork();

	if (pid == 0) {
		printf("Proceso hijo (PID: %d) ejecutándose.\n", getpid());
	} else {
		int status;
		wait(&status);
		printf("Proceso padre: hijo terminó con código %d\n", WEXITSTATUS(status));
	}

	return 0;
}
