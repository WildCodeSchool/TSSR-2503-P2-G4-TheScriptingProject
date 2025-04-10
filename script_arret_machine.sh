#!/bin/bash 

#Fonction shutdown
shutdown ()
{
    local eteindre #variable locale


    echo "Confirmez pour éteindre la machine"
    # shellcheck disable=SC2162
    read -p " 1 pour confirmer / 2 pour revenir au menu :  "    eteindre

        case $eteindre in

        1)
            echo "Arrêt de la machine en cours" 
            # shellcheck disable=SC2033
            sudo shutdown now;;
        2)

            return;;

        *)
            echo "Choix incorrect retour au menu précédent."
            return;;
    
        esac






}