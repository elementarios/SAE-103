#!/usr/bin/bash
ficjpg=$(ls /home/Ntraite/*.jpg)
ficpng=$(ls /home/Ntraite/*.png)
ficwebp=$(ls /home/Ntraite/*.webp)
ficpdf=$(ls /home/Ntraite/*.pdf)

tailleMinX=350
tailleMinY=250
tailleMaxX=900
tailleMaxY=620


#on traite tout les fichier avec la mauvaise extension
for fic in $ficjpg $ficpdf $ficpng
do 

    #pour obtenir la taille de l'image
    tailleX=identify $fic | cut -d ' ' -f 3 | cut -d 'x' -f 1
    tailleY=identify $fic | cut -d ' ' -f 3 | cut -d 'x' -f 2

    #pour obtenir le nom de l'image sans l'extension (chaque extension fait 3 caractère +1 point donc 4 au total)
    dernierchar=eccho $fic | wc -c
    nomfic=eccho $fic | colrm $dernierchar-4 $dernierchar

    if [[ $tailleX -gt $tailleMinX ]] && [[ $tailleY -gt $tailleMinY ]] #on verifie que l'image n'est pas trop petite
    then
        if  [[ $tailleX -gt $tailleMaxX ]] && [[ $tailleY -gt $tailleMaxY ]] #si l'image est trop grande 
        then
            if [[ $($tailleX*0.8 | cut -d '.' -f 1) -le $tailleMaxX ]] && [[ $($tailleY*0.8 | cut -d '.' -f 1) -le $tailleMaxY ]] && [[ $($tailleX*0.8 | cut -d '.' -f 1) -ge $tailleMinX ]] && [[ $($tailleY*0.8 | cut -d '.' -f 1) -ge $tailleMinY ]] #on verifie que pour certain ratio l'image correspondent au bonne dimensions
            then
                convert /home/Ntraite/$fic -resize 80% /home/Termine/$nomfic.webp

            elif [[ $($tailleX*0.6 | cut -d '.' -f 1) -le $tailleMaxX ]] && [[ $($tailleY*0.6 | cut -d '.' -f 1) -le $tailleMaxY ]] && [[ $($tailleX*0.6 | cut -d '.' -f 1) -ge $tailleMinX ]] && [[ $($tailleY*0.6 | cut -d '.' -f 1) -ge $tailleMinY ]] 
            then    
                convert /home/Ntraite/$fic -resize 60% /home/Termine/$nomfic.webp

            elif [[ $($tailleX*0.4 | cut -d '.' -f 1) -le $tailleMaxX ]] && [[ $($tailleY*0.4 | cut -d '.' -f 1) -le $tailleMaxY ]] && [[ $($tailleX*0.4 | cut -d '.' -f 1) -ge $tailleMinX ]] && [[ $($tailleY*0.4 | cut -d '.' -f 1) -ge $tailleMinY ]]
            then    
                convert /home/Ntraite/$fic -resize 40% /home/Termine/$nomfic.webp
 
            elif [[ $($tailleX*0.2 | cut -d '.' -f 1) -le $tailleMaxX ]] && [[ $($tailleY*0.2 | cut -d '.' -f 1) -le $tailleMaxY ]] && [[ $($tailleX*0.2 | cut -d '.' -f 1) -ge $tailleMinX ]] && [[ $($tailleY*0.2 | cut -d '.' -f 1) -ge $tailleMinY ]]
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

    if [[ $tailleX -gt $tailleMinX ]] && [[ $tailleY -gt $tailleMinY ]] #on verifie que l'image n'est pas trop petite
    then
        if  [[ $tailleX -gt $tailleMaxX ]] && [[ $tailleY -gt $tailleMaxY ]] #si l'image est trop grande 
        then
            if [[ $($tailleX*0.8 | cut -d '.' -f 1) -le $tailleMaxX ]] && [[ $($tailleY*0.8 | cut -d '.' -f 1) -le $tailleMaxY ]] && [[ $($tailleX*0.8 | cut -d '.' -f 1) -ge $tailleMinX ]] && [[ $($tailleY*0.8 | cut -d '.' -f 1) -ge $tailleMinY ]] #on verifie que pour certain ratio l'image correspondent au bonne dimensions
            then
                convert /home/Ntraite/$fic -resize 80% /home/Termine/$fic

            elif [[ $($tailleX*0.6 | cut -d '.' -f 1) -le $tailleMaxX ]] && [[ $($tailleY*0.6 | cut -d '.' -f 1) -le $tailleMaxY ]] && [[ $($tailleX*0.6 | cut -d '.' -f 1) -ge $tailleMinX ]] && [[ $($tailleY*0.6 | cut -d '.' -f 1) -ge $tailleMinY ]] 
            then    
                convert /home/Ntraite/$fic -resize 60% /home/Termine/$fic

            elif [[ $($tailleX*0.4 | cut -d '.' -f 1) -le $tailleMaxX ]] && [[ $($tailleY*0.4 | cut -d '.' -f 1) -le $tailleMaxY ]] && [[ $($tailleX*0.4 | cut -d '.' -f 1) -ge $tailleMinX ]] && [[ $($tailleY*0.4 | cut -d '.' -f 1) -ge $tailleMinY ]]
            then    
                convert /home/Ntraite/$fic -resize 40% /home/Termine/$fic
 
            elif [[ $($tailleX*0.2 | cut -d '.' -f 1) -le $tailleMaxX ]] && [[ $($tailleY*0.2 | cut -d '.' -f 1) -le $tailleMaxY ]] && [[ $($tailleX*0.2 | cut -d '.' -f 1) -ge $tailleMinX ]] && [[ $($tailleY*0.2 | cut -d '.' -f 1) -ge $tailleMinY ]]
            then    
                convert /home/Ntraite/$fic -resize 20% /home/Termine/$fic
            fi


        else #l'image possede les bonne dimensions
            convert /home/Ntraite/$fic /home/Termine/$fic

        fi

    fi
done

