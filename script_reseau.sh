#!/bin/bash

#sécurité et réseau
#partie réseau
#suppose qu'on est déjà connecté à la machine en ssh et dans la ligne de commande



# établir la fonction "Informations Réseau"
#boucle de script while
#extraire et afficher le  nombre d"interfaces réseau (j'ai rajouté les noms pour faciliter la lecture des infos)
#extraire et afficher les adresse ip correspondantes aux interfaces listés
#extraire et afficher les adresses mac
#extraire et afficher la liste des ports ouverts
#afficher le menu de boucle ou sortie avec case
#case pour recommencer (donc réafficher les informations, nouvelle boucle script) / ou revenir au menu précédent


################################################################################################################""
# établir la fonction "Informations Réseau"
################################################################################################################""
Informations_reseau()
{


###################################################################################################################
#variables locales
###################################################################################################################

    local liste_interfaces
    local nb_interfaces
    local liste_ip
    local ports_ouverts
    local choix

##############################################################################################
#boucle de script while
##############################################################################################
    while true
    do

##########################################################################################
#afficher le  nombre d"interfaces réseau (j'ai rajouté les noms pour faciliter la lecture des infos)
#########################################################################################

        liste_interfaces=$(ip link show)

        #si les nombre d interfaces n'est pas vide
        if [ -n "$liste_interfaces" ]; then

            #extraire le nombre de ligne commencant par un chiffre et ":" et afficher le nombre de lignes
            #inclure ce résultat dans une variable pour l'afficher dans une réponse
        
            nb_interfaces=$(echo "$liste_interfaces" | awk -F: '/^[0-9]+:/ {print $1}' | wc -l) ### définit le délimiteur par ":" et filtre les lignes qui commencent (^) par 1nombre ou + et imprime le 1er champ ->et compte le résultat
            echo "Nombre d'interfaces réseau détectées : $nb_interfaces"
        else 
            echo "Nombre d'interfaces réseau détectées : 0"
        fi

            #afficher les nom des interfaces réseau correspondants
            liste_ip=$(ip a)

        if [ -n "$liste_ip" ]; then
            echo "Interfaces réseau détectées :"
            echo "$liste_ip" |awk -F: '/^[0-9]+:/ {print $2}' ### idem mais filtre le champ 2
            #autrement afficher "Aucune interface réseau détectée"
        else 
            echo "Aucune interface réseau détectée"
        fi



        #####################################################################################################
        #extraire et afficher les ip correspondantes
        ####################################################################################################

        if [ -n "$liste_ip" ]; then ###si la liste n'est pas vide 
        
            echo "Adresses IP détectées :"
            echo "$liste_ip" |awk '/inet / {print $2}' ###sélectionne les lignes commencant par inet, séparé par espace et imprime le 2eme element
        else 
            echo "Aucune adresse IP détectée"

        fi 



        #######################################################################################################
        #filtrer et afficher les adresses mac
        ######################################################################################################

        if [ -n "$liste_interfaces" ]; then
            echo "Adresses MAC détectées :"
            echo "$liste_interfaces" |awk '/link/ {print $2}' ###ici pas d'espace après link
        else
            echo "Pas d'adresse MAC détectée"
        fi



        ################################################################################################################
        #lister les ports ouverts 
        ###############################################################################################################

        #il faut mettre dans une variable :interroger la liste des ports : ss -tuln #extraire les ports - couper la ligne d'entête 
        #et conserver que la première information derrière les 2 points
        #si il y a quelquechose
        ports_ouverts=$(ss -tuln | tail -n +2 |awk '{sub(/.*:/, "", $5);print $5}' | sort -u)  ##envoi pipe--> commence à partir de la ligne 2 --> 
        # --> awk supprime tout ce qu il y a avant $5  et garde chaine vide donc garde que le numéro de port --> "sort" classe en suprimant les doublons.

        #afficher "Liste des ports ouverts :"
        # afficher les ports ouvert
        #si rien dans la sortie : afficher "Aucun port ouvert détecté"

        if [ -n "$ports_ouverts" ]; then #vérifie liste des ports non vide
        
            echo "Liste des ports ouverts: "
            echo "$ports_ouverts"  
        else 
            echo "Aucun port ouvert détecté"
        fi 


        #######################################################################################################################
        #Afficher le menu de boucle ou sortie
        #####################################################################################################################

        echo "Voulez-vous : "
        echo "1) Afficher à nouveau les informations"
        echo "2) Revenir au menu précédent"
        read -p "Saisissez 1 ou 2 : "  choix



        ############################################################################################################################
        #case pour recommencer (donc réafficher les informations, nouvelle boucle script) / ou revenir au menu précédent
        ###########################################################################################################################

        case $choix in
            1)
                continue;;
            2)
                return;;
            *)  echo "Choix invalide retour au menu précédent"  #pour toute autre touche
            
            return;;  #pour revenir au menu
        

        esac    






    done

}









































































































