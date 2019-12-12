#!/bin/bash
# for this to work you must have 7zip as local variable,  what i mean:
# https://help.goodsync.com/hc/en-us/articles/360007773451-Automated-Backup-with-Compression-and-Encryption


# some context, i want to make an automathic backup of all my days work.
# compresed but for now im just saving my advances since its a little more
# complex my idea.


# store the current dir
CUR_DIR=$(pwd)

# Let the person running the script know what's going on.
echo "zipping repos to pull"
echo $CUR_DIR

# copiar todo al repositorio espejo, sin node modules 
# puede ser copiar y borrar o ignorar
# quizas algunos archivos indicados en un blacklist



# leer variables de entorno como claves desde un archivo que debemos ignorar


# comprimir con clave y hacer split en pedazos de 10 megas de todo el repo
# la clave no debe estar escrita en el comando sino de una variable de entorno




# hacer un repositorio de github con ese archivo


# hacer comits todos los dias a ese repo con todo el codigo (cromjob de bash?)
# quizas aprender a hacer algo en auto.it

# 



















# # Find all git repositories and update it to the master latest revision
# for i in $(find . -name ".git" | cut -c 3-); do
#     echo "";
#     echo $i;

#     # We have to go to the .git parent directory to call the pull command
#     cd "$i";
#     cd ..;

#     # finally pull
# 	# git pull origin master;
#     git pull;

#     # lets get back to the CUR_DIR
#     cd $CUR_DIR
# done

# echo "Complete!"