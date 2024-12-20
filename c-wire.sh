#!/bin/bash

for arg in "$@"; do
    if [ "$arg" == "-h" ]; then
    echo "Usage: $0[FICHIER][STATION][CONSOMMATEUR][ID CENTRALE][OPTIONS]" 
    echo "Fichier :"
    echo "   Fichier .dat existant requis"
    echo "Station :"
    echo -e " Type de station:\n   hvb : Station de haut voltage B\n   hva : Station de haut voltage A\n   lv : Station de faible voltage"
    echo "Consommateur :"
    echo -e " Type de consommateur:\n   comp : Entreprises\n   indiv : Particuliers\n   all : Particuliers et Entreprises\n  "
    echo "Id Centrale :"
    echo -e "   Indiquer un identifiant de centrale, l'option est optionnelle et doit être un numéro x compris entre 0<x<n où n est le nombre de centrale."
    echo "Restrictions:"
    echo -e "  hvb all' et 'hvb indiv' sont interdits."
    echo -e "  hva all' et 'hva indiv' sont interdits."
    echo "Options :"
    echo -e " -h  Affiche le message d'aide et arrête l'exécution"
  fi
done

verifier_arguments() {
    echo "Arguments reçus : $@"

    if [ $# -lt 3 ]; then  # Vérification que les trois options obligatoires sont présentes
        echo "Erreur : Pas assez d'arguments fournis."
        echo "Temps : 0 sec"
        exit 1
    fi

    if [ ! -f "$1" ]; then  # Vérification que le fichier existe
        echo "Erreur : Le fichier '$1' n'existe pas."
        echo "Temps : 0 sec"
        exit 1
    elif [ ! -s "$1" ]; then  # Vérification que le fichier n'est pas vide
        echo "Erreur : Le fichier '$1' est vide."
        echo "Temps : 0 sec"
        exit 1
    fi

    if [ "$2" != "hva" ] && [ "$2" != "hvb" ] && [ "$2" != "lv" ]; then
        echo "Erreur : Les stations à traiter sont : hvb ; hva ; lv"
        echo "Temps : 0 sec"
        exit 1
    fi

    if [ "$3" != "comp" ] && [ "$3" != "indiv" ] && [ "$3" != "all" ]; then
        echo "Erreur : Les consommateurs à traiter sont : comp ; indiv ; all"
        echo "Temps : 0 sec"
        exit 1
    fi

    case "$2 $3" in
        "hvb all" | "hvb indiv")
            echo "Erreur : 'hvb all' et 'hvb indiv' sont interdits."
            exit 1
            ;;
        "hva all" | "hva indiv")
            echo "Erreur : 'hva all' et 'hva indiv' sont interdits."
            exit 1
            ;;
    esac

    if ! [[ "$4" =~ ^[1-5]+$ ]] && [ -n "$4" ]; then
        echo "Erreur : Mauvais identifiant de centrale."
        echo "Temps : 0 sec"
        exit 1
    fi
}


FICHIER_CSV=$1      # Fichier CSV
TYPE_STATION=$2     # Type de station (hvb, hva, lv)
TYPE_CONSOMMATEUR=$3  # Type de consommateur (comp, indiv, all)
CENTRALE_ID=${4:-"[^-]+"} #Identifiant centrale

verifier_Executable() {
    if [ ! -f ./codeC/exec ]; then  # Vérifie si l'exécutable 'exec' existe
        echo "Compilation en cours..."
        make -C codeC exec || { echo "Erreur de compilation"; exit 1; } # Lance la compilation avec 'make'
    fi
    echo "Programme C compilé sans erreurs."
}

creer_dossier() {
	rm -rf "./tmp/" "./graphs/"
	for dossier in "tmp" "test" "graphs"; do
    	# Vérifier si le dossier temporaire existe, sinon le créer. Sinon, le vider
	    	if [ ! -d "$dossier" ] ; then
	    	    mkdir "$dossier"
	    	fi
	    done
    echo "Tmp, test et graphs sont créés" 
}

tri_fichier(){ #fonction pour trier le fichier .csv
case "$TYPE_STATION" in
    'hvb')  grep -E "^$CENTRALE_ID;[^-]+;-;-;-;-;[^-]+;-$" "$FICHIER_CSV" | cut -d ";" -f2,7,8 | tr "-" "0" > "./tmp/hvb_comp_input.csv" &&
            grep -E "^$CENTRALE_ID;[^-]+;-;-;[^-]+;-;-;[^-]+$" "$FICHIER_CSV" | cut -d ";" -f2,7,8 | tr "-" "0" >> "./tmp/hvb_comp_input.csv"
    ;;
    'hva') grep -E "^$CENTRALE_ID;[^-]+;[^-]+;-;-;-;[^-]+;-$" "$FICHIER_CSV" | cut -d ";" -f3,7,8 | tr "-" "0" > "./tmp/hva_comp_input.csv" &&
           grep -E "^$CENTRALE_ID;-;[^-]+;-;[^-]+;-;-;[^-]+$" "$FICHIER_CSV" | cut -d ";" -f3,7,8 | tr "-" "0" >> "./tmp/hva_comp_input.csv"
    ;;
    'lv') case "$TYPE_CONSOMMATEUR" in 
            'comp') grep -E "$CENTRALE_ID;-;[^-]+;[^-]+;-;-;[^-]+;-$" "$FICHIER_CSV" | cut -d ";" -f4,7,8 | tr "-" "0" > "./tmp/lv_comp_input.csv" &&
                    grep -E "$CENTRALE_ID;-;-;[^-]+;[^-]+;-;-;[^-]+$" "$FICHIER_CSV" | cut -d ";" -f4,7,8 | tr "-" "0" >> "./tmp/lv_comp_input.csv"
            ;;
            'indiv') grep -E "$CENTRALE_ID;-;[^-]+;[^-]+;-;-;[^-]+;-$" "$FICHIER_CSV" | cut -d ";" -f4,7,8 | tr "-" "0" > "./tmp/lv_indiv_input.csv" &&
                    grep -E "$CENTRALE_ID;-;-;[^-]+;-;[^-]+;-;[^-]+$" "$FICHIER_CSV" | cut -d ";" -f4,7,8 | tr "-" "0" >> "./tmp/lv_indiv_input.csv"
            ;;
            'all') grep -E "$CENTRALE_ID;-;[^-]+;[^-]+;-;-;[^-]+;-$" "$FICHIER_CSV" | cut -d ";" -f4,7,8 | tr "-" "0" > "./tmp/lv_all_input.csv" &&
            grep -E "$CENTRALE_ID;-;-;[^-]+;[^-]+;-;-;[^-]+$" "$FICHIER_CSV" | cut -d ";" -f4,7,8 | tr "-" "0" >> "./tmp/lv_all_input.csv" &&
            grep -E "$CENTRALE_ID;-;-;[^-]+;-;[^-]+;-;[^-]+$" "$FICHIER_CSV" | cut -d ";" -f4,7,8 | tr "-" "0" >> "./tmp/lv_all_input.csv"

            ;;
            *) echo "Erreur d'argument lv"
                exit 1
            ;;
        esac
    ;;
    *) echo "Erreur d'argument"
        exit 1
    ;;
esac
}

executer_programme(){ #fonction pour envoyer le fichier input.csv dans le programme c et recupérer le fichier de sortie
    if [ ${CENTRALE_ID} = "[^-]+" ]; then
        (./codeC/exec < ./tmp/${TYPE_STATION}_${TYPE_CONSOMMATEUR}_input.csv) \
            | sort -t ":" -k2,2n \
            | sed "1s/^/Station: Capacite: Consomation ${TYPE_CONSOMMATEUR}\n/" \
            > ./tmp/${TYPE_STATION}_${TYPE_CONSOMMATEUR}.csv
            
    else
        (./codeC/exec < ./tmp/${TYPE_STATION}_${TYPE_CONSOMMATEUR}_input.csv) \
            | sort -t ":" -k2,2n \
            | sed "1s/^/Station: Capacite: Consomation ${TYPE_CONSOMMATEUR}\n/" \
            > ./tmp/${TYPE_STATION}_${TYPE_CONSOMMATEUR}_${CENTRALE_ID}.csv
           
    fi
}


# function to create the top 10 and bottom 10 consumers of the LV station
creer_lvallminmax() {
    if [ ${CENTRALE_ID} = "[^-]+" ]; then
       
        tail -n +2 "./tmp/lv_all.csv" | awk -F: '{print $0 ":" ($2 - $3)}' | sort -t ":" -k4n | (head -n 10; tail -n 10) >> "./tmp/lv_all_minmax.csv"
    else
        
        tail -n +2 "./tmp/lv_all_${CENTRALE_ID}.csv" | awk -F: '{print $0 ":" ($2 - $3)}' | sort -t ":" -k4n | (head -n 10; tail -n 10) >> "./tmp/lv_all_minmax.csv"
    fi 
}

# Appel des fonctions
verifier_arguments "$@"
creer_dossier
verifier_Executable
debut=$(date +%s)
tri_fichier
executer_programme
if [[ ${TYPE_STATION} = 'lv' && ${TYPE_CONSOMMATEUR} = 'all' ]]; then
creer_lvallminmax
fi
fin=$(date +%s.%N)
duree=$(echo "$fin - $debut" | bc)
echo "Programme executé en $duree sec."
