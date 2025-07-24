# Installation Guide for openIMIS Backend
Follow these steps to set up the openIMIS backend on your computer:
1.  **Download the Code**
    -   Clone the repository to your computer. This creates a folder called openimis-be_py.
      ```sh
    git clone https://github.com/HABTec/openimis-be_py.git
    ```
2.  **Navigate to the Project Folder**
    -   Open a terminal and go to the openimis-be_py folder: 
    ```sh
    cd openimis-be_py
    ```
3.  **Setting Up openIMIS Backend Prerequisites**

    Before installing the openIMIS backend, you need to set up essential programs like the database. To do this, use Docker Compose, which will automatically download and run all necessary components:

    3.1    **Install Docker and Docker Compose**

    - Ensure Docker and Docker Compose are installed on your system. Download and install them from the official Docker website if needed.

    3.2    **Run Docker Compose**

    -   In the openimis-be_py directory, locate the docker-compose.yml file.
    
    - Also we need to copy environemnt variables from .env.example to .env by running :  
        ```sh
        cp .env.example .env
        ``` 
        and run docker compose up
        ```sh
        docker-compose up -d
        ```
    This command downloads and starts the required services (e.g., database and OpenSearch) in the background.

    3.3   **Verify Setup**

    -   Check that the services are running by using docker-compose ps. Ensure the database(psql and mssql) and OpenSearch containers are up and healthy before proceeding with the backend installation.




2.  **Set Up Python Environment**
-   Install Python 3.
-   Create a virtual environment to keep dependencies isolated:
    -   Run python -m venv venv to create a virtual environment named venv.
    ```sh
    python -m venv venv
    ```
    -   Activate it:
        -   On macOS/Linux: 
        ```sh
            source venv/bin/activate
        ```
3.  **Install pip**
    -   Ensure pip is installed (it usually comes with Python). Check by running pip --version. If not installed, download get-pip.py from the official pip website and run python get-pip.py.

5.  **Install External Dependencies**
    -   Install the required dependencies by running 
        ```sh
        pip install -r requirements.txt
        ```
6.  **Generate Module Dependencies**
    -   In the openimis-be_py/script directory,  generate the module dependencies file based on openimis.json.
        ```sh
        cd script
        python modules-requirements.py ../openimis.json > modules-requirements.txt
        ```
7.  **Uninstall Previous Modules (if needed)**
    -   If you previously installed openIMIS with a different version, uninstall old modules to avoid conflicts: 
        ```sh
        pip uninstall -r modules-requirements.txt
        ```
8.  **Install Current Modules**
    -   Install the current module dependencies: 
        ```sh
        pip install -r modules-requirements.txt
        ```

9.  **Start the Backend**
    -   Navigate to the openimis-be_py/openIMIS directory: 
        ```sh
        cd ../openIMIS
        ```
    -   Run all the migrations by running : 
        ```sh
        python manage.py migrate
        ```
        This will apply all the migrations to the database.
    -   Start the openIMIS backend server: 
        ```sh 
        python manage.py runserver
        ```
    This launches the backend in development mode, accessible in your browser (usually at http://localhost:8000).


#  Guide to Editing an openIMIS Backend Module (e.g., openimis-be-claim)
Follow these steps to modify an existing openIMIS backend module, such as openimis-be-claim:
1.  **Clone the Module Repository**
    -   Before clonning, we have to make sure that the repo is forked by HABTech repository.
    -   Clone the module's git repository (e.g., openimis-be-claim_py) to a location **next to** (not inside) the openimis-be_py folder.
    
    -   Create a new git branch for your changes to keep your work organized.
2.  **Uninstall the Packaged Module**
    -   Open a terminal and navigate to the openimis-be_py folder: cd openimis-be_py.
    -   Uninstall the existing packaged version of the module: 
        ```sh
        pip uninstall openimis-be-claim
        ```
3.  **Install the Local Module**
    -   Install the local version of the module in editable mode: 
        ```sh
        pip install -e ../openimis-be-claim_py/
        ```
    -   This links the local module to your openIMIS backend, so any changes you make to the module are automatically reflected (live updates).

Now, the openIMIS backend will use your local module changes for development and testing!



#  Guide to Adding Creating Membership Type Feature working.
1. Go into the openimis-be_py project directory and uninstall the current product module by running:
        pip uninstall openimis-be-product_py
    
Once uninstalled, move to the openimis-be-product_py directory, switch to the branch develop, and pull the latest changes:
        cd ../openimis-be-product_py
    
    
        git switch develop
    git pull
    
    
2. Return to the openimis-be_py directory and reinstall the updated product module in editable mode:

       cd ../openimis-be_py
   
        pip install -e ../openimis-be-product_py
    
3. Clone the openimis-be-core_py repository, navigate into it, switch to develop, and pull the latest changes:
        git clone https://github.com/HABTec/openimis-be-core_py.git
    
    
        cd openimis-be-core_py
    
        git switch develop
    
        git pull
    
        cd ..
    
4. Clone the openimis-be-individual_py repository outside the openimis-be_py file, switch to the branch develop, and pull the latest changes:
        git clone https://github.com/HABTec/openimis-be-individual_py.git
    
        cd openimis-be-individual_py
    
        git switch develop
    
        git pull
    
        cd ..
    

5. Now go into the openimis-be_py/openIMIS directory, apply the migrations, and run the server:
        cd openimis-be_py/openIMIS
    
        python manage.py migrate
    
        python manage.py runserver

# Guide to using script.sh file to install and pull changes from HABTec/openimis

1. Download the script.sh file locally. If you have already installed openimis place the script.sh file outside the openimis-be_py file

2. Make sure that you are on Ubuntu Debian.

3. Install python3.10 and docker on your PC.

4. Run the script using:

        source script.sh

5. To install openimis from scratch press 1 and proceed

6. To pull new changes from the main branch press 2 and proceed