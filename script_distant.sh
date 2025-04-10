#!/bin/bash

#fonction script distant
#boucle while
#entrez le chemin du script à éxécuter
#verifier si script existe
#si oui
#vérifier ou rendre executable chmod
#lancer le script
#confirmer ok ou nok
#proposer nouveau script ou sortie
#sinon proposer d'entrer nouveau chemin ou return

script_distant()
{

    #variables locales
    local chemin
    local reponse
    local choix
    local erreur_script
    local valeur_sortie

    while true
    do

        #entrez le chemin du script à éxécuter
        # shellcheck disable=SC2162
        read -p "Entrez le chemin/nom du script : " chemin


        #verifier si script existe
        if ! [ -f "$chemin" ]; then

            echo "Aucun script détécté"
            echo "Pour entrer un nouveau chemin : 1 "
            echo "Pour revenir au menu précédent : 2 "
            
            read -p "Entrez votre choix : " reponse

            case $reponse in
                1)
                    continue;;
                2)
                    return;;
                *) 
                    echo "Choix invalide, retour au menu précédent"
                    return;; 

            esac    
    
        else 

            #rendre éxécutable et lancer script + si erreur
            chmod u+x "$chemin"
            erreur_script=$(bash "$chemin" 2>&1 >/dev/null)  #pour récupérer l"rreur et l'afficher après
            valeur_sortie=$?
            
            #pour vérifier l éxécution
                if [ $valeur_sortie -eq 0 ]; then

                    echo "Exécution du script effectuée"
                else
                    echo "Script non éxécuté "
                    echo " Erreur : $erreur_script"

                fi
        fi 

        echo "Essayer un autre script - 1 "
        echo "Revenir au menu précédent - 2 "
        # shellcheck disable=SC2162
        read -p "Entrez votre choix : " choix

        case $choix in

            1) 
                continue;;

            2) 
                return;;

            *) 
                echo "Choix invalide, retour au menu précédent" 
                return;;

        esac

    done
}
