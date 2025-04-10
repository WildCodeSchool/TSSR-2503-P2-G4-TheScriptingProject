#!/bin/bash




#fonction script_install

script_install()
{
    #variables locales
    local logiciel
    local presence
    local retour
    local choix
    
  

    while true
    do

        #récupérer le nom du logiciel
        read -p "Entrez le nom exact du logiciel à installer :  " logiciel

        #verifier si deja installé branche

        
         presence=$(find /usr/bin /bin /usr/local/bin /snap/bin -type f -executable -name "$logiciel" 2>/dev/null)


        if [ -z "$presence" ] && [ ! -z "$logiciel" ]; then  #si existe pas et entrée non nulle

            echo "Installation en cours"
            sudo apt update && sudo apt install "$logiciel" -y 2> erreur.txt

            retour=$?
            if [ "$retour" -eq 0 ]; then
        
                echo "Installation terminée"
           
        
                else      

                echo " L'installation a échouée "
                
            fi


        
        
    
        else

            echo " Programme déjà présent ou saisie vide."
        
        fi



    echo "Pour installer un nouveau programme : 1"
    echo "Pour revenir au menu précédent : 2 "
    read -p "Entrez votre choix :  " choix

    case $choix in 
            1) 
                continue;;
            2)
                return;;
            *)
                return;;

    esac

done
}








