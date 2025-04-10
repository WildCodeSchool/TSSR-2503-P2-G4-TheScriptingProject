#!/bin/bash

# mettre en fonction "pare-feu"
#boucle while
#afficher le statut du pare-feu
#SI dÉsactivÉ proposer d'activer--> si oui activation et retour au menu prÉcÉdent
#si activÉ poroposer de dÉsactiver ---> si oui dÉsactiver sinon revenir au menu prÉcÉdent
#Sinon revenir au menu prÉcÉdent



#fonction
pare_feu()
{

    #variables locales
    local statut
    local reponse
    local choix





    while true
    do

            #afficher le statut du pare-feu
            statut=$(ufw status | grep -o "actif\|inactif")
            echo "Statut du pare-feu : $statut"


        #proposer d'activer ou dÉsactiver le  pare-feu
        if [ "$statut" = "actif" ]; then
            echo "Voulez-vous désactiver le pare-feu ? (o/n)"
        
            read -p "Entrez votre choix : " reponse
                if [ "$reponse" = "o" ]; then
                        sudo ufw disable
                        echo "Pare-feu désactivé."
                    else
                    echo "Aucune modification effectuée."
                fi

        else
                    echo "Voulez-vous activer le pare-feu ? (o/n)"
                    # shellcheck disable=SC2162
                    read -p "Entrez votre choix : " reponse
                    if [ "$reponse" = "o" ]; then
                        sudo ufw enable
                        echo "Pare-feu activé."
                    else
                        echo "Aucune modification effectuée."
                    fi
        fi

                # Proposer de recommencer ou de quitter
                echo "Pour recommencer :1 "
                echo "Pour revenir au menu précédent : 2 "
           
                read -p "Entrez votre choix : " choix
                
                case "$choix" in
                    1) 
                        continue;; #remodifier le pare feu
                    2)
                        return;; #sortie
                    *)
                        return;; #sortie

                esac

    done

}