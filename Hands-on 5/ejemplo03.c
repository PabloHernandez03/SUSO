#include <stdio.h>
#include <unistd.h>

int main() {
	for (int i=0; i < 3; i++) {
		pid_t pid = fork();
		if (pid == 0) {
			printf("Hijo %d, PID: %d\n", i, getpid());
			return 0;
		}
	}

	return 0;
}
