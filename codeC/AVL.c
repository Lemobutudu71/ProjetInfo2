
#include "AVL.h"

AVL *creerAVL( int identifiant, long capacite, long consommation){
    AVL *a = (AVL*)malloc(sizeof(AVL));
    if( a == NULL){
        printf(" Erreur d'allocation memoire\n");
        exit(1);
    }
    a->identifiant = identifiant;
    a->capacite = capacite;
    a->consommation = consommation;
    a->gauche = NULL;
    a->droit = NULL;
    a->equilibre = 0;
    return a;
}

int min (int a, int b, int c){
    int min = a;
    if( b < min){
        min = b;
    }        
    if( c < min){
        min = c;
    }
    return min;
}

int max( int a, int b, int c){
    int max = a;
    if( b > max){
        max = b;
    }
    if( c > max){
        max = c;
    }
    return max;
}

AVL *rotationGauche(AVL *a){
    if( a == NULL){
        return NULL;
    }
    AVL *pivot = a->droit;
    a->droit = pivot->gauche;
    pivot->gauche = a;
    int eqA = a->equilibre;
    int eqB = pivot->equilibre;
    a->equilibre = eqA - max(eqB, 0, 0) - 1;
    pivot->equilibre = min( (eqA -2), (eqA + eqB -2), (eqB -1));
    return pivot;
}

AVL *rotationDroite(AVL *a){//changement 
    if( a == NULL){
        return NULL;
    }
    AVL *pivot = a->gauche;
    a->gauche = pivot->droit;
    pivot->droit = a;
    int eqA = a->equilibre;
    int eqB = pivot->equilibre;
    a->equilibre = eqA - min(eqB, 0, 0) + 1;
    pivot->equilibre = max( (eqA + 2), (eqA + eqB + 2), (eqB + 1));
    return pivot;
}

AVL *doubleRotationGauche(AVL *a){
    a->droit = rotationDroite(a->droit);
    a = rotationGauche(a);
    return a;
}

AVL *doubleRotationDroite(AVL *a){
    a->gauche = rotationGauche(a->gauche);
    a = rotationDroite(a);
    return a;
}

AVL * Choixrotation( AVL *a){
	if( a == NULL){
		printf("Erreur\n");
		return ;
	}
	if( a == NULL){
		printf("Erreur\n");
		return ;
	}
    if( a->equilibre >= 2){
        if( a->equilibre >= 0){
            return rotationGauche(a);
        }
        else {
            return doubleRotationGauche(a);
        }
    }
    if( a->equilibre <= -2){
        if(a->equilibre <= 0){
            return rotationDroite(a);
        }
        else {
            return doubleRotationDroite(a);
        }
    }
    return a;
}




AVL *InsertAvl( AVL *a, int identifiant, long capacite, long consommation , int *h){
    if( a == NULL){
        *h = 1; 
        return creerAVL(identifiant, capacite, consommation);
    }
    else if ( identifiant < a->identifiant){
        a->gauche = InsertAvl( a->gauche, identifiant, capacite, consommation, h);
        *h = -*h;
    }
    else if( identifiant > a->identifiant){
        a->droit = InsertAvl(a->droit, identifiant, capacite, consommation, h);
    }
    else {
        a->consommation += consommation;
		a->capacite += capacite
		a->capacite += capacite
        *h = 0;
        return a;
    }
    if (*h != 0){
        a->equilibre = a->equilibre + *h;
        a = Choixrotation(a);
        if( a->equilibre == 0){
            *h = 0;
        }
        else {
            *h = -1;
        }
    }
    return a;
}



void Parcoursinfixe(AVL *a){
    if( a != NULL){
        Parcoursinfixe(a->gauche);
        printf("%d:%ld:%ld\n", a->identifiant, a->capacite, a->consommation);
        printf("%d:%ld:%ld\n", a->identifiant, a->capacite, a->consommation);
        Parcoursinfixe(a->droit);
    }
}

// Fonction récursive pour exporter un noeud de l'AVL dans un fichier
void AVLdansFichier(FILE *fichier, AVL *a) {
    if (a == NULL){
        return;
    }   
    AVLdansFichier(fichier, a->gauche);
    fprintf(fichier,"%d:%ld:%ld\n", a->identifiant, a->capacite, a->consommation);     // Écrire les données du noeud actuel
    AVLdansFichier(fichier, a->droit);
}
// Fonction pour ouvrir un fichier et commencer l'export
void sauvegarderNoeudAVLDansFichier(const char *nomFichier, AVL *a) {
    FILE *fichier = fopen(nomFichier, "w");  // Ouvrir le fichier en mode écriture
    if (fichier == NULL) {
        perror("Erreur lors de l'ouverture du fichier pour l'export");
        return;
    }
	fprintf(fichier, "Station:Capacité:Consommation\n");
	fprintf(fichier, "Station:Capacité:Consommation\n");
    // Appeler la fonction récursive pour exporter les données
    AVLdansFichier(fichier, a);
    // Fermer le fichier
    fclose(fichier);
}


AVL *freeAVL(AVL *a){
    if(a == NULL){
        return a;
    }
    a->gauche = freeAVL(a->gauche);
    a->gauche = NULL;
    a->droit = freeAVL(a->droit);
    a->droit = NULL;
    free(a);
    return a;
}

