
# Installation Guide for openIMIS Backend
### Setting Up openIMIS Backend Prerequisites

Before installing the openIMIS backend, you need to set up essential programs like the database. To do this, use Docker Compose, which will automatically download and run all necessary components:

1.  **Install Docker and Docker Compose**
    
    -   Ensure Docker and Docker Compose are installed on your system. Download and install them from the official Docker website if needed.
        
2.  **Run Docker Compose**
    
    -   In the openimis-be_py directory, locate the docker-compose.yml file.
    - Also we need to copy environemnt variables from .env.example to .env by running : cp .env.example .env.
    -   Open a terminal, navigate to the openimis-be_py directory (cd openimis-be_py), and run docker-compose up -d. This command downloads and starts the required services (e.g., database and OpenSearch) in the background.
        
3.  **Verify Setup**
    
    -   Check that the services are running by using docker-compose ps. Ensure the database(psql and mssql) and OpenSearch containers are up and healthy before proceeding with the backend installation.


Follow these steps to set up the openIMIS backend on your computer:
1.  **Download the Code**
    -   Clone the repository to your computer. This creates a folder called openimis-be_py.
2.  **Set Up Python Environment**
    -   Install Python 3.
    -   Create a virtual environment to keep dependencies isolated:
        -   Run python -m venv venv to create a virtual environment named venv.
        -   Activate it:
            -   On macOS/Linux: source venv/bin/activate
3.  **Install pip**
    -   Ensure pip is installed (it usually comes with Python). Check by running pip --version. If not installed, download get-pip.py from the official pip website and run python get-pip.py.
4.  **Navigate to the Project Folder**
    -   Open a terminal and go to the openimis-be_py folder: cd openimis-be_py.
5.  **Install External Dependencies**
    -   Install the required dependencies by running pip install -r requirements.txt.
6.  **Generate Module Dependencies**
    -   In the openimis-be_py/script directory, run python modules-requirements.py ../openimis.json > modules-requirements.txt to generate the module dependencies file based on openimis.json.
7.  **Uninstall Previous Modules (if needed)**
    -   If you previously installed openIMIS with a different version, uninstall old modules to avoid conflicts: pip uninstall -r modules-requirements.txt.
8.  **Install Current Modules**
    -   Install the current module dependencies: pip install -r modules-requirements.txt.

9.  **Start the Backend**
    -   Navigate to the openimis-be_py/openIMIS directory: cd openIMIS.
    -   Run all the migrations by running : python manage.py migrate. This will apply all the migrations to the database.
    -   Start the openIMIS backend server: python manage.py runserver. This launches the backend in development mode, accessible in your browser (usually at http://localhost:8000).


#  Guide to Editing an openIMIS Backend Module (e.g., openimis-be-claim)
Follow these steps to modify an existing openIMIS backend module, such as openimis-be-claim:
1.  **Clone the Module Repository**
    -   Before clonning, we have to make sure that the repo is forked by HABTech repository.
    -   Clone the module's git repository (e.g., openimis-be-claim_py) to a location **next to** (not inside) the openimis-be_py folder.
    -   Create a new git branch for your changes to keep your work organized.
2.  **Uninstall the Packaged Module**
    -   Open a terminal and navigate to the openimis-be_py folder: cd openimis-be_py.
    -   Uninstall the existing packaged version of the module: pip uninstall openimis-be-claim.
3.  **Install the Local Module**
    -   Install the local version of the module in editable mode: pip install -e ../openimis-be-claim_py/.
    -   This links the local module to your openIMIS backend, so any changes you make to the module are automatically reflected (live updates).

Now, the openIMIS backend will use your local module changes for development and testing!
