
#ifndef AVL_H
#define AVL_H
#ifndef AVL_H
#define AVL_H
#include <stdio.h>
#include <stdlib.h>

typedef struct AVL {
    int identifiant;
    long capacite;
    long consommation;    
    struct AVL *gauche;  
    struct AVL *droit;   
    int equilibre;         
} AVL;

AVL *creerAVL( int identifiant, long capacite, long consommation);
int min (int a, int b, int c);
int max( int a, int b, int c);
AVL *rotationGauche(AVL *a);
AVL *rotationDroite(AVL *a);
AVL *doubleRotationGauche(AVL *a);
AVL *doubleRotationDroite(AVL *a);
AVL *Choixrotation( AVL *a);
AVL *InsertAvl( AVL *a, int identifiant, long capacite, long consommation, int *h);
void Parcoursinfixe(AVL *a);
AVL *freeAVL(AVL *a);
void AVLdansFichier(FILE *fichier, AVL *a);
void sauvegarderNoeudAVLDansFichier(const char *nomFichier, AVL *a);
#endif