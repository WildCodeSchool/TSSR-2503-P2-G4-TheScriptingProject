#!/bin/bash

############################################################################################################
# VARIABLES UTILISÉES DANS LE SQUELETTE
#############################################################################################################
#
# menu_général 
# menu_utilisateur
# menu_compte
# menu_groupe
# menu_droit_acces
# menu_historique
# menu_disque_repertoire
# menu_disque
# menu_securite_reseau
# menu_getion_systeme


###########################################################################################################
# Fichier avec les informations nécessaires pour SSH au format "ip:name:user"
#############################################################################################################

ID="fichier_ID.txt"  




##########################################################################################################
#ici la partie pour la journalisation et log
########################################################################################################

#apparament sous cette forme mais à modifier, vérifier les permissions etc....

# Chemin du fichier de log
#LOG_FILE=

# Initialiser le fichier de log
#touch "$LOG_FILE" 2>/dev/null || {
#   echo "Erreur : Impossible de créer le fichier de log $LOG_FILE."
#   exit 1
#}

# Fonction pour journaliser
#log() 
#{
#    local timestamp
#   timestamp=$(date '+%Y-%m-%d %H:%M:%S')
#    echo "[$timestamp] $1" >> "$LOG_FILE"
#}

# Test de la journalisation
#log "Initialisation du script"


##########################################################################################################
#ici le menu d'administration groupé DANS UNE FONCTION "admin_menu" qui contient TOUTES les autres fonctions
# qui seront éxécutées sur le client..
##########################################################################################################

#admin_menu()
#{

# while true                         ########ICI DÉBUT DU SQUELETTE DEJÀ FAIT##########
# do
#
#    echo "1 - Utilisateur"
#    echo "2 - Disque et répertoire"
#    echo "3 - Sécurité et réseaux"
#    echo "4 - Gestion système"
#    echo "5 - Quitter"
#    read -p "Votre reponse en chiffre:" menu_general        


#       case $menu_general in

#       1)

#      et ici lister tout le reste du squelette et faire apparaitre chaque fonction





##########################################################################################################
#Début de script principal pour récupérer IP et USER nécessaires pour SSH
#########################################################################################################"""


#########################################################################################################
#Variables utilisées pour l'identification de la cible et connexion SSH
#########################################################################################################""
#
# adresses=  IP dans fichier ID
# machine_name= nom des machines dans le fichier ID
# utiilisateur= user dans le fichier ID
# cibles_ID = Machine ip ou user trouvés après filtrage
# info_ID= couple ip/user utilisé pour conxexion ssh
# IP = IP utilisée pour ssh
# user = user utilisé pour ssh
######################################################################################################




# Lire le fichier ligne par ligne
#afficher les lignes qui contiennent la saisie utilisateur
#proposer choix si plusieurs 1 ou 2 etc
#si pas de correspondance retour au menu
# découper pour récuper IP et USER pour ssh



while true
do

    echo " "
    echo " "
    echo "Bienvenue dans votre utilitaire de gestion"
    echo " "
    echo "Choisissez :" 
    echo "1 - Pour entrer une info : IP, nom de machine nom d'utilisateur"
    echo "2 - Pour quitter"
    read -p "Saisissez votre choix ici : " cibles

    #réinitaliser les variables
    choix=""
    info_ID=""
    cibles_ID=""
    ip=""
    user=""


   
    #  si choix 1, sinon retour au menu
    if [ "$cibles" = "1" ]; then
  

        # récupérer saisi utilisateur
        read -p "Entrez une info : IP, Nom de machine ou nom d'utilisateur) : " choix

        # Filtrer choix avec grep dans fichier.ID et enregistrer dans cibles_id le retour de grep
        cibles_ID=$(grep -i "$choix" "$ID")

    elif [ "$cibles" = "2" ];then

        #si choix 2 quitter sortir du script
        
        echo "Vous avez demandé à sortir du programme"
        
        exit 0

    else
            
            echo "Saisie incorrecte retour au menu"

            exit 0


    fi

    # Si pas de correspondance, retour au menu
    if [ -z "$cibles_ID" ]; then
        echo "Aucun résultat pour votre entrée"
        continue
    
    else
        # Afficher les cibles trouvées
        echo "Les cibles trouvées :"
        echo "$cibles_ID" | nl -w1 -s" - "
    fi    

    # Compter les lignes wc
    nbdelignes=$(echo "$cibles_ID" | wc -l)

    
    # si plus de 1 ligne
    if [ "$nbdelignes" -gt 1 ]; then

        
        read -p "Choisissez un numéro (1-$nbdelignes) : " choix_ligne

        #pour valider le choixil faut
        #unnombre et
        #supérieur a 1 et
        # inférieur ou égal à $nbdeligne
        if [[ $choix_ligne =~ ^[0-9]+$ ]] && [ "$choix_ligne" -ge 1 ] && [ "$choix_ligne" -le "$nbdelignes" ]; then
        
            #afficher la ligne choisie mais pas $choixligne qui est un némero-> $cibles_ID
            #avec echo et l'envoye
            # dans un pipe pour traitementavec awk
            # découper format ip:name:user avec awk pour extraire IP et user et srtocker dans 2 variables différentes
             IP=$(echo "$cibles_ID" | awk -F':' "NR==$choix_ligne {print \$1}")
            user=$(echo "$cibles_ID" | awk -F':' "NR==$choix_ligne {print \$3}")

        else

            echo "Saisie incorrecte, retour au menu."
            read -n 1 -s -r -p "Appuyez sur une touche pour continuer..."
            
            continue 
        fi
            






    else  #si une seule ligne découper avec awk pour extraire IP et user et stocker dans 2 variables diofférentes

            IP=$(echo "$cibles_ID" | awk -F':' '{print $1}')
            user=$(echo "$cibles_ID" | awk -F':' '{print $3}')

           
    fi


    ######################################################################################################
    #Initialisation connexion SSH
    #####################################################################################################


#si IP et USER non vides
#associer au format "ssh $user@IP"
#lancer la connexion

    if [ -n "$IP" ] && [ -n "$user"];then

    echo "Connection en cours..."
    
    #commande ssh qui permet de se connecter et d'éxécuter le script à distance
    ssh -t "$user@$ip" "$(declare -f admin_menu); admin_menu" 2>&1 

    # cette commande ssh -t permet d'éxécuter sur le client à distance et d'afficher les menus du admin_menu
    #mais tout doit être dans une fonction
    #$(declare -f admin_menu) initialise la fonction sur le client via la commande ssh
    #et ensuite le client peut donc éxécuter la fonction admin menu qui gère le script admin_menu



    

    else

    echo "Manque information IP ou utilisateur veuillez vérfier fichier_ID.txt"

done





    




































   


