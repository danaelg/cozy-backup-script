#!/bin/bash
#version : 2.4

#Variable contenant le chemin du répertoire de sauvegarde
FOLDER=/mnt/nfs #A MODIFIER

#Lancement de la backup de cozy
cozy_management backup

#montage du dossier de sauvegarde
mount $FOLDER

#déplacement de l'archive de sauvegarde dans le dossier de sauvegarde
mv /var/lib/cozy/backups/cozy-$(date +%Y-%m-%d-)* $FOLDER

#Le 25 du mois on supprime toutes les sauvegardes du mois précédent, pour libérer de l'espace sur le dossier de sauvegarde
if [ $(date +%d) -ge 25 ]; then #si la date du jour est le 25 ou plus tard
    VAR=$(date +%m) #récupération du mois en cours dans une variable

        case $VAR in
                01 ) #Si on est en janvier
                        VAR=$(date +%Y) #récupèration de l'année en cours pour enlever 1 (puisque si nous somme en janvier, il faut supprimer les sauvegardes de décembre)
                        VAR="$((10#$VAR - 1))-12"
                        rm $FOLDER/cozy-$VAR\-*
                        ;;

                02 | 03 | 04 | 05 | 06 | 07 | 08 | 09 | 10 ) #Si on est dans un mois qui commence par 0 ou qui commencera par 0 lorsqu'on lui enlève 1 (10(octobre) - 1 = 09(septembre))
                        VAR=$((10#$VAR - 1)) #on enlève 0 devant le mois en cours puis on enlève 1 (pour avoir le chiffre du mois précédent)
                        VAR=0$VAR #on remet le 0 devant le chiffre
                        rm $FOLDER/cozy-$(date +%Y-)$VAR\-* #suppréssion de l'archive du mois précédent présente sur le dossier de sauvegarde
                        ;;

                11 | 12 ) #Pour les mois qui reste
                        VAR=$((10#$VAR - 1)) #on enlève 1 au mois en cours (pas de 0 à supprimer contrairement au cas précédent)
                        rm $FOLDER/cozy-$(date +%Y-)$VAR\-* #Suppréssion de l'archive du mois précédent
                        ;;

               * ) #Au cas où le plomb se transforme en or
                        echo "une erreur est survenue"
                        exit 100;
                        ;;
        esac
fi

#démontage du dossier de sauvegarde
umount $FOLDER

#fin
exit 0;
