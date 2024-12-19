all: exec

AVL.o : AVL.c AVL.h
	gcc -c AVL.c -o AVL.o

main.o : AVL.h
	gcc -c main.c -o main.o

exec : main.o AVL.o
	gcc main.o AVL.o -o exec

