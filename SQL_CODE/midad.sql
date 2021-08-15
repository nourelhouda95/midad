-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 15, 2021 at 11:05 PM
-- Server version: 10.4.20-MariaDB
-- PHP Version: 8.0.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `midad`
--

-- --------------------------------------------------------

--
-- Table structure for table `attestation`
--

CREATE TABLE `attestation` (
  `id` int(11) NOT NULL,
  `id_group` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `bon`
--

CREATE TABLE `bon` (
  `id` int(11) NOT NULL,
  `date_creation` text NOT NULL,
  `versement` text NOT NULL,
  `rest_a_paye` text NOT NULL,
  `id_user` varchar(5) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `enum_formation`
--

CREATE TABLE `enum_formation` (
  `id` int(11) NOT NULL,
  `titre` text NOT NULL,
  `prix` text NOT NULL,
  `categorie` varchar(255) DEFAULT NULL,
  `niveau` varchar(3) DEFAULT NULL,
  `vlmHor` varchar(3) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `enum_formation`
--

INSERT INTO `enum_formation` (`id`, `titre`, `prix`, `categorie`, `niveau`, `vlmHor`) VALUES
(1, 'Bureautique', '3500', NULL, NULL, NULL),
(2, 'Francais', '4000', NULL, NULL, NULL),
(3, 'English', '3800', NULL, NULL, NULL),
(4, 'Java', '7000', 'Informatique - Programmation', '3', '24');

-- --------------------------------------------------------

--
-- Table structure for table `etudiant_group`
--

CREATE TABLE `etudiant_group` (
  `id_etudiant` varchar(5) NOT NULL,
  `id_group` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `formation`
--

CREATE TABLE `formation` (
  `id` int(11) NOT NULL,
  `titre_formation` text NOT NULL,
  `prix_formation` text NOT NULL,
  `date_debut` text DEFAULT NULL,
  `volume_hor` varchar(3) DEFAULT NULL,
  `date_fin` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `formation`
--

INSERT INTO `formation` (`id`, `titre_formation`, `prix_formation`, `date_debut`, `volume_hor`, `date_fin`) VALUES
(14, 'Bureautique', '3500', NULL, NULL, NULL),
(16, 'Francais', '4000', NULL, NULL, NULL),
(17, 'Francais', '4000', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `groupe`
--

CREATE TABLE `groupe` (
  `id` int(11) NOT NULL,
  `id_formation` int(11) NOT NULL,
  `id_formateur` varchar(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `inscription`
--

CREATE TABLE `inscription` (
  `id` int(11) NOT NULL,
  `date_insc` text DEFAULT NULL,
  `date_deb` text DEFAULT NULL,
  `id_formation` int(11) DEFAULT NULL,
  `id_user` varchar(5) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `inscription`
--

INSERT INTO `inscription` (`id`, `date_insc`, `date_deb`, `id_formation`, `id_user`) VALUES
(4, 'Sat Aug 14 2021 18:12:26 GMT+0200 (Central European Summer Time)', NULL, 14, 'RH001'),
(6, 'Sat Aug 14 2021 23:10:04 GMT+0200 (Central European Summer Time)', NULL, 16, 'BN002'),
(7, 'Sun Aug 15 2021 22:30:28 GMT+0200 (Central European Summer Time)', NULL, 17, 'RM002');

-- --------------------------------------------------------

--
-- Table structure for table `utilisateur`
--

CREATE TABLE `utilisateur` (
  `id` varchar(5) NOT NULL,
  `nom` text NOT NULL,
  `prenom` text NOT NULL,
  `numero_tel` text NOT NULL,
  `email` text DEFAULT NULL,
  `password` longtext DEFAULT NULL,
  `type` int(11) NOT NULL,
  `remise` int(11) DEFAULT NULL,
  `cause_remise` mediumtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `utilisateur`
--

INSERT INTO `utilisateur` (`id`, `nom`, `prenom`, `numero_tel`, `email`, `password`, `type`, `remise`, `cause_remise`) VALUES
('BN002', 'Bahloul', 'Nour el houda', '0796759664', NULL, NULL, 0, NULL, NULL),
('RH001', 'Rahiche', 'Houssame', '0770722644', NULL, NULL, 0, NULL, NULL),
('RM002', 'Rahiche', 'Messaoud', '0796759664', NULL, NULL, 0, NULL, NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `attestation`
--
ALTER TABLE `attestation`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_group_attestation` (`id_group`);

--
-- Indexes for table `bon`
--
ALTER TABLE `bon`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_user_bon` (`id_user`);

--
-- Indexes for table `enum_formation`
--
ALTER TABLE `enum_formation`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `etudiant_group`
--
ALTER TABLE `etudiant_group`
  ADD PRIMARY KEY (`id_etudiant`,`id_group`),
  ADD KEY `fk_groupe` (`id_group`);

--
-- Indexes for table `formation`
--
ALTER TABLE `formation`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `groupe`
--
ALTER TABLE `groupe`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_formation_group` (`id_formation`),
  ADD KEY `fk_formateur_group` (`id_formateur`);

--
-- Indexes for table `inscription`
--
ALTER TABLE `inscription`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_formation` (`id_formation`),
  ADD KEY `fk_user` (`id_user`);

--
-- Indexes for table `utilisateur`
--
ALTER TABLE `utilisateur`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `bon`
--
ALTER TABLE `bon`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `enum_formation`
--
ALTER TABLE `enum_formation`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `formation`
--
ALTER TABLE `formation`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `groupe`
--
ALTER TABLE `groupe`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `inscription`
--
ALTER TABLE `inscription`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `attestation`
--
ALTER TABLE `attestation`
  ADD CONSTRAINT `fk_group_attestation` FOREIGN KEY (`id_group`) REFERENCES `groupe` (`id`);

--
-- Constraints for table `bon`
--
ALTER TABLE `bon`
  ADD CONSTRAINT `fk_user_bon` FOREIGN KEY (`id_user`) REFERENCES `utilisateur` (`id`);

--
-- Constraints for table `etudiant_group`
--
ALTER TABLE `etudiant_group`
  ADD CONSTRAINT `fk_etudiant_group` FOREIGN KEY (`id_etudiant`) REFERENCES `utilisateur` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_groupe` FOREIGN KEY (`id_group`) REFERENCES `groupe` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `groupe`
--
ALTER TABLE `groupe`
  ADD CONSTRAINT `fk_formateur_group` FOREIGN KEY (`id_formateur`) REFERENCES `utilisateur` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_formation_group` FOREIGN KEY (`id_formation`) REFERENCES `formation` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `inscription`
--
ALTER TABLE `inscription`
  ADD CONSTRAINT `fk_formation` FOREIGN KEY (`id_formation`) REFERENCES `formation` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_user` FOREIGN KEY (`id_user`) REFERENCES `utilisateur` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
