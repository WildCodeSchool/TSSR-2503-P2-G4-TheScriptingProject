#!/bin/bash

#fonction reboot
reboot()


{

    #variable locale
    local choix
    

    read -p "Pour redémarrer la machine appuyez sur une touche+entrée ou, R pour revenir au menu précédent "  choix

    case $choix in
    
        R)
            return;;

        *)
            echo "Redémarrage demandé"
            sudo reboot;;

    esac


    
}