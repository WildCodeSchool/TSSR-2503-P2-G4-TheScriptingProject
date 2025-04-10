#!/bin/bash




#fonction script_uninstall

script_uninstall()
{

    #variables locales
    local logiciel
    local verif
    local choix

    while true
    do

        #récupérer le nom du logiciel
        read -p "Entrez le nom exact du logiciel à désinstaller:  " logiciel

        #verifier si deja installé branche

         presence=$(find /usr/bin /bin /usr/local/bin /snap/bin -type f -executable -name "$logiciel" 2>/dev/null)


        if [ -n "$presence" ] && [  -n "$logiciel" ] ; then  #si existant et entrée non nulle

            echo "Désinstallation en cours"
            sudo apt purge "$logiciel" -y 2> erreur.txt
         

            verif=$?
            if [ "$verif" -eq 0 ]; then
        
                echo "Désinstallation terminée"
           
        
                else      

                echo " La désinstallation a échouée "
                cat erreur.txt
                
            fi

            rm -f erreur.txt

        
        
    
        else
 
            echo " Programme non détecté ou saisie vide."
        
        fi



    echo "Pour Désinstaller un nouveau programme : 1"
    echo "Pour revenir au menu précédent : 2 "
    read -p "Entree votre choix :  " choix

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

