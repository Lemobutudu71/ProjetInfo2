Projet d’informatique : Gestion des Stations Électriques

Ce projet utilise une structure de données AVL pour gérer des données relatives aux stations électriques, notamment leur capacité et leur consommation. Le projet inclut des outils pour insérer, parcourir, et exporter des données AVL.

Structure du Projet

- `AVL.h` : Définit la structure de l'arbre AVL et les prototypes des fonctions associées.
- `AVL.c` : Implémente les fonctions pour manipuler l'arbre AVL (insertion, rotations, parcours, exportation).
- `main.c` : Point d'entrée principal du programme pour lire les données d'entrée, insérer les nœuds dans l'AVL et afficher/exporter les résultats.
- `Makefile` : Facilite la compilation du programme.
- `c-wire.sh` : Script shell pour traiter le fichiers CSV et intégrer l'exécutable.


Prérequis

Assurez-vous que les éléments suivants sont installés sur votre système :

- `gcc` (compilateur C)
- `make` (outil de build)
- Bash (pour exécuter le script shell)

Utilisation du programme
Une fois le fichier ProjetInfo2 téléchargé, vous devez placer le fichier c-wire_v25.dat dans le dossier input.
Si 

Compilation

Pour compiler le projet, utilisez la commande suivante :

```bash
make

Utilisation
1. Exécution du Programme C
Pour exécuter directement le programme compilé, utilisez la commande suivante :
./exec < fichier_entrée.dat


Format du fichier d'entrée : Chaque ligne doit être structurée comme suit :
identifiant;capacite;consommation

Il est parfois nécessaire d’utiliser la commande unzip pour décompresser les fichiers zip :
sudo apt install unzip

2. Script Bash
Le script script.sh est utilisé pour automatiser le traitement des fichiers CSV et l'intégration avec le programme C.
Commande d'utilisation:
./script.sh [FICHIER] [STATION] [CONSOMMATEUR] [ID_CENTRALE] [OPTIONS]

Description des arguments :
FICHIER : Nom du fichier .dat contenant les données.
STATION :
hvb : Station de haut voltage B
hva : Station de haut voltage A
lv : Station de faible voltage
CONSOMMATEUR :
comp : Entreprises
indiv : Particuliers
all : Particuliers et Entreprises
ID_CENTRALE : Identifiant optionnel d'une centrale (0 < x < n).
Options :
-h : Affiche un message d'aide et arrête l'exécution.
Exemple d'utilisation :
bash
Copier le code
./script.sh data.dat lv all

Fonctionnalités Principales
Insertion dans l'arbre AVL :
Les données sont insérées avec des rotations pour équilibrer l'arbre.
Gestion des doublons : les capacités et consommations sont additionnées.
Parcours infixe :
Les données sont affichées dans l'ordre croissant d'identifiants.
Exportation :
Les données AVL peuvent être sauvegardées dans un fichier CSV pour une analyse ultérieure.
Script Bash :
Automatise le traitement des fichiers d'entrée et gère les restrictions spécifiques (par exemple, certaines combinaisons STATION/CONSOMMATEUR sont interdites).
Tests et Exemples
Test de base
Créer un fichier d'entrée data.dat avec le contenu suivant :
Copier le code
1;500;300
2;600;400
3;400;200

Compiler et exécuter :
bash
Copier le code
make
./exec < data.dat

Automatisation avec le script Bash
bash
Copier le code
./script.sh data.dat lv comp

Nettoyage
Pour nettoyer les fichiers générés (exécutables, fichiers objets, etc.) :
bash
Copier le code
make clean

