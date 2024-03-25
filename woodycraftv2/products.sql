-- --------------------------------------------------------
-- Hôte:                         127.0.0.1
-- Version du serveur:           8.0.30 - MySQL Community Server - GPL
-- SE du serveur:                Win64
-- HeidiSQL Version:             12.1.0.6537
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- Listage des données de la table woodycraftv2.products : ~5 rows (environ)
INSERT INTO `products` (`id`, `categories_id`, `name`, `description`, `image`, `price`, `quantity`, `created_at`, `updated_at`, `deleted_at`) VALUES
	(9, 1, 'batterie', 'description du contenu de la boite', 'musicDrum.png', 32.00, 6, NULL, NULL, NULL),
	(10, 1, 'saxophone', 'description du contenu de la boite', 'musicSaxo.png', 25.00, 7, NULL, NULL, NULL),
	(11, 1, 'guitare', 'description du contenu de la boite', 'musicElectricGuitar.png', 8.30, 4, NULL, NULL, NULL),
	(25, 3, 'rabbit', 'description du contenu de la boite', 'steampunkRabbit.png', 10.80, 8, NULL, NULL, NULL),
	(27, 3, 'marine', 'description du contenu de la boite', 'steampunkSubMarine.png', 13.50, 14, NULL, NULL, NULL);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
