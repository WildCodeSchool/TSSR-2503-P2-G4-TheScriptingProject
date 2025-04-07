#!/bin/bash

# Script ajout utilisateur

while true;
do
        read -p "Merci d'indiquer le nom d'utilisateur :" user

# Vérification si l'utilisateur a bien été saisi
        if [ -z "$user" ]; then
                echo "Merci d'entrer un nom d'utilisateur valide"
continue
        fi 

# Vérification si l'utilisateur existe déjà
        if grep "$user:" /etc/passwd; then
                echo "L'utilisateur $user existe déjà."
continue
        fi
break
done

# Tentative de création de l'utilisateur
        if sudo useradd "$user"; then
                echo "L'utilisateur $user a été créé avec succès !"
        fi


#!/bin/bash
#Script gestion mot de passe

#Choisir le compte pour lequel on souhaite changer le mot de passe

read -p "Merci d'indique le compte pour lequel vous souhaitez changer le mot de passe": user

    if [ -z "$user" ]; then
     echo "Merci d'entrer un nom d'utilisateur valide"
    else
      echo "Vous avez choisi le compte $1" && passwd $user
    fi


#!/bin/bash

# Demande d'insertion/vérification du compte à supprimer
read -p "Merci d'indiquer le nom d'utilisateur : " user

# Vérifie si vide
if [ -z "$user" ]; then
    echo "Merci d'entrer un nom d'utilisateur valide"
    exit 1
fi

# Vérifie si l'utilisateur existe
if ! id "$user" &>/dev/null; then
    echo "Le compte $user n'existe pas."
    exit 1
fi

# Demande de confirmation
echo "Vous avez choisi de supprimer le compte $user, êtes-vous sûr ? (Oui/Non)"
read confirmation

case $confirmation in
    [Oo]ui|[Oo]UI)
        deluser "$user"
        echo "Le compte $user a bien été supprimé"
        ;;
    [Nn]on|[Nn]ON)
        echo "Suppression de compte annulée"
        exit 1
        ;;
    *)
        echo "Réponse invalide, suppression annulée"
        exit 1
        ;;
esac


#!/bin/bash
#Demande d'insertion/vérification du compte à désactiver
    read -p "Merci d'indiquer le nom d'utilisateur :" user

if [ -z "$user" ]; then
    echo "Merci d'entrer un nom d'utilisateur valide"
    exit1
fi

# Vérifie si l'utilisateur existe
if ! id "$user" &>/dev/null; then
    echo "Le compte $user n'existe pas."
    exit 1
fi

# Demande de confirmation
    echo "Vous avez choisi de désactiver le compte $user, êtes-vous sûr ? (Oui/Non)"
 
#Ajout de la variable de confirmation du script désactivation
    read confirmation 
        case $confirmation in
        [Oo]ui|[Oo]UI)
        sudo passwd -l $user
             echo "Le compte $user a bien été désactivé"
;;
        [Nn]on|[Nn]ON)
             echo "Désactivation de compte annulée"
                exit 1
;;
        *)
            echo "Réponse invalide, désactivation annulée"
                exit 1
;;
        esac




#!/bin/bash

#Demande d'ajout à un groupe d'administation

#On vérifie l'existence du compte

read -p "Merci d'indiquer le nom d'utilisateur à upgrade :"

if [ -z "$user" ]; then
    echo "Le nom d'utilisateur n'existe pas"
    exit 1
fi 

# Vérifie si l'utilisateur existe
if ! id "$user" &>/dev/null; then
    echo "Le compte $user n'existe pas."
    exit 1
fi

# Demande de confirmation
echo "Vous avez choisi d'ajouter le compte $user au groupe administrateur, êtes-vous sûr ? (Oui/Non)"

#Ajout de la variable de confirmation d'ajout au groupe administrateur
read confirmation
    case $confirmation in
    [Oo]ui|[Oo]UI)
        sudo usermod -aG sudo $user
;;
    [Nn]on|[Nn]ON)
        echo "Commande d'ajout dans le groupe administrateur annulée"
;;
    *)
        echo "Réponse invalide, sortie"
;;
    esac



#!/bin/bash
#Demande d'ajout à un groupe local

#On vérifie l'existence du compte

read -p "Merci d'indiquer le nom d'utilisateur à upgrade :"

if [ -z "$user" ]; then
    echo "Le nom d'utilisateur n'existe pas"
    exit 1
fi

# Vérifie si l'utilisateur existe
if ! id "$user" &>/dev/null; then
    echo "Le compte $user n'existe pas."
    exit 1
fi

read -p "Merci d'indiquer le nom du groupe local :" group

# Demande de confirmation
echo "Vous avez choisi d'ajouter le compte $user au groupe local $group, êtes-vous sûr ? (Oui/Non)"
if
#Ajout de la variable de confirmation de création du groupe
read confirmation
case $confirmation in
    [Oo]ui|[Oo]UI)
        sudo groupadd $group
;;
    [Nn]on|[Nn]ON)
        echo "Commande de création de groupe annulée"
;;
    *)
        echo "Réponse invalide, sortie"
;;
esac

else

#Ajout de la variable de confirmation d'ajout au groupe local
read confirmation
case $confirmation in
[Oo]ui|[Oo]UI)
sudo usermod -aG
;;
[Nn]on|[Nn]ON)
echo "Commande d'ajout dans le groupe local annulée"
;;
*)
echo "Réponse invalide, sortie"
;;
esac
fi


#!/bin/bash
#Demande d'exclusion à un groupe local

#On vérifie l'existence du compte

read -p "Merci d'indiquer le nom d'utilisateur à upgrade :"

if [ -z "$user" ]; then
    echo "Le nom d'utilisateur n'existe pas"
    exit 1
fi

# Vérifie si l'utilisateur existe
if ! id "$user" &>/dev/null; then
    echo "Le compte $user n'existe pas."
    exit 1
fi

# Demande de confirmation
echo "Vous avez choisi d'exclure le compte $user au groupe local $group, êtes-vous sûr ? (Oui/Non)"

#Vérifier l'existence du groupe local
if [ -z "$group"]; then
    echo "Le groupe n'existe pas"
#Ajout de la variable de confirmation de création du groupe
    read confirmation
    case $confirmation in
        [Oo]ui|[Oo]UI)
            sudo gpasswd $group
;;
        [Nn]on|[Nn]ON)
            echo "Commande d'exlusion du groupe local annulée"
;;
        *)
            echo "Réponse invalide, sortie"
;;
    esac
fi

    else

#Ajout de la variable de confirmation d'ajout au groupe local
read confirmation
    case $confirmation in
        [Oo]ui|[Oo]UI)
            sudo usermod -aG
;;
        [Nn]on|[Nn]ON)
            echo "Commande d'ajout dans le groupe local annulée"
;;
        *)
            echo "Réponse invalide, sortie"
;;
    esac
fi


#!/bin/bash

# On veut modifier les droits d'accès de l'utilisateur sur un fichier ou un dossier.

# On demande s'il veut modifier un fichier ou un dossier
read -p "Choisissez entre fichier et dossier : " type

# Si c'est un fichier
if [ "$type" = "fichier" ]; then
    # On demande le nom du fichier
    read -p "Entrez le nom du fichier à modifier : " file

    # On vérifie si l'argument est bien un fichier
    if [ -f "$file" ]; then
        # On demande quelle permission il veut ajouter
        read -p "Quelle permission voulez-vous ajouter ? (ex: 777) : " perms
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
        read -p "Quelle permission voulez-vous ajouter ? (ex: 777) : " perms
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


#!/bin/bash

#On cherche à avoir les dernières connexion d'un utilisateur

read -p "Merci d'entrer le nom d'un utilisateur :" user

#On vérifie si l'utilisateur existe bien
if [ -z "$user"]; then
    echo L'utilisateur n'exite pas
    exit 1
fi

#On lance l'historique de connection
last u $user 



#!/bin/bash

#On cherche à avoir les dernières modifications de mdp

read -p "Merci d'entrer le nom d'un utilisateur :" user

#On vérifie si l'utilisateur existe bien
if [ -z "$user"]; then
    echo L'utilisateur n'exite pas
    exit 1
fi

#On lance l'historique de modification de mdp
chage -l $user



#!/bin/bash

#On vérifie la liste des sessions ouvertes par l'utilisateur

read -p "Merci d'entrer le nom d'un utilisateur :" user

#
