#!/bin/bash

# Initialize `$interactive` default value
interactive=true

for i in $@
do
    case $i in
        -i|--interactive)
            interactive=true
            ;;
        -n|--non-interactive)
            interactive=false
            ;;
        -h|--help)
            echo "Use this command to get configs provided in sharkonfig repository."
            echo "Flags:"
            echo "    -i / --interactive -> Use this script interactively (Default)"
            echo "    -n / --non-interactive -> Use this script non interactively"
            echo "    -h / --help -> Print this help page and exit"
            exit
            ;;
        *)
            echo "Unrecognized argument: $i"
            exit 1
            ;;
    esac
done

if [ "$interactive" = true ]
then
    echo "Do you want to get sharkonfigs? Please make sure your configs are backed up before doing this. (y/n)"
    read proceed

    if ! [[ "$proceed" =~ ^([yY][eE][sS]|[yY])$ ]]
    then
        echo "Oki bye bye! UwU"
        exit 1
    fi
fi

git clone https://github.com/Sharkitty/sharkonfig.git -b re_clone_external_repos $HOME/sharkonfig
$HOME/sharkonfig/scripts/copy.sh
rm -rf $HOME/sharkonfig
