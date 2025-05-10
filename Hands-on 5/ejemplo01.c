#include <stdio.h>
#include <unistd.h>

int main() {
	pid_t pid = fork();

	if (pid == 0) {
		printf("Soy el proceso hijo. PID: %d\n", getpid());
	} else {
		printf("Soy el proceso padre. PID: %d. Hijo %d\n", getpid(), pid);
	}

	return 0;
}
