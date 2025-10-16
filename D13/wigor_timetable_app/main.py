import sys
import logging
from src.gui import run_gui
from src.config import setup_logging

# Configure le logging avant toute autre chose
setup_logging()
logger = logging.getLogger(__name__)

if __name__ == "__main__":
    logger.info("Démarrage de l'application Emploi du Temps Wigor.")
    try:
        run_gui()
    except Exception as e:
        # Log les erreurs non gérées au niveau supérieur
        logger.error(f"Erreur fatale de l'application: {e}", exc_info=True)
        # En environnement GUI packagé, il est difficile d'afficher l'erreur
        # On loggue l'erreur pour analyse future.
        sys.exit(1)
