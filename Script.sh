#!/bin/bash

#On boucle tant que l'on ne fait pas Q

#On pose la question Utilisateur ou Disque & Répertoire ou Sécurité & réseaux ou Gestion système ou Quitter?

    #Si Utilisateur

        #On pose la question compte, groupe, Droits d'accés ou historique ou Quitter?
            
            #Si Compte
            
                #On pose la question Création de compte, Changement de mot de passe , Suppression de Compte , désactivation de compte

                    # si Création de compte

                    # si Changement de mot de passe

                    # si Suppression de compte

                    # Si Désactivation de compte

                    # si Quitter

                    # Si erreur de Saisie
            
            #Si Groupe
            
                # On pose la question Ajout à un groupe d'adminstration ou ajout d'un groupe Local ou Sortie d'un groupe local ou Groupe d'appartance d'un utilisateur ou quitter

                    #Si Ajoute à un groupe d'adminisatration

                    #Si Ajoute à un groupe Local
                    
                    #Si Sortie D'un groupe Local
                    
                    #si Groupe d'appartenance

                    #Si Quitter

                    #Si erreur de Saisie
                    
                    
            #Si Droits d'accés
            
                # On pose la question Droits/permissions de l'utilisateur sur un dossier ou un fichier

                    # si droit/permissions sur un dossier

                    # si droit/permissions sur un fichier
                    
                    # si quitter

                    # si erreur de saisie
            
            #si Historique
            
                # On demande si l'utilisateur veut lire la date de dernière connexion d'un user, modif de mdp, consulter la liste des sessions ouverte et l'historique des commandes
                    
                    # si Affichage de la derniere connexion d'un utilisateur

                    # si Affichage de la derniere modification du mot de passe

                    # si Affichage des sessions ouvertes par l'utilisateur

                    # si Affichage de l'historique des commandes exécitées par l'utilisateur

                    # si quitter

                    # si erreur de saisie

            #Si erreur ou des cas précedent.

            #else 

    #Si Disque et Repertoire

        #On pose la question Disque ou Repertoire ou  Quitter?
            
            #Si Disque
            
                #On pose la question Nb de disque ou Partition ou Espace disque restant par Partition ou Nom et espace disque d'un dossier ou Liste des lecteurs monté ou quitter
            
                    #  Si Nb de Disque

                    # Si Partition

                    # Si Espace disque restant par partition

                    # Si Nom et espace disque d'un dossier 

                    # Si liste des lecteurs monté

                    # Si Quitter

                    # Else erreur

            #Si Repertoire

                # on pose la question Création de repertoire ou modification répertoire ou suppression de repertoire ou quitter

                    #si Création de de repertoire

                    #si modification répertoire

                    #suppression de repertoire 

                    #si quitter

                    #else erreur de saisie
    
    # Si Sécurité et réseaux

        #On pose le question Réseau ou Pare-Feu ou Gestion à distance ou quitter

            #si Réseau

                #On pose la question Nb d'interface ou Adresse Ip ou Adresse MAC ou Listes des ports Ouverts ou Quitter

                    #Si Nb D'interface

                    #Si Adresse Ip de chaque interface

                    #Si Adresse Mac

                    #Si liste de ports ouverts

                    #Si Quitter

                    #Else erreur de saisie

            #si Pare Feu

                #On pose la question Statut ou Activation ou Désactivation ou quitter

                    #Si Statut du pare-feu

                    #Si Activation du pare-feu

                    #Si Désactivation du pare-feu

                    #Si Quitter

                    #else erreur de saisie

            #Si Gestion à distance

                #on pose la question Prise de main à distance ou Execution de script sur la machine distante

                    #Si Prise de main à distance

                    #Si Exécution de script sur la machine distante

                    #si quitter

                    #else erreur de saisie

    #Si Gestion syteme

        #on pose la question Logiciel ou système ou Journaux d'evenements ou quitter

            #si logiciel

                #On pose la question Installation ou désinstallation

                    #si Installaition de Logiciel

                    #si Désinstallation de logiciel

                    #si quitter

                    #Else erreur de saisie

            #Si Systeme

                #on pose la question Arrêt ou redémarrage ou Verouillage ou Version de l'Os ou MAJ du système ou quitter

                    # Si Arrêt

                    # Si redémarrage

                    # Si Vérouillage

                    # Si Version de l'os

                    # Si MAJ du Système 

                    #Si Quitter

                    #else erreur de saisie

            #Si Journaux d'événements

                #on pose la question Evenement utilisateur ou evenement ordinateur ou quitter

                    #Si Evenement Utilisateur

                    #Si Evenement Ordinateur

                    #Si quitter

                    #else erreur de saisie

            #Si Quitter
            
            #Si erreur ou des cas précedent.

    #Si quitter
    
    #Si erreur ou autre choix.

#Quitter ou boucler
