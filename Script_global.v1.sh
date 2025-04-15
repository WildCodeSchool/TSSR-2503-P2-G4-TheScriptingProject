#!/bin/bash



#######################################################################################################################
#              Plan de script                                                                                         
######################################################################################################################
#
#            1) Déclaration de toutes les fonctions 
#            2) Déclaration de la fonction menu_admin qui sert a rappeler toutes les fonctions
#            2) Script sélection du client cible et connexion  --> lancement de la fonction admin_menu_dans ssh
#            
#######################################################################################################################


# A priori journalisation et gestion des fichiers log c'est à intégrer devant la commande ssh











###########################################################################################################
# Fichier avec les informations nécessaires pour SSH au format "ip:name:user"
#############################################################################################################

ID="fichier_ID.txt"  #doit etre dans le meme dossier que le script au bon format





#######################################################################################################################
#######################         1) DÉCLARATION DES FONCTIONS       ########################################################
#######################################################################################################################



    
        ###########################################################################################################################
        #AJOUT D'UTILISATEUR
        ###########################################################################################################################

        fonction-compte()

        {


            #variables locales
            local user


            while true; do
                read -p "Merci d'indiquer le nom d'utilisateur : " user
                # Vérification si l'utilisateur a bien été saisi
                if [ -z "$user" ]; then
                    echo "Merci d'entrer un nom d'utilisateur valide"
                    continue
                fi

                # Vérification si l'utilisateur existe déjà
                if grep -q "$user:" /etc/passwd; then
                    echo "L'utilisateur $user existe déjà."
                    continue
                fi
                break
            done
            
            # Tentative de création de l'utilisateur
            if sudo useradd "$user"; then
                echo "L'utilisateur $user a été créé avec succès !"
            fi
        }


        ###################################################################################################
        #GESTION DE MOT DE PASSE
        ###############################################################################################"

        fonction-mdpasse() 

        {

            #variables locales
            local user


            echo "Affichage des 15 derniers comptes crées"
            cut -d: -f1 /etc/passwd | tail -n 15
            
            while true; do
                #Choisir le compte pour lequel on souhaite changer le mot de passe
                read -p "Merci d'indiquer le compte pour lequel vous souhaitez changer le mot de passe : " user

                if [ -z "$user" ]; then
                    echo "Merci d'entrer un nom d'utilisateur valide"
                    continue
                fi

                if ! id "$user" &>/dev/null; then
                    echo "Merci d'entrer un nom d'utilisateur valide"
                    continue
                fi
                
                echo "Vous avez choisi le compte \"$user\"" && passwd "$user"
                break
            done
        }

        ################################################################################################
        #SUPPRESSION DE COMPTE
        ################################################################################################

        fonction-userdelete() 

        {

            #variables locales
            local user
            local confirmation


            echo "Affichage des 15 derniers comptes crées"
            cut -d: -f1 /etc/passwd | tail -n 15
            
            while true; do
                # Demande d'insertion/vérification du compte à supprimer
                read -p "Merci d'indiquer le nom d'utilisateur : " user

                # Vérifie si vide
                if [ -z "$user" ]; then
                    echo "Merci d'entrer un nom d'utilisateur valide"
                    continue
                fi

                # Vérifie si l'utilisateur existe
                if ! id "$user" &>/dev/null; then
                    echo "Le compte \"$user\" n'existe pas."
                    continue
                fi
                break
            done
            
            # Demande de confirmation
            echo "Vous avez choisi de supprimer le compte \"$user\", êtes-vous sûr ? -Oui/Non- "
            read confirmation

            case $confirmation in
                [Oo]ui|[Oo]UI)
                    deluser "$user"
                    echo "Le compte \"$user\" a bien été supprimé"
                    ;;
                [Nn]on|[Nn]ON)
                    echo "Suppression de compte annulée"
                    ;;
                *)
                    echo "Réponse invalide, suppression annulée"
                    ;;
            esac
        }


        ################################################################################################""
        #ACTIVATION/DÉSACTIVATION DE COMPTE
        #############################################################################################""""

        fonction-usershadow() 

        {
            #variables locales
             local user
             local choice


            echo "Affichage des 15 derniers comptes crées"
            cut -d: -f1 /etc/passwd | tail -n 15
            
            while true; do
                #Demande d'insertion/vérification du compte à activer/désactiver
                read -p "Merci d'indiquer le nom d'utilisateur : " user

                if [ -z "$user" ]; then
                    echo "Merci d'entrer un nom d'utilisateur valide"
                    continue
                fi

                # Vérifie si l'utilisateur existe
                if ! id "$user" &>/dev/null; then
                    echo "Le compte $user n'existe pas."
                    continue
                fi
                break
            done

            echo "1 - Activer un compte"
            echo "2 - Désactiver un compte"
            read -p "Choisissez une option 1-2 : " choice

            case $choice in
                1)
                    echo "Menu d'activation"
                    # Demande de confirmation
                    echo "Vous avez choisi d'activer le compte $user, êtes-vous sûr ? -Oui/Non-"
                    
                    #Ajout de la variable de confirmation du script activation
                    read confirmation 
                    case $confirmation in
                        [Oo]ui|[Oo]UI)
                            sudo passwd -u "$user"
                            echo "Le compte $user a bien été activé"
                            ;;
                        [Nn]on|[Nn]ON)
                            echo "Activation de compte annulée"
                            return 1
                            ;;
                        *)
                            echo "Réponse invalide, activation annulée"
                            return 1
                            ;;
                    esac
                    ;;
                2)
                    echo "Menu de désactivation"
                    # Demande de confirmation
                    echo "Vous avez choisi de désactiver le compte $user, êtes-vous sûr ? -Oui/Non-"
                    
                    #Ajout de la variable de confirmation du script désactivation
                    read confirmation 
                    case $confirmation in
                        [Oo]ui|[Oo]UI)
                            sudo passwd -l "$user"
                            echo "Le compte $user a bien été désactivé"
                            ;;
                        [Nn]on|[Nn]ON)
                            echo "Désactivation de compte annulée"
                            return 1
                            ;;
                        *)
                            echo "Réponse invalide, désactivation annulée"
                            return 1
                            ;;
                    esac
                    ;;
                *)
                    echo "Option invalide"
                    ;;
            esac
        }


        ###############################################################################################""
        #Demande d'ajout à un groupe d'administration
        ################################################################################################""

        fonction-addadmingroup() 

        {

            #variables locales
             local user
             local confirmation

            #On vérifie l'existence du compte
            read -p "Merci d'indiquer le nom d'utilisateur à upgrade : " user

            if [ -z "$user" ]; then
                echo "Le nom d'utilisateur n'existe pas"
                return 1
            fi 

            # Vérifie si l'utilisateur existe
            if ! id "$user" &>/dev/null; then
                echo "Le compte $user n'existe pas."
                return 1
            fi

            # Demande de confirmation
            echo "Vous avez choisi d'ajouter le compte $user au groupe administrateur, êtes-vous sûr ? -Oui/Non-"

            #Ajout de la variable de confirmation d'ajout au groupe administrateur
            read confirmation
            case $confirmation in
                [Oo]ui|[Oo]UI)
                    sudo usermod -aG sudo "$user"
                    echo "L'utilisateur $user a été ajouté au groupe administrateur"
                    ;;
                [Nn]on|[Nn]ON)
                    echo "Commande d'ajout dans le groupe administrateur annulée"
                    ;;
                *)
                    echo "Réponse invalide, sortie"
                    ;;
            esac
        }

        ###############################################################################################
        #Demande d'ajout à un groupe local
        ################################################################################################

        fonction-addlocalgroup() 

        {

            #variables locales
            local user
            local group
            local confirmation


            #On vérifie l'existence du compte
            read -p "Merci d'indiquer le nom d'utilisateur à upgrade : " user

            if [ -z "$user" ]; then
                echo "Le nom d'utilisateur n'existe pas"
                return 1
            fi

            # Vérifie si l'utilisateur existe
            if ! id "$user" &>/dev/null; then
                echo "Le compte $user n'existe pas."
                return 1
            fi

            read -p "Merci d'indiquer le nom du groupe local : " group
            
            if [ -z "$group" ]; then
                echo "Le nom du groupe n'a pas été spécifié"
                return 1
            fi

            # Vérifie si le groupe existe
            if ! grep -q "^$group:" /etc/group; then
                # Demande de confirmation pour créer le groupe
                echo "Le groupe $group n'existe pas. Voulez-vous le créer ? -Oui/Non-"
                read confirmation
                case $confirmation in
                    [Oo]ui|[Oo]UI)
                        sudo groupadd "$group"
                        echo "Le groupe $group a été créé."
                        ;;
                    [Nn]on|[Nn]ON)
                        echo "Commande de création de groupe annulée"
                        return 1
                        ;;
                    *)
                        echo "Réponse invalide, sortie"
                        return 1
                        ;;
                esac
            fi

            # Demande de confirmation pour ajouter l'utilisateur au groupe
            echo "Vous avez choisi d'ajouter le compte $user au groupe local $group, êtes-vous sûr ? -Oui/Non-"
            read confirmation
            case $confirmation in
                [Oo]ui|[Oo]UI)
                    sudo usermod -aG "$group" "$user"
                    echo "L'utilisateur $user a été ajouté au groupe $group"
                    ;;
                [Nn]on|[Nn]ON)
                    echo "Commande d'ajout dans le groupe local annulée"
                    ;;
                *)
                    echo "Réponse invalide, sortie"
                    ;;
            esac
        }


        ###########################################################################################
        #Demande d'exclusion à un groupe local
        #############################################################################################""

        fonction-exclusiongrouplocal() 

        {

            #variables locales
            local user
            local group
            local confirmation

            read -p "Merci d'indiquer le nom d'utilisateur à exclure : " user

            if [ -z "$user" ]; then
                echo "Le nom d'utilisateur n'existe pas"
                return 1
            fi

            # Vérifie si l'utilisateur existe
            if ! id "$user" &>/dev/null; then
                echo "Le compte $user n'existe pas."
                return 1
            fi
            
            read -p "Merci d'indiquer le nom du groupe local : " group

            #Vérifier l'existence du groupe local
            if [ -z "$group" ]; then
                echo "Le groupe n'a pas été spécifié"
                return 1
            fi
            
            # Vérifie si le groupe existe
            if ! grep -q "^$group:" /etc/group; then
                echo "Le groupe $group n'existe pas."
                return 1
            fi

            # Demande de confirmation d'exclusion
            echo "Vous avez choisi d'exclure le compte $user du groupe local $group, êtes-vous sûr ? -Oui/Non-"
            read confirmation
            case $confirmation in
                [Oo]ui|[Oo]UI)
                    sudo gpasswd -d "$user" "$group"
                    echo "L'utilisateur $user a été exclu du groupe $group"
                    ;;
                [Nn]on|[Nn]ON)
                    echo "Commande d'exclusion du groupe local annulée"
                    ;;
                *)
                    echo "Réponse invalide, sortie"
                    ;;
            esac
        }


        #########################################################################################
        #DROIT D'ACCES
        #########################################################################################

        #On veut modifier les droits d'accès de l'utilisateur sur un fichier ou un dossier.
        fonction-droits-acces() 

        {

            #variables locales
            local type
            local file
            local perms
            local folder


            

            # On demande s'il veut modifier un fichier ou un dossier
            read -p "Choisissez entre fichier et dossier : fichier/dossier " type

            # Si c'est un fichier
            if [ "$type" = "fichier" ]; then
                # On demande le nom du fichier
                read -p "Entrez le nom du fichier à modifier : " file

                # On vérifie si l'argument est bien un fichier
                if [ -f "$file" ]; then
                    # On demande quelle permission il veut ajouter
                    read -p "Quelle permission voulez-vous ajouter ? -ex: 777- : " perms
                    chmod "$perms" "$file"
                    
                    # On vérifie les changements de droits/permissions
                    ls -l "$file"
                else
                    echo "Le fichier $file n'existe pas"
                fi

            # Si c'est un dossier
            elif [ "$type" = "dossier" ]; then
                # On demande le nom du dossier
                read -p "Entrez le nom du dossier à modifier : " folder

                # On vérifie si l'argument est bien un dossier
                if [ -d "$folder" ]; then
                    # On demande quelle permission il veut ajouter
                    read -p "Quelle permission voulez-vous ajouter ? -ex: 777- : " perms
                    chmod "$perms" "$folder"
                    
                    # On vérifie les changements
                    ls -l "$folder"
                else
                    echo "Le dossier $folder n'existe pas"
                fi

            # Si la saisie est invalide
            else
                echo "Saisie invalide, veuillez choisir entre 'fichier' ou 'dossier'"
            fi
        }


        ###############################################################################################
        #dernières connexion d'un utilisateur
        ###############################################################################################

        fonction-lastconnexion() 

        {

            #variables locales
            local user


            read -p "Merci d'entrer le nom d'un utilisateur : " user

            #On vérifie si l'utilisateur existe bien
            if [ -z "$user" ]; then
                echo "L'utilisateur n'existe pas"
                return 1
            fi
            
            # Vérifie si l'utilisateur existe
            if ! id "$user" &>/dev/null; then
                echo "Le compte $user n'existe pas."
                return 1
            fi

            #On lance l'historique de connection
            last | grep  "$user" 
        }



        #############################################################################################
        #dernières modifications de mdp
        ##############################################################################################

        fonction-lastmdpmodif() 

        {

            #variables locales
            local user

            read -p "Merci d'entrer le nom d'un utilisateur : " user

            #On vérifie si l'utilisateur existe bien
            if [ -z "$user" ]; then
                echo "L'utilisateur n'existe pas"
                return 1
            fi
            
            # Vérifie si l'utilisateur existe
            if ! id "$user" &>/dev/null; then
                echo "Le compte $user n'existe pas."
                return 1
            fi

            #On lance l'historique de modification de mdp
            chage -l "$user"
        }


        ###############################################################################################
        #liste des sessions ouvertes par l'utilisateur
        ################################################################################################

        fonction-sessions-ouvertes() 

        {

            #variables locales
            local user

            read -p "Merci d'entrer le nom d'un utilisateur : " user

            #On vérifie si l'utilisateur existe bien
            if [ -z "$user" ]; then
                echo "L'utilisateur n'existe pas"
                return 1
            fi
            
            # Vérifie si l'utilisateur existe
            if ! id "$user" &>/dev/null; then
                echo "Le compte $user n'existe pas."
                return 1
            fi

            echo "Sessions ouvertes par l'utilisateur $user :"
            who | grep "^$user"
        }


        ##########################################################################################""
        #Lecture du fichier history
        ############################################################################################

        fonction-history() 

        {
            cat ~/.bash_history
        }



        ################################################################################################################""
        # fonction "Informations Réseau"
        ################################################################################################################""
        Informations_reseau()

        {
            

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


            
            #variables loclaes 
            local liste_interfaces
            local nb_interfaces
            local liste_ip
            local ports_ouverts
            local choix



            while true
                do

                #afficher le  nombre d"interfaces réseau (j'ai rajouté les noms pour faciliter la lecture des infos)
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


                
                #extraire et afficher les ip correspondantes
                if [ -n "$liste_ip" ]; then ###si la liste n'est pas vide 
                
                    echo "Adresses IP détectées :"
                    echo "$liste_ip" |awk '/inet / {print $2}' ###sélectionne les lignes commencant par inet, séparé par espace et imprime le 2eme element
                else 
                    echo "Aucune adresse IP détectée"

                fi 



                
                #filtrer et afficher les adresses mac
                if [ -n "$liste_interfaces" ]; then
                    echo "Adresses MAC détectées :"
                    echo "$liste_interfaces" |awk '/link/ {print $2}' ###ici pas d'espace après link
                else
                    echo "Pas d'adresse MAC détectée"
                fi

                
                #lister les ports ouverts 
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


            
                #Afficher le menu de boucle ou sortie
                
                echo "Voulez-vous : "
                echo "1 - Afficher à nouveau les informations"
                echo "2 - Revenir au menu précédent"
                read -p "Saisissez 1 ou 2 : "  choix



            
                #case pour recommencer (donc réafficher les informations, nouvelle boucle script) / ou revenir au menu précédent
            
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


        ############################################################################################################################
        #fonction pare-feu
        ##############################################################################################################################
        # mettre en fonction "pare-feu"
        #boucle while
        #afficher le statut du pare-feu
        #SI dÉsactivÉ proposer d'activer--> si oui activation et retour au menu prÉcÉdent
        #si activÉ poroposer de dÉsactiver ---> si oui dÉsactiver sinon revenir au menu prÉcÉdent
        #Sinon revenir au menu prÉcÉdent


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
                    echo "Voulez-vous désactiver le pare-feu ? -o/n- "
                
                    read -p "Entrez votre choix : " reponse
                        if [ "$reponse" = "o" ]; then
                                sudo ufw disable
                                echo "Pare-feu désactivé."
                            else
                            echo "Aucune modification effectuée."
                        fi

                else
                            echo "Voulez-vous activer le pare-feu ? -o/n- "
                           
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




        #############################################################################################################################
        #fonction gestion a distance
        #################################################################################################################################
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


        #######################################################################################################################################
        #fonction installation de logiciel
        ####################################################################################################################################""

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


        ###############################################################################################################################
        #fonction déseinstallation logiiel
        ###############################################################################################################################

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


        ###############################################################################################################################""
        #Fonction shutdown
        ###################################################################################################################################"

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


        ################################################################################################################################
        #fonction verrouillage
        ################################################################################################################################""

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
















########################################################################################################################################""
################    2) Déclaration de la fonction menu_admin qui sert a rappeler toutes les fonctions    ###############
#########################################################################################################################################

#fonction admin_menu
admin_menu ()

{

    
    #boucle avec utilisateur et ip constante
    while true; do
        #On pose la question Utilisateur ou Disque & Répertoire ou Sécurité & réseaux ou Gestion système ou Quitter?
        echo "Quel est votre choix entre:"
        echo "1 - Utilisateur"
        echo "2 - Disque et répertoire"
        echo "3 - Sécurité et réseaux"
        echo "4 - Gestion système"
        echo "5 - Quitter"
        read -p "Votre reponse en chiffre: " menu_general

        #Si Utilisateur
        case $menu_general in
            1)
                #On pose la question compte, groupe, Droits d'accés ou historique ou Quitter?
                while true; do
                    echo "Quel est votre choix entre:"
                    echo "1 - Compte"
                    echo "2 - Groupe"
                    echo "3 - Droits d'accés"
                    echo "4 - Historique"
                    echo "5 - Quitter"
                    read -p "Votre reponse en chiffre: " menu_utilisateur

                    case $menu_utilisateur in 
                        #Si Compte
                        1)
                            #lancement sous menu compte
                            #On pose la question Création de compte, Changement de mot de passe , Suppression de Compte , désactivation de compte ou quitter.
                            while true; do
                                echo "Quel est votre choix entre:"
                                echo "1 - Création de compte"
                                echo "2 - Changement de mot de passe"
                                echo "3 - Suppression de compte"
                                echo "4 - Désactivation de compte"
                                echo "5 - Quitter"
                                read -p "Quel est votre reponse en chiffre ? " menu_compte

                                case $menu_compte in
                                    # si Création de compte
                                    1) 
                                        fonction-compte
                                        echo "Interface création de compte lancé" 
                                    ;;

                                    # si Changement de mot de passe
                                    2)
                                        fonction-mdpasse
                                        echo "Interface de changement de mot de passe"
                                    ;;  

                                    # si Suppression de compte
                                    3)
                                        fonction-userdelete
                                        echo "Interface de suppression de compte"
                                    ;;

                                    # Si Désactivation de compte
                                    4)
                                        fonction-usershadow
                                        echo "Interface de desactivation de compte"
                                    ;;
                                    
                                    # si Quitter
                                    5)
                                        break
                                    ;;

                                    # Si erreur de Saisie
                                    *)
                                        echo "Erreur de saisie"
                                    ;;
                                esac
                            done
                        ;;
                        
                        #Si Groupe
                        2)
                            # On pose la question Ajout à un groupe d'adminstration ou ajout d'un groupe Local ou Sortie d'un groupe local ou Groupe d'appartance d'un utilisateur ou quitter
                            while true; do
                                echo "Quel est votre choix entre:"
                                echo "1 - Ajout à un groupe d'administration"
                                echo "2 - Ajout à un groupe local"
                                echo "3 - Sortie d'un groupe local"
                                echo "4 - Groupe d'appartenance"
                                echo "5 - Quitter"
                                read -p "Quel est votre réponse en chiffre? " menu_groupe

                                case $menu_groupe in
                                    #Si Ajoute à un groupe d'administration
                                    1) fonction-addadmingroup
                                    echo "Interface d'ajout au groupe d'admininistration"
                                    ;;

                                    #Si Ajoute à un groupe Local
                                    2) fonction-addlocalgroup
                                    echo "Interface d'ajout au groupe d'admininistration"
                                    ;;

                                    #Si Sortie D'un groupe Local
                                    3) fonction-exclusiongrouplocal
                                    echo "Interface d'exclusion d'un groupe local"
                                    ;;
                                    
                                    #si Groupe d'appartenance
                                    4)
                                    ;;

                                    #Si Quitter
                                    5)
                                        break
                                    ;;

                                    #Si erreur de Saisie
                                    *)
                                        echo "Erreur de saisie"
                                    ;;
                                esac
                            done
                        ;;
                        
                        #Si Droits d'accés
                        3)
                            # On pose la question Droits/permissions de l'utilisateur sur un dossier ou un fichier
                            while true; do
                                echo "Quel est votre choix entre:"
                                echo "1 - Droit/permissions sur un dossier ou fichier"
                                echo "2 - Quitter"
                                read -p "Votre réponse en chiffre? " menu_droit_acces

                                case $menu_droit_acces in
                                    # si droit/permissions sur un dossier
                                    1) fonction-droits-acces
                                    echo "Interface de modification de droits d'acces sur un dossier ou fichier"
                                    ;;
                                    
                                    # si quitter
                                    2)
                                        break
                                    ;;

                                    # si erreur de saisie
                                    *)
                                        echo "Erreur de saisie"
                                    ;;
                                esac
                            done
                        ;;
                        
                        #si Historique
                        4)
                            # On demande si l'utilisateur veut lire la date de dernière connexion d'un user, modif de mdp, consulter la liste des sessions ouverte et l'historique des commandes
                            while true; do
                                echo "Quel est votre choix entre:"
                                echo "1 - Afficher la dernière connexion d'un utilisateur"
                                echo "2 - Afficher la dernière modification du mot de passe"
                                echo "3 - Afficher les sessions ouvertes par l'utilisateur"
                                echo "4 - Afficher l'historique des commandes exécutées par l'utilisateur"
                                echo "5 - Quitter"
                                read -p "Votre reponse en chiffre? " menu_historique

                                case $menu_historique in
                                    # si Affichage de la derniere connexion d'un utilisateur
                                    1) fonction-lastconnexion
                                    ;;

                                    # si Affichage de la derniere modification du mot de passe
                                    2) fonction-lastmdpmodif
                                    ;;

                                    # si Affichage des sessions ouvertes par l'utilisateur
                                    3) fonction-sessions-ouvertes
                                    ;;

                                    # si Affichage de l'historique des commandes exécitées par l'utilisateur
                                    4) fonction-history
                                    ;;

                                    # si quitter
                                    5)
                                        break
                                    ;;

                                    # si erreur de saisie
                                    *)
                                        echo "Erreur de saisie"
                                    ;;
                                esac
                            done
                        ;;

                        #Si quitter
                        5)
                            break
                        ;;

                        #si erreur de saisies
                        *)
                            echo "Erreur de saisie"
                        ;;
                    esac
                done
            ;;
        
        2)
        #Si Disque et Repertoire

            #On pose la question Disque ou Repertoire ou  Quitter?
            while true
            do
            echo "Quel est votre choix entre:"
            echo "1 - Disque"
            echo "2 - Repertoire"
            echo "3 - Quitter"
            read -p "Votre réponce en chiffre:" menu_disque_repertoire

            case $menu_disque_repertoire in
                
                #Si Disque
                1)
                    #On pose la question Nb de disque ou Partition ou Espace disque restant par Partition ou Nom et espace disque d'un dossier ou Liste des lecteurs monté ou quitter
                    while true
                    do
                    echo "Quel est votre choix entre:"
                    echo "1 - Nombre de disque"
                    echo "2 - Partition"
                    echo "3 - Espace disque restant par partition/volume"
                    echo "4 - Nom et espace disque d'un dossier -nom de dossier demandé-"
                    echo "5 - Liste des lecteurs monté -disques, cd, etc...-"
                    echo "6 - Quitter"
                    read -p "Quel est votre réponse en chiffre: " menu_disque
                    case $menu_disque in
                
                        #  Si Nb de Disque
                        1)

                        ;;

                        # Si Partition
                        2)

                        ;;

                        # Si Espace disque restant par partition
                        3)

                        ;;

                        # Si Nom et espace disque d'un dossier
                        4)

                        ;; 

                        # Si liste des lecteurs monté
                        5)

                        ;;

                        # Si Quitter
                        6)
                        break
                        ;;

                        # Else erreur
                        *)
                        echo "erreur de saisie"

                        ;;

                        esac
                    done

                ;;

                #Si Repertoire
                2)

                    # on pose la question Création de repertoire ou modification répertoire ou suppression de repertoire ou quitter
                    while True
                    do
                    echo "1 - Création de répertoire"
                    echo "2 - Modification de répertoire"
                    echo "3 - Suppression de répertoire"
                    echo "4 - Quitter"
                    read -p "Quel est votre réponse en chiffre:" menu_repertoire

                    case $menu_repertoire in

                        #si Création de de repertoire
                        1)

                        ;;

                        #si modification répertoire
                        2)

                        ;;

                        #suppression de repertoire 
                        3)

                        ;;

                        #si quitter
                        4)
                        break
                        ;;

                        #si erreur de saisie
                        *)
                        echo "Erreur de saisie"
                        ;;

                        esac

                    done

                ;;

                #si quitter
                3)
                break
                ;;

                #else erreur de saisie
                *)
                echo "Erreur de saisie"
                ;;

                esac
            done
        ;;

        3)
        # Si Sécurité et réseaux

            #On pose le question Réseau ou Pare-Feu ou Gestion à distance ou quitter
            while true
            do
            echo "quel est votre choix?"
            echo "1 - Réseau"
            echo "2 - Pare-feu"
            echo "3 - Gestion à distance"
            echo "4 - Quitter"
            read -p "votre reponse en chiffre:" menu_securite_reseaux

            case $menu_securite_reseaux in

                #si Réseau
                1) Informations_reseau

                    #On pose la question Nb d'interface ou Adresse Ip ou Adresse MAC ou Listes des ports Ouverts ou Quitter

                        #Si Nb D'interface

                        #Si Adresse Ip de chaque interface

                        #Si Adresse Mac

                        #Si liste de ports ouverts

                        #Si Quitter

                        #Else erreur de saisie
                ;;

                #si Pare Feu
                2) pare_feu

                    #On pose la question Statut ou Activation ou Désactivation ou quitter

                        #Si Statut du pare-feu

                        #Si Activation du pare-feu

                        #Si Désactivation du pare-feu

                        #Si Quitter

                        #else erreur de saisie
                ;;

                #Si Gestion à distance
                3) script_distant

                    #on pose la question Prise de main à distance ou Execution de script sur la machine distante

                        #Si Prise de main à distance

                        #Si Exécution de script sur la machine distante

                        #si quitter

                        #else erreur de saisie
                ;;

                #si quitter
                4)
                break
                ;;

                #si erreur de saisie
                *)
                echo "Errreur de saisie"
                ;;

                esac
            done

        ;;

        4)
        #Si Gestion syteme

            #on pose la question Logiciel ou système ou Journaux d'evenements ou quitter
            while true
            do
            echo "Quel est votre choix entre:"
            echo "1 - Logiciel"
            echo "2 - Sytème"
            echo "3 - Journaux d'évenements"
            echo "4 - Quitter"
            read -p "Votre reponse en chiffre:" menu_gestion_syteme

            case $menu_gestion_syteme in
            
                #si logiciel
                1) 

                #On pose la question Installation ou désinstallation
                echo "Que voulez-vous faire ?"
                echo "1 - Installer un logiciel"
                echo "2 - Désinstaller un logiciel"
                echo "3 - Retour au menu gestion systeme"
                    read -p "Voulez-vous installer ou désinstaller un logiciel ? :" choix
                    case $choix in

                        #si Installaition de Logiciel
                        1) script_install
                        ;;
                        #si Désinstallation de logiciel
                        2) script_uninstall
                        ;;     
                        #si quitter
                        3) return
                        ;;
                    esac
                ;;
                #Si Systeme
                2) shutdown

                    #on pose la question Arrêt ou redémarrage ou Verouillage ou Version de l'Os ou MAJ du système ou quitter

                        # Si Arrêt

                        # Si redémarrage

                        # Si Vérouillage

                        # Si Version de l'os

                        # Si MAJ du Système 

                        #Si Quitter

                        #else erreur de saisie
                
                ;;

                #Si Journaux d'événements
                3) 

                    #on pose la question Evenement utilisateur ou evenement ordinateur ou quitter

                        #Si Evenement Utilisateur

                        #Si Evenement Ordinateur

                        #Si quitter

                        #else erreur de saisie
                ;;

                #Si Quitter
                4)
                break
                ;;
                
                #Si erreur ou des cas précedent.
                *)
                echo "Erreur de saisie"
                ;;

                esac
            done
        

        ;;
        
        #Si quitter
        5)
        break
        ;;
        #Si erreur ou autre choix.
        *)
        echo "Erreur de saisie"
        ;;
        esac
    
    
    #Quitter boucle fonction
    done



}


##########################################################################################################
#               3) Script sélection de cible et connexion SSH
#########################################################################################################"""



#Variables utilisées pour l'identification de la cible et connexion SSH#
# adresses=  IP dans fichier ID
# machine_name= nom des machines dans le fichier ID
# utiilisateur= user dans le fichier ID
# cibles_ID = Machine ip ou user trouvés après filtrage
# info_ID= couple ip/user utilisé pour conxexion ssh
# IP = IP utilisée pour ssh
# user = user utilisé pour ssh

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
        
        break 

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
             ip=$(echo "$cibles_ID" | awk -F':' "NR==$choix_ligne { print \$1 }")
            user=$(echo "$cibles_ID" | awk -F':' "NR==$choix_ligne { print \$3 }")


          

        else

            echo "Saisie incorrecte, retour au menu."
            read -n 1 -s -r -p "Appuyez sur une touche pour continuer..."
            
            continue 
        fi
            






    else  #si une seule ligne découper avec awk pour extraire IP et user et stocker dans 2 variables diofférentes

            ip=$(echo "$cibles_ID" | awk -F':' '{ print $1 }')
            user=$(echo "$cibles_ID" | awk -F':' '{ print $3 }')

      

           
    fi


    ######################################################################################################
    #Initialisation connexion SSH
    #####################################################################################################




#envoi d'admin menu dans la commande 
commande="$(printf '%q' "$(declare -f); admin_menu")"

#lancement connexion ssh
ssh -t "$user@$ip" "sudo bash -c $commande"


echo "Connection SSH terminée A bientôt!"   #  affiché quand on quitte le menu ce qui coupe la connexion ssh 


    
    #commande ssh qui permet de se connecter et d'éxécuter le script à distance
    #ssh -t permet d'éxécuter sur le client à distance et d'afficher les menus du admin_menu
    #mais tout doit être dans une fonction
    #$(declare -f admin_menu) initialise la fonction sur le client via la commande ssh
    #printf '%q' regle le probleme des caractères spéciaux et évite d'arreter le script
    #et ensuite le client peut donc éxécuter la fonction admin menu qui gère le script admin_menu


     # Vérifie le code de retour de la commande précédente
    if [ $? -eq 0 ]; then
        

        break  # Sort de la boucle while
        echo "Connection terminée"
    else
        echo "Échec connexion"
        echo "Retour au menu..."
        
        continue
    fi


    
   

done





