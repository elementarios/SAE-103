#!/usr/bin/bash
ficjpg=$(ls /home/Ntraite/*.jpg)
ficpng=$(ls /home/Ntraite/*.png)
ficwebp=$(ls /home/Ntraite/*.webp)
ficpdf=$(ls /home/Ntraite/*.pdf)

#on traite tout les fichier avec la mauvaise extension
for fic in $ficjpg $ficpdf $ficpng
do

    chmod 666 $fic #on se trouve dans un container qui sera detruit des la fin de la commande donc on peut modifier les droits 

    #pour obtenir la taille de l'image
    tailleX=identify $fic | cut -d ' ' -f 3 | cut -d 'x' -f 1
    tailleY=identify $fic | cut -d ' ' -f 3 | cut -d 'x' -f 2

    #pour obtenir le nom de l'image sans l'extension (chaque extension fait 3 caractère +1 point donc 4 au total)
    dernierchar=eccho $fic | wc -c
    nomfic=eccho $fic | colrm $dernierchar-4 $dernierchar

    if [ $tailleX -gt 350 ] && [ $tailleY -gt 250 ] #on verifie que l'image n'est pas trop petite
    then
        if  [ $tailleX -gt 900 ] && [ $tailleY -gt 620 ] #si l'image est trop grande 
        then
            if [ $tailleX*0.8 -le 900 ] && [ $tailleY*0.8 -le 620 ] && [ $tailleX*0.8 -ge 350 ] && [ $tailleY*0.8 -ge 250 ] #on verifie que pour certain ratio l'image correspondent au bonne dimensions
            then
                convert /home/Ntraite/$fic -resize 80% /home/Termine/$nomfic.webp

            elif [ $tailleX*0.6 -le 900 ] && [ $tailleY*0.6 -le 620 ] && [ $tailleX*0.6 -ge 350 ] && [ $tailleY*0.6 -ge 250 ] 
            then    
                convert /home/Ntraite/$fic -resize 60% /home/Termine/$nomfic.webp

            elif [ $tailleX*0.4 -le 900 ] && [ $tailleY*0.4 -le 620 ] && [ $tailleX*0.4 -ge 350 ] && [ $tailleY*0.4 -ge 250 ]
            then    
                convert /home/Ntraite/$fic -resize 40% /home/Termine/$nomfic.webp
 
            elif [ $tailleX*0.2 -le 900 ] && [ $tailleY*0.2 -le 620 ] && [ $tailleX*0.2 -ge 350 ] && [ $tailleY*0.2 -ge 250 ]
            then    
                convert /home/Ntraite/$fic -resize 20% /home/Termine/$nomfic.webp
            fi


        else #l'image possede les bonne dimensions
            convert /home/Ntraite/$fic /home/Termine/$nomfic.webp

        fi

    fi
done


#on traite les fichier ayant la bonne extension
for fic in $ficwebp
do
    #pour obtenir la taille de l'image
    tailleX=identify $fic | cut -d ' ' -f 3 | cut -d 'x' -f 1
    tailleY=identify $fic | cut -d ' ' -f 3 | cut -d 'x' -f 2

    if [ $tailleX -gt 350 ] && [ $tailleY -gt 250 ] #on verifie que l'image n'est pas trop petite
    then
        if  [ $tailleX -gt 900 ] && [ $tailleY -gt 620 ] #si l'image est trop grande 
        then
            if [ $tailleX*0.8 -le 900 ] && [ $tailleY*0.8 -le 620 ] && [ $tailleX*0.8 -ge 350 ] && [ $tailleY*0.8 -ge 250 ] #on verifie que pour certain ratio l'image correspondent au bonne dimensions
            then
                convert /home/Ntraite/$fic -resize 80% /home/Termine/$fic

            elif [ $tailleX*0.6 -le 900 ] && [ $tailleY*0.6 -le 620 ] && [ $tailleX*0.6 -ge 350 ] && [ $tailleY*0.6 -ge 250 ] 
            then    
                convert /home/Ntraite/$fic -resize 60% /home/Termine/$fic

            elif [ $tailleX*0.4 -le 900 ] && [ $tailleY*0.4 -le 620 ] && [ $tailleX*0.4 -ge 350 ] && [ $tailleY*0.4 -ge 250 ]
            then    
                convert /home/Ntraite/$fic -resize 40% /home/Termine/$fic
 
            elif [ $tailleX*0.2 -le 900 ] && [ $tailleY*0.2 -le 620 ] && [ $tailleX*0.2 -ge 350 ] && [ $tailleY*0.2 -ge 250 ]
            then    
                convert /home/Ntraite/$fic -resize 20% /home/Termine/$fic
            fi


        else #l'image possede les bonne dimensions
            convert /home/Ntraite/$fic /home/Termine/$fic

        fi

    fi
done

