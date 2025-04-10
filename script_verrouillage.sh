#!/bin/bash

#fonction verrouillage
verrouillage()

{
    #variable locale
    local choix

    while true
    do

        echo " WARNING"
        echo " Le verrouillage de la machine est potentiellement "
        echo " irréversible si vous êtes en accès distant."

        echo " 1 - pour verrouiller" 


        echo "2 - pour déverrouiller"

        echo " R pour revenir au menu précédent"


        read -p "Entrez votre choix :   " choix

            case $choix in

                1) 
    
                    loginctl lock-session
                    echo "Session verrouillée"
                    return;;

                2)
                    loginctl unlock-session
                    echo "Session déverouillée"
                    return;;

                *)

                    return;;

            esac

    done
}