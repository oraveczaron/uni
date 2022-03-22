#!/bin/bash

function Help()
{
echo "Options: -c -e"
echo "-c parameters: nickname, birthday, occupation, portrayed "
echo "-e parameter: integer between 1 and 102 "
echo "If you want to know the characters of the series give 'Characters' as parameter."
}

if [ $1 = "Help" ]
then
 Help
fi

function Characters()
{
local URL=https://www.breakingbadapi.com/api/characters
curl ${URL} | jq . > temp.txt
grep name temp.txt
}

if [ $1 = "Characters"  ]
then
 Characters
fi

function GetApiByName()
{
local URL=https://www.breakingbadapi.com/api/characters?name=$name+$name2
curl ${URL} | jq . > temp.txt
grep $1 temp.txt
}

function GetApiByEpisode()
{
local URL=https://www.breakingbadapi.com/api/episodes/$1
curl ${URL} | jq . > temp.txt
grep "episode" temp.txt
grep "season" temp.txt
grep "title" temp.txt
}

while getopts c:e: switch ;
do
	case $switch in
		"c")
                   echo "Which character do you want to know this about?"
                   read name name2
                   GetApiByName $OPTARG
                   ;;
		"e")
                   GetApiByEpisode $OPTARG
                   ;;
		"?") HELP ;;
	esac
done
