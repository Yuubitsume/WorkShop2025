# 📅 Application Emploi du Temps Wigor

Application de bureau simple pour afficher l'emploi du temps étudiant de Wigor (wigorservices) en utilisant Python et PySimpleGUI.

## 🚀 Installation

1. **Cloner le dépôt :**
   ```bash
   git clone <URL_DU_DEPOT>
   cd edt-wigor-app

2. **Créer un environnement virtuel (recommandé) :**
    ```bash
    python -m venv venv
    # Sur Windows :
    .\venv\Scripts\activate
    # Sur Linux/macOS :
    source venv/bin/activate

3. **Installer les dépendances :**
    ```bash
    pip install -r requirements.txt

## 🚀 Utilisation

Pour lancer l'application :

    ```bash
    python main.py



Lors du premier lancement, vous serez invité à entrer votre nom d'utilisateur Wigor. Ces informations seront stockées de manière sécurisée en utilisant keyring.

## 🧪 Tests
Pour exécuter les tests et vérifier la couverture :

Bash
pytest --cov=src tests/

📦 Compilation en Exécutable
Pour créer un fichier .exe avec PyInstaller :

Bash

pyinstaller --onefile --windowed main.py

# L'exécutable se trouvera dans le dossier `dist/`.

***


