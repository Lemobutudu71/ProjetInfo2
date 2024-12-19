#include <stdio.h>
#include <stdlib.h>
#include "AVL.h"

int main(){
    AVL *a = NULL;
    int identifiant = 0;
    long capacite = 0;
    long consommation = 0;
    int h = 0;
    while(scanf("%d;%ld;%ld\n", &identifiant, &capacite, &consommation )!= EOF){
    while(scanf("%d;%ld;%ld\n", &identifiant, &capacite, &consommation )!= EOF){
        a = InsertAvl(a, identifiant, capacite, consommation, &h);
    }
    Parcoursinfixe(a);
    a = freeAVL(a);
    return 0;

}