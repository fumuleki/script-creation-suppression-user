#!/bin/bash

function check_if_user_exist()  {
#Recupération de la liste des utilisateur
LIST_USERS=`cat /etc/passwd | cut -d: -f1`

for USERS in $LIST_USERS
do
         if [ $1 = $USERS ]
         then
                 #echo "L'utilisateur $1 semble déjà exister"
                  return 1
         fi
done
}


clear
echo ""
echo "Merci d'entrer un numéro correspondant à votre choix"
echo ""
echo "1.        Creation d'un utilisateur"
echo "2.        Suppression d'un utilisateur"
echo ""
read -p "Choix : " CHOIX

case $CHOIX in
        1) #Creation de l'utilisateur
              read -p "Merci d'entrer le nom de l'utilisateur à créer : " NAME
              check_if_user_exist $NAME
              if [ $? -eq 1 ]
              then
                      echo "L'utilisateur $NAME semble déjà exister"
                      exit 1

              else
                      useradd $NAME && echo "L'utilisateur $NAME a été créé"
                      fi
              ;;
        2) #Suppression de l'utilisateur
              read -p "Merci d'entrer le nom de l'utilisateur à supprimer : " NAME
              check_if_user_exist $NAME
              if [ $? -eq 1 ]
              then
                      echo "L'utilisateur $NAME ne semble pas exister"
                      exit 1
              else
                      userdel $NAME && echo "L'utilisateur $NAME a bien été supprimé"
                      fi
              ;;
        *) #Autres cas
                echo "Vous devez entrer un chiffre compris entre 1 et 2"
                ;;
esac

