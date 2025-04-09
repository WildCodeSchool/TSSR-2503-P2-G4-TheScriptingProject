#!/bin/bash

#Fonctions

#On boucle tant que l'on ne fait pas Q

while true

do

    #on demande la cible et l'utilisateur?

    read -p "Quel est l'ordinateur cible  (ip )?" ip
    read -p "Quel est l'utilisateur cible (nom)?" user

    #on se connecte en SSH à la cible.

    sudo ssh "$user@$ip"
    #boucle avec utilisateur et ip constante
    while true

    do

    #On pose la question Utilisateur ou Disque & Répertoire ou Sécurité & réseaux ou Gestion système ou Quitter?
    echo "Quel est votre choix entre:"
    echo "1 - Utilisateur"
    echo "2 - Disque et répertoire"
    echo "3 - Sécurité et réseaux"
    echo "4 - Gestion système"
    echo "5 - Quitter"
    read -p "Votre reponse en chiffre:" menu_general

        #Si Utilisateur
        case $menu_general in
        1)

            #On pose la question compte, groupe, Droits d'accés ou historique ou Quitter?

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
                    echo "Quel est votre choix entre:"
                    echo "1 - Création de compte"
                    echo "2 - chagement de mot de passe"
                    echo "3 - Suppression de compte"
                    echo "4 - désactivation de compte"
                    echo "5 - quitter"
                    read -p "Quel est votre reponse en chiffre ?" menu_compte

                    case $menu_compte in
                        
                        # si Création de compte
                        1)

                        ;;

                        # si Changement de mot de passe
                        2)

                        ;;

                        # si Suppression de compte
                        3)

                        ;;

                        # Si Désactivation de compte
                        4)

                        ;;

                        # si Quitter
                        5)

                        ;;

                        # Si erreur de Saisie
                        *)
                        echo "Erreur de saisie"

                        ;;
                        esac
                ;;
                #Si Groupe
                2)
                

                    # On pose la question Ajout à un groupe d'adminstration ou ajout d'un groupe Local ou Sortie d'un groupe local ou Groupe d'appartance d'un utilisateur ou quitter
                    echo "Quel est votre choix entre:"
                    echo "1 - Ajout à un groupe d'administration"
                    echo "2 - Ajout à un groupe local"
                    echo "3 - Sortie d'un groupe local"
                    echo "4 - Groupe d'appartenance"
                    echo "5 - Quitter"
                    read -p "Quel est votre réponse en chiffre?" menu_groupe

                    case $menu_groupe in
                        #Si Ajoute à un groupe d'administration
                        1)

                        ;;

                        #Si Ajoute à un groupe Local
                        2)

                        ;;

                        #Si Sortie D'un groupe Local
                        3)

                        ;;
                        
                        #si Groupe d'appartenance
                        4)

                        ;;

                        #Si Quitter

                        5)

                        ;;

                        #Si erreur de Saisie
                        *)
                        echo "Erreur de saisie"

                        ;;

                        esac
                        
                ;;
                #Si Droits d'accés
                3)
                
                    # On pose la question Droits/permissions de l'utilisateur sur un dossier ou un fichier
                    echo " Quel est votre choix entre:"
                    echo "1 - Droit/permissions sur un dossier"
                    echo "2 - Droit/permissions sur un fichier"
                    echo "3 - Quitter"
                    read -p "Votre réponse en chiffre?" menu_droit_acces

                    case $menu_droit_acces in
                        # si droit/permissions sur un dossier
                        1)

                        ;;

                        # si droit/permissions sur un fichier
                        2)

                        ;;
                        
                        # si quitter
                        3)

                        ;;

                        # si erreur de saisie
                        *)
                        echo "Erreur de saisie"

                        ;;

                        esac
                ;;
                #si Historique
                4)
                
                    # On demande si l'utilisateur veut lire la date de dernière connexion d'un user, modif de mdp, consulter la liste des sessions ouverte et l'historique des commandes
                    echo "Quel est votre choix entre:"
                    echo "1 - Afficher la dernière connexion d'un utilisateur"
                    echo "2 - Afficher la derniière modification du mot de passe"
                    echo "3 - Afficher les sessions ouvertes par l'utilisateur"
                    echo "4 - afficher l'historique des commandes exécutées par l'utilisateur"
                    echo "5 - Quitter"
                    read -p "Votre reponse en chiffre?" menu_historique

                    case $menu_historique in

                        # si Affichage de la derniere connexion d'un utilisateur
                        1)

                        ;;

                        # si Affichage de la derniere modification du mot de passe
                        2)

                        ;;

                        # si Affichage des sessions ouvertes par l'utilisateur
                        3)

                        ;;

                        # si Affichage de l'historique des commandes exécitées par l'utilisateur
                        4)

                        ;;

                        # si quitter
                        5)

                        ;;

                        # si erreur de saisie
                        *)
                        echo "Erreur de saisie"

                        ;;

                        esac
                
                ;;

                #Si quitter
                5)
                ;;

                #si erreur de saisies
                *)
                echo "Erreur de saisie"

                ;;

                esac
        ;;
        
        2)
        #Si Disque et Repertoire

            #On pose la question Disque ou Repertoire ou  Quitter?
            echo "Quel est votre choix entre:"
            echo "1 - Disque"
            echo "2 - Repertoire"
            echo "3 - Quitter"
            read -p "Votre réponce en chiffre:" menu_disque_repertoire

            case $menu_disque_repertoire in
                
                #Si Disque
                1)
                    #On pose la question Nb de disque ou Partition ou Espace disque restant par Partition ou Nom et espace disque d'un dossier ou Liste des lecteurs monté ou quitter
                
                        #  Si Nb de Disque

                        # Si Partition

                        # Si Espace disque restant par partition

                        # Si Nom et espace disque d'un dossier 

                        # Si liste des lecteurs monté

                        # Si Quitter

                        # Else erreur

                ;;

                #Si Repertoire
                2)

                    # on pose la question Création de repertoire ou modification répertoire ou suppression de repertoire ou quitter

                        #si Création de de repertoire

                        #si modification répertoire

                        #suppression de repertoire 

                ;;

                #si quitter
                3)

                ;;

                #else erreur de saisie
                *)

                ;;

                esac
        ;;

        3)
        # Si Sécurité et réseaux

            #On pose le question Réseau ou Pare-Feu ou Gestion à distance ou quitter
            echo "quel est votre choix?"
            echo "1 - Réseau"
            echo "2 - Pare-feu"
            echo "3 - Gestion à distance"
            echo "4 - Quitter"
            read -p "votre reponse en chiffre:" menu_securite_reseaux

            case $menu_securite_reseaux in

                #si Réseau
                1)

                    #On pose la question Nb d'interface ou Adresse Ip ou Adresse MAC ou Listes des ports Ouverts ou Quitter

                        #Si Nb D'interface

                        #Si Adresse Ip de chaque interface

                        #Si Adresse Mac

                        #Si liste de ports ouverts

                        #Si Quitter

                        #Else erreur de saisie
                ;;

                #si Pare Feu
                2)

                    #On pose la question Statut ou Activation ou Désactivation ou quitter

                        #Si Statut du pare-feu

                        #Si Activation du pare-feu

                        #Si Désactivation du pare-feu

                        #Si Quitter

                        #else erreur de saisie
                ;;

                #Si Gestion à distance
                3)

                    #on pose la question Prise de main à distance ou Execution de script sur la machine distante

                        #Si Prise de main à distance

                        #Si Exécution de script sur la machine distante

                        #si quitter

                        #else erreur de saisie
                ;;

                #si quitter
                4)

                ;;
                #si erreur de saisie
                *)

                ;;

                esac

        ;;

        4)
        #Si Gestion syteme

            #on pose la question Logiciel ou système ou Journaux d'evenements ou quitter
            echo "Quel est votre choix entre:"
            echo "1 - Logiciel"
            echo "2 - Sytème"
            echo "3 - Journaux d'évenements"
            echo "4 - Quitter"
            read -p "Votre reponse en chiffre:" menu_gestion_syteme

            case $menu_gestion_syteme in
            
                #si logiciel
                1)

                ;;

                    #On pose la question Installation ou désinstallation

                        #si Installaition de Logiciel

                        #si Désinstallation de logiciel

                        #si quitter

                        #Else erreur de saisie

                #Si Systeme
                2)

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

                ;;
                
                #Si erreur ou des cas précedent.
                *)

                ;;

                esac

        ;;
        
        #Si quitter
        5)


        ;;
        #Si erreur ou autre choix.
        *)

        ;;

        esac
    
    

    #Quitter boucle fonction
    done

#Quitter ou boucler cible
done
