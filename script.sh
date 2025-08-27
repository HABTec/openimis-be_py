#!/bin/bash

echo " 1. Clone all the repositories from scratch and Install openimis." 
echo -e "\e[33mWARNING: If you have previously installed openIMIS before please clear the Docker containers!!\e[0m"
echo 
echo " 2. Pull and install current changes only."

# Reading user input
read choice

Directory=./openimis-be

# Repositories to be cloned from HABTec
repos=("membership" "product_py" "contribution_py" "core_py" "claim_py" "individual_py" "insuree_py" "policy_py")

# Repositories cloned on the local device
file_names=("openimis-be_py" "openimis-be-claim_py" "openimis-be-contribution_py" "openimis-be-core_py" "openimis-be-individual_py" "openimis-be-insuree_py" "openimis-be-insuree_py" "openimis-be-membership" "openimis-be-policy_py" "openimis-be-product_py")

case $choice in "1")

    # Creating a directory for the backend
    mkdir openimis-be
    # Getting into the directory
    cd openimis-be

    # Creating the virtual environment
    python3.10 -m venv venv    
    
    git clone https://github.com/HABTec/openimis-be_py
    # Activating virtual environment and clonning all the repos

    source venv/bin/activate
    for repo in "${repos[@]}"; do
        echo "$repo"        
        git clone https://github.com/HABTec/openimis-be-$repo.git
    done

    
    # Looping through the files and checking if they are from the main branch
    for file in "${file_names[@]}"; do
        cd $file
        if [ "$file" = "openimis-be-membership" ]; then
            git checkout main
        else
            git checkout develop
        fi
        git pull
        cd ../
    done
    
    # Proceeding to install openimis-be based on the installation guide
    cd openimis-be_py
    cp .env.example .env
    # Storing possible ports 
    mapfile -t docker_ports < <(docker ps --format '{{.Ports}}' | grep -oP '\d+(?=->)' | sort -n | uniq)
    # Adding the default ports to make sure that they are free.
    docker_ports+=("5432" "1433")
    # Kill each port's process if found
    echo "Please enter your password inorder to free the ports that docker uses: "
    for PORT in "${docker_ports[@]}"; do
        PID=$(sudo lsof -ti tcp:$PORT)
        if [ -n "$PID" ]; then
            echo "Killing process on port $PORT (PID: $PID)..."
            sudo kill -9 "$PID"
        else
            echo "No process found on port $PORT."
        fi
    done


    docker compose up -d
    pip install -r requirements.txt
    cd script
    python modules-requirements.py ../openimis.json > modules-requirements.txt
    pip uninstall -r modules-requirements.txt
    pip install -r modules-requirements.txt
    cd ../

    cd openIMIS
    # Some migrations are not avaliable on the repos
    python manage.py makemigrations
    python manage.py migrate
    
    cd ../

    declare -A module_map=(
    ["openimis-be-claim"]="openimis-be-claim_py"
    ["openimis-be-membership"]="openimis-be-membership"
    ["openimis-be-contribution"]="openimis-be-contribution_py"
    ["openimis-be-policy"]="openimis-be-policy_py"
    ["openimis-be-product"]="openimis-be-product_py"
    ["openimis-be-insuree"]="openimis-be-insuree_py"
    ["openimis-be-individual"]="openimis-be-individual_py"
    ["openimis-be-core"]="openimis-be-core_py"
    )

    for module in "${!module_map[@]}"; do
    pip uninstall $module -y
    pip install -e ../${module_map[$module]}
    cd openIMIS
    python manage.py migrate
    cd ../
    done

    #

    cd openIMIS
    python manage.py migrate
    python manage.py runserver
    ;;


    "2")
    cd openimis-be/
    for file in "${file_names[@]}"; do
        cd $file
        if [ "$file" = "openimis-be-membership" ]; then
            git checkout main
        else
            git checkout develop
        fi
        git pull
        cd ../
    done

    source venv/bin/activate
    cd openimis-be_py/openIMIS/
    python manage.py makemigrations
    python manage.py migrate
    python manage.py runserver

    
    echo "You have selected two";;
    *)
    echo "Enter a valid option";;
esac
