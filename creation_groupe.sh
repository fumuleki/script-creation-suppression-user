#!/bin/bash

function check_if_group_exist()  {
#Recupération de la liste des utilisateur
LIST_GROUPS=`cat /etc/group | cut -d: -f1`

for GROUPS in $LIST_GROUPS
do
         if [ $1 = $GROUP ]
         then
                 #echo "Le groupe $1 semble déjà exister"
                  return 1
         fi
done
}


clear
echo ""
echo "Merci d'entrer un numéro correspondant à votre choix"
echo ""
echo "1.        Creation d'un groupe"
echo "2.        Suppression d'un groupe"
echo ""
read -p "Choix : " CHOIX

case $CHOIX in
        1) #Creation du groupe
              read -p "Merci d'entrer le nom du groupe à créer : " NAME
              check_if_group_exist $NAME
              if [ $? -eq 1 ]
              then
                      echo "Le groupe $NAME semble déjà exister"
                      exit 1

              else
                      groupadd $NAME && echo "Le groupe $NAME a été créé"
                      fi
              ;;
        2) #Suppression du groupe
              read -p "Merci d'entrer le nom du groupe à supprimer : " NAME
              check_if_group_exist $NAME
              if [ $? -eq 1 ]
              then
                      echo "Le groupe $NAME ne semble pas exister"
                      exit 1
              else
                      groupdel $NAME && echo "Le groupe $NAME a bien été supprimé"
                      fi
              ;;
        *) #Autres cas
                echo "Vous devez entrer un chiffre compris entre 1 et 2"
                ;;
esac

