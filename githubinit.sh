#!/bin/bash

DESCRIPTION=
NAME=
LANG=
USER=

howto()
{
cat << EOF
$0 usage
This script creates and initializes a remote github repo and clones it into the CURRENTDIR/NAME
-n name of repo and folder to create in current directory
-d repo description
-u github username
-l programming language for .gitignore
EOF
}

while getopts "n:d:l:u:" OPTION
do
	case $OPTION in
		d) DESCRIPTION=$OPTARG ;;
		l) LANG=$OPTARG ;;
		u) USER=$OPTARG ;;
		n) NAME=$OPTARG ;;
		?) howto; exit ;;
	esac
done
if [[ -z $DESCRIPTION ]] || [[ -z $LANG ]] || [[ -z $USER ]] || [[ -z $NAME ]]
then
	howto
	exit
fi

curl -u $USER https://api.github.com/user/repos -d "{\"name\":\"$NAME\", \"description\":\"$DESCRIPTION\",\"gitignore_template\":\"$LANG\", \"auto_init\":true}"
git clone https://github.com/$USER/$NAME.git
