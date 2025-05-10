#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/wait.h>

int main() {
	int pipefd[2];
	pipe(pipefd);

	pid_t pid = fork();

	if (pid == 0) {
		close(pipefd[0]);
		dup2(pipefd[1], STDOUT_FILENO);
		execlp("ls", "ls", NULL);
		perror("Error en exec");
		exit(1);
	} else {
		close(pipefd[1]);
		dup2(pipefd[0], STDIN_FILENO);
		wait(NULL);
		execlp("wc", "wc", "-l", NULL);
		perror("Error en exec");
		exit(1);
	}

	return 0;
}
