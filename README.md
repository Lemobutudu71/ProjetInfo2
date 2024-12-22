Projet d’informatique : Gestion des Stations Électriques

Ce projet utilise une structure de données AVL pour gérer des données relatives aux stations électriques, notamment leur capacité et leur consommation. Le projet inclut des outils pour insérer, parcourir, et exporter des données AVL.

Structure du Projet: 
Le répertoire contient les fichiers suivants :
-codeC/ : Répertoire contenant les fichiers C (main, AVL.c ) ainsi que le Makefile.
- c-wire.sh : Script shell pour traiter le fichiers CSV et intégrer l'exécutable.
-test/: Répertoire contenant les exemples d’exécution de notre application.
-tmp/: Répertoire censé contenir les résultats lors des prochaines exécutions.
-input / : Répertoire contenant le fichier csv à trier.
-RAEDME.md:  C’est le fichier que vous êtes en train de lire et qui explique le fonctionnement et l’utilisation du code.
-Rapport projet c-wire.pdf: Rapport détaillant  la répartition des tâches au sein du groupe, le planning de réalisation, et les limitations fonctionnelles de votre application 

Prérequis

Assurez-vous que les éléments suivants sont installés sur votre système :
- `gcc` (compilateur C)
- `make` (outil de build)
- Bash (pour exécuter le script shell)

Utilisation du programme
1.Téléchargez le dépôt git sur votre ordinateur. (Il est parfois nécessaire d’utiliser la commande unzip pour décompresser les fichiers zip )

2.Placez le fichier c-wire_v25.dat dans le répertoire ‘input’ .

3.Accédez au répertoire du Projet : cd ProjetInfo2 

4.Mettre à jour les autorisations : chmod +x c-wire.sh  (si vous rencontrez d’autres accès refusé : chmod +x cheminDufichier/fichier )

5.Exécutez le script : ./c-wire.sh input/<csv_file> <type_station> <type_consommateur> [centrale_id]

6.Exemple d’execution : 
 ./c-wire.sh input/c-wire_v25.dat hvb comp 
 ./c-wire.sh input/c-wire_v25.dat hva comp 
 ./c-wire.sh input/c-wire_v25.dat lv all
 
7.Les fichiers seront disponibles dans le répertoires tmp.

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
Options :
ID_CENTRALE : Identifiant optionnel d'une centrale (0 < x < n).
-h : Affiche un message d'aide et arrête l'exécution.





