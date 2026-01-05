#!/usr/bin/bash
for $fic in ./Ntraite/*.jpeg
do
    #pour obtenir la taille de l'image
    tailleX=identify $fic | cut -d ' ' -f 3 | cut -d 'x' -f 1
    tailleY=identify $fic | cut -d ' ' -f 3 | cut -d 'x' -f 2

    #pour obtenir le nom de l'image sans l'extension
    dernierchar=eccho $fic | wc -c
    nomfic=eccho $fic | colrm $dernierchar-4 $dernierchar

    if [ $tailleX -gt 350 ] && [ $tailleY -gt 250 ] #on verifie que l'image n'est pas trop petite
    then
        if  [ $tailleX -gt 900 ] && [ $tailleY -gt 620 ] #si l'image est trop grande 
        then
            if [ $tailleX*0.8 -le 900 ] && [ $tailleY*0.8 -le 620 ] && [ $tailleX*0.8 -ge 350 ] && [ $tailleY*0.8 -ge 250 ] #on verifie que pour certain ratio l'image correspondent au bonne dimensions
            then
                convert ./Ntraite/$fic -resize 80% ./Termine/$nomfic.webp

            elif [ $tailleX*0.6 -le 900 ] && [ $tailleY*0.6 -le 620 ] && [ $tailleX*0.6 -ge 350 ] && [ $tailleY*0.6 -ge 250 ] 
            then    
                convert ./Ntraite/$fic -resize 60% ./Termine/$nomfic.webp

            elif [ $tailleX*0.4 -le 900 ] && [ $tailleY*0.4 -le 620 ] && [ $tailleX*0.4 -ge 350 ] && [ $tailleY*0.4 -ge 250 ]
            then    
                convert ./Ntraite/$fic -resize 40% ./Termine/$nomfic.webp
 
            elif [ $tailleX*0.2 -le 900 ] && [ $tailleY*0.2 -le 620 ] && [ $tailleX*0.2 -ge 350 ] && [ $tailleY*0.2 -ge 250 ]
            then    
                convert ./Ntraite/$fic -resize 20% ./Termine/$nomfic.webp
            fi


        else #l'image possede les bonne dimensions
            convert ./Ntraite/$fic ./Termine/$nomfic.webp

        fi

    fi
done

for $fic in ./Ntraite/*.png
do
    #pour obtenir la taille de l'image
    tailleX=identify $fic | cut -d ' ' -f 3 | cut -d 'x' -f 1
    tailleY=identify $fic | cut -d ' ' -f 3 | cut -d 'x' -f 2

    #pour obtenir le nom de l'image sans l'extension
    dernierchar=eccho $fic | wc -c
    nomfic=eccho $fic | colrm $dernierchar-3 $dernierchar

    if [ $tailleX -gt 350 ] && [ $tailleY -gt 250 ] #on verifie que l'image n'est pas trop petite
    then
        if  [ $tailleX -gt 900 ] && [ $tailleY -gt 620 ] #si l'image est trop grande 
        then
            if [ $tailleX*0.8 -le 900 ] && [ $tailleY*0.8 -le 620 ] && [ $tailleX*0.8 -ge 350 ] && [ $tailleY*0.8 -ge 250 ] #on verifie que pour certain ratio l'image correspondent au bonne dimensions
            then
                convert ./Ntraite/$fic -resize 80% ./Termine/$nomfic.webp

            elif [ $tailleX*0.6 -le 900 ] && [ $tailleY*0.6 -le 620 ] && [ $tailleX*0.6 -ge 350 ] && [ $tailleY*0.6 -ge 250 ] 
            then    
                convert ./Ntraite/$fic -resize 60% ./Termine/$nomfic.webp

            elif [ $tailleX*0.4 -le 900 ] && [ $tailleY*0.4 -le 620 ] && [ $tailleX*0.4 -ge 350 ] && [ $tailleY*0.4 -ge 250 ]
            then    
                convert ./Ntraite/$fic -resize 40% ./Termine/$nomfic.webp
 
            elif [ $tailleX*0.2 -le 900 ] && [ $tailleY*0.2 -le 620 ] && [ $tailleX*0.2 -ge 350 ] && [ $tailleY*0.2 -ge 250 ]
            then    
                convert ./Ntraite/$fic -resize 20% ./Termine/$nomfic.webp
            fi


        else #l'image possede les bonne dimensions
            convert ./Ntraite/$fic ./Termine/$nomfic.webp

        fi

    fi
done

for $fic in ./Ntraite/*.webp
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
                convert ./Ntraite/$fic -resize 80% ./Termine/$fic

            elif [ $tailleX*0.6 -le 900 ] && [ $tailleY*0.6 -le 620 ] && [ $tailleX*0.6 -ge 350 ] && [ $tailleY*0.6 -ge 250 ] 
            then    
                convert ./Ntraite/$fic -resize 60% ./Termine/$fic

            elif [ $tailleX*0.4 -le 900 ] && [ $tailleY*0.4 -le 620 ] && [ $tailleX*0.4 -ge 350 ] && [ $tailleY*0.4 -ge 250 ]
            then    
                convert ./Ntraite/$fic -resize 40% ./Termine/$fic
 
            elif [ $tailleX*0.2 -le 900 ] && [ $tailleY*0.2 -le 620 ] && [ $tailleX*0.2 -ge 350 ] && [ $tailleY*0.2 -ge 250 ]
            then    
                convert ./Ntraite/$fic -resize 20% ./Termine/$fic
            fi


        else #l'image possede les bonne dimensions
            convert ./Ntraite/$fic ./Termine/$fic

        fi

    fi
done
