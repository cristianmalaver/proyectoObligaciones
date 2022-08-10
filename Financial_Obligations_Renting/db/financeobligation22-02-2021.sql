-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 22-02-2021 a las 22:28:07
-- Versión del servidor: 10.4.17-MariaDB
-- Versión de PHP: 8.0.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `financeobligation`
--
<<<<<<< HEAD
CREATE DATABASE IF NOT EXISTS `financeobligation` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
=======
CREATE DATABASE IF NOT EXISTS `financeobligation` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
>>>>>>> parent of 63f508d... commmit
USE `financeobligation`;

DELIMITER $$
--
-- Procedimientos
--
DROP PROCEDURE IF EXISTS `insert_pre_quote`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_pre_quote` (IN `client_id` INT, IN `pre_quo_consec` VARCHAR(100), IN `pre_quo_height` VARCHAR(20), IN `pre_quo_width` VARCHAR(20), IN `pre_quo_quantity` VARCHAR(11), IN `pre_quo_project` VARCHAR(100), IN `pre_quo_inserts` VARCHAR(40), IN `pre_quo_bw` VARCHAR(100), IN `pre_quo_plast` VARCHAR(40), IN `pre_quo_coverFinish` VARCHAR(40), IN `pre_quo_top` VARCHAR(40), IN `stat_id` INT, IN `pre_quo_color` VARCHAR(100), IN `pre_quo_format` VARCHAR(40), IN `quo_observ` VARCHAR(400), IN `pre_quo_delivPlace` VARCHAR(200))  BEGIN
	INSERT INTO pre_quote(Pre_client_id,Pre_quo_consec,Pre_quo_top,Pre_quo_coverFinish,Pre_quo_plast,Pre_quo_bw,Pre_quo_color, Pre_quo_inserts, Pre_quo_project,Pre_quo_quantity,Pre_quo_width,Pre_quo_height,Stat_id,Pre_quo_date, Pre_quo_delivPlace) VALUES (client_id,pre_quo_consec,pre_quo_top,pre_quo_coverFinish,pre_quo_plast,pre_quo_bw,pre_quo_color,pre_quo_inserts,pre_quo_project,pre_quo_quantity,pre_quo_width,pre_quo_height,stat_id,CURRENT_DATE(),pre_quo_delivPlace);
END$$

DROP PROCEDURE IF EXISTS `sp_beneficiary_insert`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_beneficiary_insert` (IN `identification` VARCHAR(20), IN `lastName1` VARCHAR(100), IN `lastName2` VARCHAR(100), IN `name1` VARCHAR(100), IN `name2` VARCHAR(100), IN `relationship` VARCHAR(300), IN `percent` VARCHAR(3), IN `Mem_id` INT)  BEGIN 
  INSERT INTO beneficiary(Ben_identification, Ben_lastName1, Ben_lastName2, Ben_name1, Ben_name2, Ben_relationship, Ben_percent, Mem_id) 
  VALUES (identification, lastName1, lastName2, name1, name2, relationship, percent, Mem_id); 
  SELECT ROW_COUNT(); 
END$$

DROP PROCEDURE IF EXISTS `sp_beneficiary_view`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_beneficiary_view` (IN `id` INT)  BEGIN 
SELECT Ben_id, Ben_identification, Ben_lastName1, Ben_lastName2, Ben_name1, Ben_name2, Ben_relationship, Ben_percent, Mem_id 
   FROM beneficiary 
   WHERE Mem_id = id;
END$$

DROP PROCEDURE IF EXISTS `sp_broadcast_group_all`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_broadcast_group_all` (`company` INT)  BEGIN
	SELECT Bg_id, Bg_name FROM broadcast_group
    WHERE Comp_id = company;
END$$

DROP PROCEDURE IF EXISTS `sp_client_active`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_client_active` (IN `name` VARCHAR(100))  BEGIN
    IF name IS NULL THEN
        SELECT Client_id, Client_name, Client_identification, Client_tel, Client_email,Client_contactName, Client_contactCel, Client_contactEmail FROM client
       WHERE Stat_id = 8;
   ELSE
       SELECT Client_id, Client_name, Client_identification, Client_tel, Client_email,Client_contactName, Client_contactCel, Client_contactEmail FROM client WHERE (Client_name LIKE CONCAT('%', name ,'%') OR Client_identification LIKE CONCAT('%', name ,'%')) AND Stat_id = 8;
   END IF;
END$$

DROP PROCEDURE IF EXISTS `sp_client_insert`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_client_insert` (IN `name` VARCHAR(100), IN `identification` VARCHAR(15), IN `address` VARCHAR(200), IN `tel` VARCHAR(10), IN `email` VARCHAR(320), IN `contactName` VARCHAR(100), IN `title` VARCHAR(100), IN `contactTel` VARCHAR(10), IN `contactCel` VARCHAR(15), IN `contactEmail` VARCHAR(320))  BEGIN
    INSERT INTO client (Client_name, Client_identification, Client_address, Client_tel, Client_email, Client_contactName, Client_contactTitle, Client_contactTel, Client_contactCel, Client_contactEmail) VALUES (name, identification, address, tel, email, contactName, title, contactTel, contactCel, contactEmail);
SELECT Client_id FROM client WHERE Client_identification=identification;
END$$

DROP PROCEDURE IF EXISTS `sp_client_insert_update`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_client_insert_update` (IN `id` INT, IN `name` VARCHAR(100), IN `identification` VARCHAR(15), IN `address` VARCHAR(200), IN `tel` VARCHAR(10), IN `email` VARCHAR(320), IN `contactName` VARCHAR(100), IN `contactTitle` VARCHAR(100), IN `contactTel` VARCHAR(10), IN `contactCel` VARCHAR(15), IN `contactEmail` VARCHAR(320), IN `stat` INT)  BEGIN
    SET @exist = (SELECT COUNT(Client_id)FROM client WHERE Client_id = id); 
    IF @exist = 0 THEN 
		INSERT INTO client (Client_name, Client_identification, Client_address, Client_tel, Client_email, Client_contactName, Client_contactTitle, Client_contactTel, Client_contactCel, Client_contactEmail, Stat_id) VALUES (name, identification, address, tel, email, contactName, contactTitle, contactTel, contactCel, contactEmail, stat);
    ELSE
    	UPDATE client SET Client_identification = identification, Client_name = name, Client_address = address, Client_tel = tel, Client_email = email, Client_contactName = contactName, Client_contactTitle = contactTitle, Client_contactTel = contactTel, Client_contactCel = contactCel, Client_contactEmail = contactEmail, Stat_id = stat
        WHERE Client_id = id;
    END IF;
    SELECT ROW_COUNT();
END$$

DROP PROCEDURE IF EXISTS `sp_client_select_all`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_client_select_all` ()  BEGIN
SELECT Client_id, Client_name, Client_identification, Client_tel, Client_contactName, Client_contactCel, Client_contactEmail, Stat_id FROM client;
END$$

DROP PROCEDURE IF EXISTS `sp_client_select_identification`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_client_select_identification` (IN `identification` VARCHAR(15))  BEGIN    
    SELECT Client_id, Client_name, Client_identification FROM client WHERE Client_identification = identification;
END$$

DROP PROCEDURE IF EXISTS `sp_client_select_one`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_client_select_one` (IN `id` INT)  BEGIN
    SELECT Client_id, Client_name, Client_identification, Client_address, Client_tel, Client_email, Client_contactName, Client_contactTitle, Client_contactTel, Client_contactCel, Client_contactEmail, Stat_id FROM client WHERE Client_id = id;
END$$

DROP PROCEDURE IF EXISTS `sp_client_select_search`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_client_select_search` (IN `name` VARCHAR(100))  NO SQL
BEGIN
    IF name IS NULL THEN
        SELECT Client_id, Client_name, Client_identification, Client_tel, Client_email,Client_contactName, Client_contactCel, Client_contactEmail FROM client;
   ELSE
       SELECT Client_id, Client_name, Client_identification, Client_tel, Client_email,Client_contactName, Client_contactCel, Client_contactEmail FROM client WHERE Client_name LIKE CONCAT('%', name ,'%') OR Client_identification LIKE CONCAT('%', name ,'%');
   END IF;
END$$

DROP PROCEDURE IF EXISTS `sp_client_update_status`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_client_update_status` (IN `id` INT, IN `stat` INT)  NO SQL
BEGIN
	UPDATE client SET Stat_id = stat
    WHERE Client_id = id;
    SELECT ROW_COUNT();
END$$

DROP PROCEDURE IF EXISTS `sp_clone_client_quote`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_clone_client_quote` (IN `id` INT, IN `user` INT, IN `pre_id` INT)  NO SQL
BEGIN
INSERT INTO client(Client_name, Client_identification, Client_address, Client_tel, Client_email, Client_contactName, Client_contactTitle, Client_contactTel, Client_contactCel, Client_contactEmail, Stat_id) SELECT Pre_client_name, Pre_client_identification, Pre_client_address, Pre_client_tel, Pre_client_email, Pre_client_contactName, Pre_client_contactTitle, Pre_client_contactTel, Pre_client_contactCel, Pre_client_contactEmail, 8 FROM pre_client WHERE Pre_client_id=id;
SET @client_id = (SELECT LAST_INSERT_ID());
SET @consec = (SELECT CONCAT('COT_',COUNT(*)+1) AS Quo_consec FROM quote ORDER BY Quo_id DESC LIMIT 0, 1);
INSERT INTO quote(Client_id, Quo_consec, Quo_calendar, Quo_date, Quo_project, Quo_year, Quo_version, Quo_students, Quo_quantity, Quo_width, Quo_height, Quo_format, Quo_color, Quo_colorPaper, Quo_colorWeight, Quo_bw, Quo_bwPaper, Quo_bwWeight, Quo_inserts, Quo_guards, Quo_guardsPaper,  Quo_guardsWeight, Quo_cover, Quo_coverPaper, Quo_coverWeight, Quo_top, Quo_coverFinish, Quo_plast, Quo_correction, Quo_issn, Quo_observ, Quo_delivDate, Quo_delivPlace, User_id, Pro_id, Stat_id, Quo_pageTotal, Quo_inser, Quo_inserPaper, Quo_inserWeight)SELECT @client_id, @consec, Pre_quo_calendar, Pre_quo_date, Pre_quo_project, Pre_quo_year, Pre_quo_version, Pre_quo_students, Pre_quo_quantity, Pre_quo_width, Pre_quo_height, Pre_quo_format, Pre_quo_color, Pre_quo_colorPaper, Pre_quo_colorWeight, Pre_quo_bw, Pre_quo_bwPaper, Pre_quo_bwWeight, Pre_quo_inserts, Pre_quo_guards, Pre_quo_guardsPaper, Pre_quo_guardsWeight, Pre_quo_cover, Pre_quo_coverPaper, Pre_quo_coverWeight, Pre_quo_top, Pre_quo_coverFinish, Pre_quo_plast, Pre_quo_correction, Pre_quo_issn, Pre_quo_observ, Pre_quo_delivDate, Pre_quo_delivPlace, user, 1, 1, Pre_quo_pageTotal, Pre_quo_inser, Pre_quo_inserPaper, Pre_quo_inserWeight FROM pre_quote WHERE Pre_quo_id = pre_id;
DELETE FROM pre_quote WHERE Pre_quo_id = pre_id;
DELETE FROM pre_client WHERE Pre_client_id=id;
SELECT ROW_COUNT();
END$$

DROP PROCEDURE IF EXISTS `sp_costingDetail_insert`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_costingDetail_insert` (IN `costing_id` INT, IN `elem_id` INT, IN `quantity` INT, IN `Cvalue` DECIMAL(14,4))  BEGIN
	INSERT INTO costing_detail (Cost_id, Elem_id, Costd_quantity, Costd_value) VALUES (costing_id, elem_id, quantity, Cvalue);
    SELECT ROW_COUNT();
END$$

DROP PROCEDURE IF EXISTS `sp_costingDetail_select_one`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_costingDetail_select_one` (IN `id` INT)  BEGIN
	SELECT Costd_id, Elem_id, Costd_quantity, Costd_value 
    FROM costing_detail
    WHERE Cost_id = id;
END$$

DROP PROCEDURE IF EXISTS `sp_costingDetail_update`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_costingDetail_update` (IN `id` INT, IN `elem_id` INT, IN `quantity` INT, IN `Cvalue` DECIMAL(14,4))  NO SQL
BEGIN
	UPDATE costing_detail SET Elem_id = elem_id, Costd_quantity = quantity, Costd_value = Cvalue
    WHERE Costd_id = id;
    SELECT ROW_COUNT();
END$$

DROP PROCEDURE IF EXISTS `sp_costing_insert_update`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_costing_insert_update` (IN `id` INT, IN `total` DECIMAL(14,2), IN `attach` BLOB, IN `pagValue` DECIMAL(14,2), IN `impQuantity` DECIMAL(5,2), IN `impValue` DECIMAL(14,2), IN `phoQuantity` DECIMAL(5,2), IN `phoValue` DECIMAL(14,2), IN `issnQuantity` DECIMAL(5,2), IN `issnValue` DECIMAL(14,2), IN `sendQuantity` DECIMAL(5,2), IN `sendValue` DECIMAL(14,2), IN `stuValue` DECIMAL(14,2), IN `admin` DECIMAL(5,2), IN `utility` DECIMAL(5,2), IN `incid` DECIMAL(5,2), IN `perQuantity` DECIMAL(5,2), IN `perValue` DECIMAL(14,2), IN `finalValue` DECIMAL(14,2), IN `daysQuantity` DECIMAL(5,2), IN `daysValue` DECIMAL(14,2), IN `description` VARCHAR(1000), IN `stuValue1` DECIMAL(14,2))  BEGIN
	SET @exist = (SELECT COUNT(Quo_id) FROM costing WHERE Quo_id = id); 
    IF @exist = 0 THEN 
		INSERT INTO costing (Quo_id, Cost_totalValue, Cost_pagValue, Cost_impQuantity, Cost_impValue, Cost_phoQuantity, Cost_phoValue, Cost_issnQuantity, Cost_issnValue, Cost_sendQuantity, Cost_sendValue, Cost_stuValue, Cost_perQuantity, Cost_perValue, Cost_daysQuantity, Cost_daysValue, Cost_admin, Cost_incid, Cost_utili, Cost_finalValue, Cost_attach, Cost_description, Cost_stuValue1) 
    VALUES (id, total, pagValue, impQuantity, impValue, phoQuantity, phoValue, issnQuantity, issnValue, sendQuantity, sendValue, stuValue, perQuantity, perValue, daysQuantity, daysValue, admin, incid, utility, finalValue, attach, description, stuValue1);
    ELSE 
    	UPDATE costing SET Cost_totalValue = total, Cost_pagValue = pagValue, Cost_impQuantity = impQuantity, Cost_impValue = impValue, Cost_phoQuantity = phoQuantity, Cost_phoValue = phoValue, Cost_issnQuantity = issnQuantity, Cost_issnValue = issnValue, Cost_sendQuantity = sendQuantity, Cost_sendValue = sendValue, Cost_stuValue = stuValue, Cost_perQuantity = perQuantity, Cost_perValue = perValue, Cost_daysQuantity = daysQuantity, Cost_daysValue = daysValue, Cost_admin = admin, Cost_incid = incid, Cost_utili = utility, Cost_finalValue = finalValue, Cost_attach = attach, Cost_description = description, Cost_stuValue1 = stuValue1
        WHERE Quo_id = id;
    END IF;
    UPDATE quote SET Stat_id = 3 WHERE Quo_id = id;
    SELECT ROW_COUNT(); 
END$$

DROP PROCEDURE IF EXISTS `sp_costing_select_one`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_costing_select_one` (IN `id` INT)  BEGIN
	SET @exist = (SELECT COUNT(Quo_id) FROM costing WHERE Quo_id = id);
    IF @exist = 0 THEN    
    SET @pag = (SELECT Elem_cost FROM element WHERE Elem_id = 1);
    SET @print = (SELECT Elem_cost FROM element WHERE Elem_id = 2);
    SET @phot = (SELECT Elem_cost FROM element WHERE Elem_id = 3);
    SET @issn = (SELECT Elem_cost FROM element WHERE Elem_id = 4);
    SET @send = (SELECT Elem_cost FROM element WHERE Elem_id = 5);
    SET @stu = (SELECT Elem_cost FROM element WHERE Elem_id = 6);
    SET @per = (SELECT Elem_cost FROM element WHERE Elem_id = 7);
    SET @days = (SELECT Elem_cost FROM element WHERE Elem_id = 9);
    INSERT INTO costing (Quo_id, Cost_pagValue, Cost_impQuantity, Cost_impValue, Cost_phoValue,Cost_issnValue, Cost_sendValue, Cost_stuValue, Cost_perValue, Cost_daysValue) VALUES (id, @pag,3,@print,@phot,@issn,@send,@stu,@per,@days);
    END IF;	
    	SELECT Q.Quo_id, Q.Quo_consec, Q.Quo_date, P.Pro_name, C.Cost_totalValue, Q.Quo_pageTotal, C.Cost_pagValue, C.Cost_impQuantity, C.Cost_impValue, C.Cost_phoQuantity, C.Cost_phoValue, Q.Quo_issn, C.Cost_issnQuantity, C.Cost_issnValue, C.Cost_sendQuantity, C.Cost_sendValue, Q.Quo_students, C.Cost_stuValue, C.Cost_perQuantity, C.Cost_perValue, C.Cost_daysQuantity, C.Cost_daysValue, C.Cost_admin, C.Cost_incid, C.Cost_utili, Q.Quo_quantity, C.Cost_finalValue, C.Cost_attach, C.Cost_description, C.Cost_stuValue1, Q.Stat_id 
        FROM costing C
        LEFT JOIN quote Q ON Q.Quo_id = C.Quo_id
        INNER JOIN provider P ON Q.Pro_id = P.Pro_id
        WHERE Q.Quo_id = id;    
END$$

DROP PROCEDURE IF EXISTS `sp_costing_update`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_costing_update` (IN `id` INT, IN `priting` VARCHAR(100), IN `total` DECIMAL(14,4), IN `admin` DECIMAL(5,2), IN `incid` DECIMAL(5,2), IN `utility` DECIMAL(5,2), IN `attach` BLOB)  NO SQL
BEGIN
	UPDATE costing  SET Cost_priting = priting, Cost_totalValue = total, Cost_admin = admin, Cost_incid = incid, Cost_utili = utility, Cost_attach = attach
    WHERE Cost_id = id;
    SELECT ROW_COUNT();
END$$

DROP PROCEDURE IF EXISTS `sp_credit_form_all`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_credit_form_all` (IN `name` VARCHAR(100))  BEGIN
	IF name IS NULL THEN
		SELECT CR.Cre_id, CR.Cre_consecutive, CR.Cre_requestDate, CR.Cre_pIdentification, CONCAT(CR.Cre_pLastname1, " ", CR.Cre_pLastname2, " ", CR.Cre_pName1, " ", CR.Cre_pName2) AS Cre_pName, CR.Cre_pEmail, CR.Cre_pCell FROM credit CR 
    WHERE Stat_id = 10
    ORDER BY CR.Cre_requestDate DESC;        
  ELSE
    SELECT CR.Cre_id, CR.Cre_consecutive, CR.Cre_requestDate, CR.Cre_pIdentification, CONCAT(CR.Cre_pLastname1, " ", CR.Cre_pLastname2, " ", CR.Cre_pName1, " ", CR.Cre_pName2) AS Cre_pName, CR.Cre_pEmail, CR.Cre_pCell FROM credit CR 
    WHERE (CR.Cre_requestDate LIKE CONCAT('%', name ,'%') OR CR.Cre_pLastname1 LIKE CONCAT('%', name ,'%') OR CR.Cre_pLastname2 LIKE CONCAT('%', name ,'%') OR CR.Cre_pName1 LIKE CONCAT('%', name ,'%') OR CR.Cre_pName2 LIKE CONCAT('%', name ,'%') OR CR.Cre_pIdentification LIKE CONCAT('%', name ,'%') OR CR.Cre_pEmail LIKE CONCAT('%', name ,'%') OR CR.Cre_pCell LIKE CONCAT('%', name ,'%')) AND Stat_id = 10
    ORDER BY CR.Cre_requestDate DESC;
  END IF;
END$$

DROP PROCEDURE IF EXISTS `sp_credit_form_insert`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_credit_form_insert` (IN `servIp` VARCHAR(100), IN `hostHead` VARCHAR(600), IN `webHead` VARCHAR(600), IN `requestIp` VARCHAR(100), IN `requestPort` VARCHAR(10), IN `hash` VARCHAR(600), IN `requestDate` VARCHAR(100), IN `city` VARCHAR(100), IN `requestType` VARCHAR(50), IN `creditProduct` VARCHAR(50), IN `amount` VARCHAR(10), IN `creditLine` VARCHAR(100), IN `pickUp` VARCHAR(10), IN `term` VARCHAR(10), IN `pLastname1` VARCHAR(100), IN `pLastname2` VARCHAR(100), IN `pName1` VARCHAR(100), IN `pName2` VARCHAR(100), IN `pDocType` VARCHAR(10), IN `pIdentification` VARCHAR(20), IN `pExpDate` VARCHAR(100), IN `pExpPlace` VARCHAR(100), IN `pBornDate` VARCHAR(100), IN `pTownship` VARCHAR(100), IN `pDepartment` VARCHAR(100), IN `pNacionality` VARCHAR(100), IN `pCivilStatus` VARCHAR(100), IN `pGender` VARCHAR(100), IN `pDependents` VARCHAR(2), IN `pProfession` VARCHAR(300), IN `pEducationLevel` VARCHAR(100), IN `pLivingplaceType` VARCHAR(100), IN `pResAddress` VARCHAR(300), IN `pResTel` VARCHAR(30), IN `pCell` VARCHAR(30), IN `department` VARCHAR(100), IN `pResCity` VARCHAR(100), IN `pCorrespondence` VARCHAR(100), IN `pCellNotify` VARCHAR(100), IN `pEmail` VARCHAR(300), IN `sLastname1` VARCHAR(100), IN `sLastname2` VARCHAR(100), IN `sName1` VARCHAR(100), IN `sName2` VARCHAR(100), IN `sDocType` VARCHAR(10), IN `sIdentification` VARCHAR(20), IN `sCell` VARCHAR(30), IN `wCompName` VARCHAR(300), IN `wCompTel` VARCHAR(30), IN `wCompTelExt` VARCHAR(30), IN `wCompFax` VARCHAR(30), IN `wDepartment` VARCHAR(100), IN `wCity` VARCHAR(100), IN `wCompDir` VARCHAR(300), IN `wAdmiDate` VARCHAR(100), IN `wContractType` VARCHAR(100), IN `wCharge` VARCHAR(100), IN `wCivilServant` VARCHAR(100), IN `wPubResourAdmin` VARCHAR(10), IN `wPubPerson` VARCHAR(10), IN `wCIIUDesc` VARCHAR(300), IN `wCIIUCode` VARCHAR(20), IN `monthlyInc` VARCHAR(10), IN `monthlyEgr` VARCHAR(10), IN `immovabAssets` VARCHAR(10), IN `othersInc` VARCHAR(10), IN `descEgr` VARCHAR(300), IN `vehiclesAssets` VARCHAR(10), IN `othersDescInc` VARCHAR(300), IN `totalEgr` VARCHAR(10), IN `othersAssets` VARCHAR(10), IN `totalInc` VARCHAR(10), IN `totalAssets` VARCHAR(10), IN `totalLiabilities` VARCHAR(10), IN `totalHeritage` VARCHAR(10), IN `lpType` VARCHAR(100), IN `lpOwner` VARCHAR(100), IN `lpValue` VARCHAR(15), IN `lpMortgage` VARCHAR(10), IN `lpInFavorOf` VARCHAR(100), IN `vehicle` VARCHAR(10), IN `vBrand` VARCHAR(100), IN `vModel` VARCHAR(100), IN `vPlate` VARCHAR(30), IN `vType` VARCHAR(100), IN `vGarment` VARCHAR(10), IN `vFavorOf` VARCHAR(100), IN `vComercialValue` VARCHAR(15), IN `frName` VARCHAR(100), IN `frCity` VARCHAR(100), IN `frPhone` VARCHAR(30), IN `frRelationship` VARCHAR(100), IN `prName` VARCHAR(100), IN `prCity` VARCHAR(100), IN `prTel` VARCHAR(30), IN `prCel` VARCHAR(30), IN `fctransactions` VARCHAR(100), IN `fcWhich` VARCHAR(300), IN `fcAccount` VARCHAR(10), IN `fcAccountNumber` VARCHAR(100), IN `fcBank` VARCHAR(300), IN `fcCurrency` VARCHAR(100), IN `fcCity` VARCHAR(100), IN `fcCountry` VARCHAR(100), IN `fcTransactionType` VARCHAR(100), IN `fcWichTransac` VARCHAR(300), IN `oName` VARCHAR(100), IN `oAccount` VARCHAR(10), IN `oEntity` VARCHAR(100), IN `oAccountNumber` VARCHAR(100), IN `oCheckFor` VARCHAR(100), IN `oIdentification` VARCHAR(20), IN `oValue` VARCHAR(15))  BEGIN
  INSERT INTO credit(Cre_servIp, Cre_hostHead, Cre_webHead, Cre_requestIp, Cre_requestPort, Cre_hash, Cre_requestDate, Cre_city, Cre_requestType,
  Cre_creditProduct, Cre_amount, Cre_creditLine, Cre_pickUp, Cre_term, Cre_pLastname1, Cre_pLastname2, Cre_pName1, Cre_pName2, Cre_pDocType,
  Cre_pIdentification, Cre_pExpDate, Cre_pExpPlace, Cre_pBornDate, Cre_pTownship, Cre_pDepartment, Cre_pNacionality, Cre_pCivilStatus, Cre_pGender,
  Cre_pDependents, Cre_pProfession, Cre_pEducationLevel, Cre_pLivingplaceType, Cre_pResAddress, Cre_pResTel, Cre_pCell, Cre_department, Cre_pResCity,
  Cre_pCorrespondence, Cre_pCellNotify, Cre_pEmail, Cre_sLastname1, Cre_sLastname2, Cre_sName1, Cre_sName2, Cre_sDocType, Cre_sIdentification,
  Cre_sCell, Cre_wCompName, Cre_wCompTel, Cre_wCompTelExt, Cre_wCompFax, Cre_wDepartment, Cre_wCity, Cre_wCompDir, Cre_wAdmiDate, Cre_wContractType,
  Cre_wCharge, Cre_wCivilServant, Cre_wPubResourAdmin, Cre_wPubPerson, Cre_wCIIUDesc, Cre_wCIIUCode, Cre_monthlyInc, Cre_monthlyEgr, Cre_immovabAssets,
  Cre_othersInc, Cre_descEgr, Cre_vehiclesAssets, Cre_othersDescInc, Cre_totalEgr, Cre_othersAssets, Cre_totalInc, Cre_totalAssets, Cre_totalLiabilities,
  Cre_totalHeritage, Cre_lpType, Cre_lpOwner, Cre_lpValue, Cre_lpMortgage, Cre_lpInFavorOf, Cre_vehicle, Cre_vBrand, Cre_vModel, Cre_vPlate,
  Cre_vType, Cre_vGarment, Cre_vFavorOf, Cre_vComercialValue, Cre_frName, Cre_frCity, Cre_frPhone, Cre_frRelationship, Cre_prName, Cre_prCity,
  Cre_prTel, Cre_prCel, Cre_fctransactions, Cre_fcWhich, Cre_fcAccount, Cre_fcAccountNumber, Cre_fcBank, Cre_fcCurrency, Cre_fcCity, Cre_fcCountry,
  Cre_fcTransactionType, Cre_fcWichTransac, Cre_oName, Cre_oAccount, Cre_oEntity, Cre_oAccountNumber, Cre_oCheckFor, Cre_oIdentification, Cre_oValue, Stat_id) 
  VALUES (servIp, hostHead, webHead, requestIp, requestPort, hash, requestDate, city, requestType, creditProduct, amount, creditLine, pickUp, term, 
  pLastname1, pLastname2, pName1, pName2, pDocType, pIdentification, pExpDate, pExpPlace, pBornDate, pTownship, pDepartment, pNacionality, 
  pCivilStatus, pGender, pDependents, pProfession, pEducationLevel, pLivingplaceType, pResAddress, pResTel, pCell, department, pResCity, 
  pCorrespondence, pCellNotify, pEmail, sLastname1, sLastname2, sName1, sName2, sDocType, sIdentification, sCell, wCompName, wCompTel, 
  wCompTelExt, wCompFax, wDepartment, wCity, wCompDir, wAdmiDate, wContractType, wCharge, wCivilServant, wPubResourAdmin, wPubPerson, 
  wCIIUDesc, wCIIUCode, monthlyInc, monthlyEgr, immovabAssets, othersInc, descEgr, vehiclesAssets, othersDescInc, totalEgr, othersAssets, 
  totalInc, totalAssets, totalLiabilities, totalHeritage, lpType, lpOwner, lpValue, lpMortgage, lpInFavorOf, vehicle, vBrand, vModel, vPlate, 
  vType, vGarment, vFavorOf, vComercialValue, frName, frCity, frPhone, frRelationship, prName, prCity, prTel, prCel, fctransactions, 
  fcWhich, fcAccount, fcAccountNumber, fcBank, fcCurrency, fcCity, fcCountry, fcTransactionType, fcWichTransac, oName, oAccount, oEntity, 
  oAccountNumber, oCheckFor, oIdentification, oValue, 10);
  SET @id = (SELECT LAST_INSERT_ID());
  UPDATE credit SET Cre_consecutive =  CONCAT('Crédito_',@id) WHERE Cre_id = @id;
  SELECT @id AS Cre_id;
END$$

DROP PROCEDURE IF EXISTS `sp_credit_form_security`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_credit_form_security` (IN `id` INT)  BEGIN
	SELECT Cre_servIp, Cre_servDate, Cre_hostHead, Cre_webHead, Cre_requestIp, Cre_requestPort, Cre_hash
    FROM credit
    WHERE Cre_id = id;
END$$

DROP PROCEDURE IF EXISTS `sp_credit_form_view`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_credit_form_view` (IN `id` INT)  BEGIN 
	SELECT Cre_id, Cre_consecutive, Cre_requestDate, Cre_city, Cre_requestType, Cre_creditProduct, Cre_amount, Cre_creditLine, Cre_pickUp, Cre_term, 
  Cre_pLastname1, Cre_pLastname2, Cre_pName1, Cre_pName2, Cre_pDocType, Cre_pIdentification, Cre_pExpDate, Cre_pExpPlace, Cre_pBornDate, 
  Cre_pTownship, Cre_pDepartment, Cre_pNacionality, Cre_pCivilStatus, Cre_pGender, Cre_pDependents, Cre_pProfession, Cre_pEducationLevel, 
  Cre_pLivingplaceType, Cre_pResAddress, Cre_pResTel, Cre_pCell, Cre_department, Cre_pResCity, Cre_pCorrespondence, Cre_pCellNotify, 
  Cre_pEmail, Cre_sLastname1, Cre_sLastname2, Cre_sName1, Cre_sName2, Cre_sDocType, Cre_sIdentification, Cre_sCell, Cre_wCompName, 
  Cre_wCompTel, Cre_wCompTelExt, Cre_wCompFax, Cre_wDepartment, Cre_wCity, Cre_wCompDir, Cre_wAdmiDate, Cre_wContractType, Cre_wCharge, 
  Cre_wCivilServant, Cre_wPubResourAdmin, Cre_wPubPerson, Cre_wCIIUDesc, Cre_wCIIUCode, Cre_monthlyInc, Cre_monthlyEgr, Cre_immovabAssets, 
  Cre_othersInc, Cre_descEgr, Cre_vehiclesAssets, Cre_othersDescInc, Cre_totalEgr, Cre_othersAssets, Cre_totalInc, Cre_totalAssets, 
  Cre_totalLiabilities, Cre_totalHeritage, Cre_lpType, Cre_lpOwner, Cre_lpValue, Cre_lpMortgage, Cre_lpInFavorOf, Cre_vehicle, Cre_vBrand, 
  Cre_vModel, Cre_vPlate, Cre_vType, Cre_vGarment, Cre_vFavorOf, Cre_vComercialValue, Cre_frName, Cre_frCity, Cre_frPhone, Cre_frRelationship, 
  Cre_prName, Cre_prCity, Cre_prTel, Cre_prCel, Cre_fctransactions, Cre_fcWhich, Cre_fcAccount, Cre_fcAccountNumber, Cre_fcBank, 
  Cre_fcCurrency, Cre_fcCity, Cre_fcCountry, Cre_fcTransactionType, Cre_fcWichTransac, Cre_oName, Cre_oAccount, Cre_oEntity, 
  Cre_oAccountNumber, Cre_oCheckFor, Cre_oIdentification, Cre_oValue, Stat_id 
    FROM credit 
    WHERE Cre_id = id;
END$$

DROP PROCEDURE IF EXISTS `sp_data_provision`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_data_provision` (IN `obligation_cod_` VARCHAR(80))  BEGIN
SET @cuote = (SELECT COUNT(pay_obligation_actual_cuote)+1 FROM pay_obligation WHERE obligation_cod = obligation_cod_);
SET @date = (SELECT pay_date FROM obligation WHERE obligation_cod = obligation_cod_);
SELECT obligation_id, client_idmax, client_name, client_contract, BA.Bank_name, credit_type_id, interesting_type_id, amortization_type_id, desembolso_date, initial_value, cuotes_number, residual_number, IT.interest_dtf AS 'dtf', IT.interest_ibr AS 'ibr', dtf_points, ibr_points, fixed_rate, Stat_id, obligation_cod, pay_date, FORMAT(initial_value,2,'de_DE') AS 'initial_value_format', FORMAT(residual_number,2,'de_DE') AS 'residual_number_format' , @cuote AS 'pay_obligation_actual_cuote' FROM obligation OB 
CROSS JOIN interest IT 
INNER JOIN bank BA
ON BA.Bank_id = OB.Bank_id
WHERE obligation_cod = obligation_cod_ and IT.interest_date = DATE_SUB(@date,INTERVAL 1 MONTH);
    END$$

DROP PROCEDURE IF EXISTS `sp_date_provision`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_date_provision` (IN `obligation_cod_` VARCHAR(80), IN `pay_date_notif_` DATE)  BEGIN
SELECT pay_obligation_id,PO.obligation_cod,PO.pay_date_notif, pay_interesting_value
 FROM pay_obligation PO 
 INNER JOIN obligation O 
 ON PO.obligation_cod=O.obligation_cod 
 WHERE PO.Stat_id = 8 AND PO.obligation_cod = obligation_cod_ AND PO.pay_date_notif = pay_date_notif_
 ORDER BY PO.pay_obligation_id ASC;
    END$$

DROP PROCEDURE IF EXISTS `sp_delete_client_quote`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_delete_client_quote` (IN `id_cli` INT, IN `id_quo` INT)  NO SQL
BEGIN
DELETE FROM pre_quote WHERE Pre_quo_id = id_quo;
DELETE FROM pre_client WHERE Pre_client_id = id_cli;
END$$

DROP PROCEDURE IF EXISTS `sp_element_insert`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_element_insert` (IN `name` VARCHAR(100), IN `cost` DECIMAL(14,4))  NO SQL
BEGIN
	INSERT INTO element(Elem_name, Elem_cost) VALUES (name, cost);
    SELECT ROW_COUNT();
END$$

DROP PROCEDURE IF EXISTS `sp_element_update`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_element_update` (IN `id` INT, IN `name` VARCHAR(100), IN `cost` DECIMAL(14,4))  NO SQL
BEGIN
	UPDATE element SET Elem_name = name, Elem_cost = cost
    WHERE Elem_id = id;
    SELECT ROW_COUNT();
END$$

DROP PROCEDURE IF EXISTS `sp_get_code_quote`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_code_quote` ()  BEGIN
	SET @consec = (SELECT CAST(SUBSTRING(Quo_consec, 5) AS UNSIGNED) AS Number FROM quote ORDER BY Number DESC LIMIT 1);
    IF @consec IS NULL THEN
    	SET @consec = 0;
    END IF;
	SELECT CONCAT('COT_',@consec+1) AS Quo_consec;
END$$

DROP PROCEDURE IF EXISTS `sp_get_pre_code_quote`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_pre_code_quote` ()  BEGIN
	SET @consec = (SELECT CAST(SUBSTRING(Pre_quo_consec, 5) AS UNSIGNED) AS Number FROM pre_quote ORDER BY Number DESC LIMIT 1);
    IF @consec IS NULL THEN
    	SET @consec = 0;
    END IF;
	SELECT CONCAT('PRE_',@consec+1) AS Pre_quo_consec;
END$$

DROP PROCEDURE IF EXISTS `sp_insert_update_obligation`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insert_update_obligation` ()  BEGIN
    SET @exist = (SELECT COUNT(Client_id)FROM client WHERE Client_id = id); 
    IF @exist = 0 THEN 
		INSERT INTO client (Client_name, Client_identification, Client_address, Client_tel, Client_email, Client_contactName, Client_contactTitle, Client_contactTel, Client_contactCel, Client_contactEmail, Stat_id) VALUES (name, identification, address, tel, email, contactName, contactTitle, contactTel, contactCel, contactEmail, stat);
    ELSE
    	UPDATE client SET Client_identification = identification, Client_name = name, Client_address = address, Client_tel = tel, Client_email = email, Client_contactName = contactName, Client_contactTitle = contactTitle, Client_contactTel = contactTel, Client_contactCel = contactCel, Client_contactEmail = contactEmail, Stat_id = stat
        WHERE Client_id = id;
    END IF;
    SELECT ROW_COUNT();
END$$

DROP PROCEDURE IF EXISTS `sp_login`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_login` (IN `email` VARCHAR(200), IN `pass` VARCHAR(30))  BEGIN
 SET @mail = '';
 SET @password = '';
 SET @mail = (SELECT COUNT(u.User_email) FROM user u WHERE u.User_email LIKE email AND Stat_id=6);
 IF @mail > 0 THEN
      SET @ok = (SELECT COUNT(*) FROM login LO
        INNER JOIN user USU ON LO.User_id=USU.User_id
        WHERE USU.User_email=email AND LO.Login_password=pass);
   IF @ok > 0 THEN
         SELECT U.User_id, U.User_name, U.User_email FROM user U
            INNER JOIN login L ON U.User_id = L.User_id
            WHERE L.Login_password LIKE pass AND U.User_email like email;
   ELSE
       SELECT 0;
   END IF;
 ELSE
   SELECT 0;
 END IF;
END$$

DROP PROCEDURE IF EXISTS `sp_login_insert`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_login_insert` (IN `pass` VARCHAR(30), IN `user` INT)  BEGIN 
  INSERT INTO login(Login_password, User_id) VALUES (pass,user); 
  SELECT ROW_COUNT(); 
END$$

DROP PROCEDURE IF EXISTS `sp_login_update`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_login_update` (IN `id` SMALLINT, IN `pass` VARCHAR(600))  BEGIN 
  UPDATE login SET Login_password=pass WHERE User_id = id; 
  DELETE FROM recovery_password WHERE User_id=id;
  SELECT ROW_COUNT() AS Id_row;
END$$

DROP PROCEDURE IF EXISTS `sp_membership_form_all`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_membership_form_all` (IN `name` VARCHAR(100))  BEGIN
	IF name IS NULL THEN
		SELECT MEM.Mem_id, MEM.Mem_consecutive, MEM.Mem_requestDate, MEM.Mem_pIdentification, CONCAT(MEM.Mem_pLastname1, " ", MEM.Mem_pLastname2, " ", MEM.Mem_pName1, " ", MEM.Mem_pName2) AS Mem_pName, MEM.Mem_pEmail, MEM.Mem_pCell FROM membership MEM 
    WHERE Stat_id = 10
    ORDER BY MEM.Mem_requestDate DESC;        
  ELSE
    SELECT MEM.Mem_id, MEM.Mem_consecutive, MEM.Mem_requestDate, MEM.Mem_pIdentification, CONCAT(MEM.Mem_pLastname1, " ", MEM.Mem_pLastname2, " ", MEM.Mem_pName1, " ", MEM.Mem_pName2) AS Mem_pName, MEM.Mem_pEmail, MEM.Mem_pCell FROM membership MEM 
    WHERE (MEM.Mem_requestDate LIKE CONCAT('%', name ,'%') OR MEM.Mem_pLastname1 LIKE CONCAT('%', name ,'%') OR MEM.Mem_pLastname2 LIKE CONCAT('%', name ,'%') OR MEM.Mem_pName1 LIKE CONCAT('%', name ,'%') OR MEM.Mem_pName2 LIKE CONCAT('%', name ,'%') OR MEM.Mem_pIdentification LIKE CONCAT('%', name ,'%') OR MEM.Mem_pEmail LIKE CONCAT('%', name ,'%') OR MEM.Mem_pCell LIKE CONCAT('%', name ,'%')) AND Stat_id = 10
    ORDER BY MEM.Mem_requestDate DESC;
  END IF;
END$$

DROP PROCEDURE IF EXISTS `sp_membership_form_insert`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_membership_form_insert` (IN `servIp` VARCHAR(100), IN `hostHead` VARCHAR(600), IN `webHead` VARCHAR(600), IN `requestIp` VARCHAR(100), IN `requestPort` VARCHAR(10), IN `hash` VARCHAR(600), IN `requestType` VARCHAR(50), IN `requestDate` VARCHAR(100), IN `city` VARCHAR(100), IN `assoType` VARCHAR(100), IN `pLastname1` VARCHAR(100), IN `pLastname2` VARCHAR(100), IN `pName1` VARCHAR(100), IN `pName2` VARCHAR(100), IN `pDocType` VARCHAR(10), IN `pIdentification` VARCHAR(20), IN `pExpDate` VARCHAR(100), IN `pExpPlace` VARCHAR(100), IN `pGender` VARCHAR(100), IN `pBornDate` VARCHAR(100), IN `pNacionality` VARCHAR(100), IN `pTownship` VARCHAR(100), IN `pDepartment` VARCHAR(100), IN `pCivilStatus` VARCHAR(100), IN `pLivingplaceType` VARCHAR(100), IN `pResAddress` VARCHAR(300), IN `pStratum` VARCHAR(30), IN `pResTel` VARCHAR(30), IN `pCell` VARCHAR(30), IN `department` VARCHAR(100), IN `pResCity` VARCHAR(100), IN `pCorrespondence` VARCHAR(100), IN `pEmail` VARCHAR(300), IN `pProfession` VARCHAR(300), IN `pEducationLevel` VARCHAR(100), IN `sLastname1` VARCHAR(100), IN `sLastname2` VARCHAR(100), IN `sName1` VARCHAR(100), IN `sName2` VARCHAR(100), IN `sDocType` VARCHAR(10), IN `sIdentification` VARCHAR(20), IN `sCell` VARCHAR(30), IN `wCompName` VARCHAR(300), IN `wCompTel` VARCHAR(30), IN `wCompTelExt` VARCHAR(30), IN `wCompDir` VARCHAR(300), IN `wDepartment` VARCHAR(100), IN `wCity` VARCHAR(100), IN `wAdmiDate` VARCHAR(100), IN `wContractType` VARCHAR(100), IN `wCharge` VARCHAR(100), IN `wCivilServant` VARCHAR(100), IN `wPubResourAdmin` VARCHAR(10), IN `wPubPerson` VARCHAR(10), IN `lRPubPerson` VARCHAR(10), IN `wCompFax` VARCHAR(30), IN `wEmail` VARCHAR(300), IN `wCIIUDesc` VARCHAR(300), IN `wCIIUCode` VARCHAR(20), IN `monthlyInc` VARCHAR(10), IN `monthlyEgr` VARCHAR(10), IN `immovabAssets` VARCHAR(10), IN `othersInc` VARCHAR(10), IN `descEgr` VARCHAR(300), IN `vehiclesAssets` VARCHAR(10), IN `othersDescInc` VARCHAR(300), IN `totalEgr` VARCHAR(10), IN `othersAssets` VARCHAR(10), IN `totalInc` VARCHAR(10), IN `totalAssets` VARCHAR(10), IN `totalLiabilities` VARCHAR(10), IN `totalHeritage` VARCHAR(10), IN `fctransactions` VARCHAR(10), IN `fcWhich` VARCHAR(300), IN `fcAccount` VARCHAR(10), IN `fcAccountNumber` VARCHAR(100), IN `fcBank` VARCHAR(300), IN `fcCurrency` VARCHAR(100), IN `fcCity` VARCHAR(100), IN `fcCountry` VARCHAR(100), IN `fcTransactionType` VARCHAR(100), IN `fcWichTransac` VARCHAR(300))  BEGIN
  INSERT INTO membership(Mem_servIp, Mem_hostHead, Mem_webHead, Mem_requestIp, Mem_requestPort, Mem_hash, Mem_requestType, Mem_requestDate, 
  Mem_city, Mem_assoType, Mem_pLastname1, Mem_pLastname2, Mem_pName1, Mem_pName2, Mem_pDocType, Mem_pIdentification, Mem_pExpDate, 
  Mem_pExpPlace, Mem_pGender, Mem_pBornDate, Mem_pNacionality, Mem_pTownship, Mem_pDepartment, Mem_pCivilStatus, Mem_pLivingplaceType, 
  Mem_pResAddress, Mem_pStratum, Mem_pResTel, Mem_pCell, Mem_department, Mem_pResCity, Mem_pCorrespondence, Mem_pEmail, Mem_pProfession, 

  Mem_pEducationLevel, Mem_sLastname1, Mem_sLastname2, Mem_sName1, Mem_sName2, Mem_sDocType, Mem_sIdentification, Mem_sCell, Mem_wCompName, 
  Mem_wCompTel, Mem_wCompTelExt, Mem_wCompDir, Mem_wDepartment, Mem_wCity, Mem_wAdmiDate, Mem_wContractType, Mem_wCharge, 
  Mem_wCivilServant, Mem_wPubResourAdmin, Mem_wPubPerson, Mem_lRPubPerson, Mem_wCompFax, Mem_wEmail, Mem_wCIIUDesc, Mem_wCIIUCode, 
  Mem_monthlyInc, Mem_monthlyEgr, Mem_immovabAssets, Mem_othersInc, Mem_descEgr, Mem_vehiclesAssets, Mem_othersDescInc, Mem_totalEgr, 
  Mem_othersAssets, Mem_totalInc, Mem_totalAssets, Mem_totalLiabilities, Mem_totalHeritage, Mem_fctransactions, Mem_fcWhich, 
  Mem_fcAccount, Mem_fcAccountNumber, Mem_fcBank, Mem_fcCurrency, Mem_fcCity, Mem_fcCountry, Mem_fcTransactionType, Mem_fcWichTransac, Stat_id) 
  VALUES (servIp, hostHead, webHead, requestIp, requestPort, hash, requestType, requestDate, city, assoType, pLastname1, pLastname2, 
  pName1, pName2, pDocType, pIdentification, pExpDate, pExpPlace, pGender, pBornDate, pNacionality, pTownship, pDepartment, pCivilStatus, 
  pLivingplaceType, pResAddress, pStratum, pResTel, pCell, department, pResCity, pCorrespondence, pEmail, pProfession, pEducationLevel, 
  sLastname1, sLastname2, sName1, sName2, sDocType, sIdentification, sCell, wCompName, wCompTel, wCompTelExt, wCompDir, wDepartment, 
  wCity, wAdmiDate, wContractType, wCharge, wCivilServant, wPubResourAdmin, wPubPerson, lRPubPerson, wCompFax, wEmail, wCIIUDesc, 
  wCIIUCode, monthlyInc, monthlyEgr, immovabAssets, othersInc, descEgr, vehiclesAssets, othersDescInc, totalEgr, othersAssets, totalInc, 
  totalAssets, totalLiabilities, totalHeritage, fctransactions, fcWhich, fcAccount, fcAccountNumber, fcBank, fcCurrency, fcCity, 
  fcCountry, fcTransactionType, fcWichTransac, 10);  
  SET @id = (SELECT LAST_INSERT_ID());
  UPDATE membership SET Mem_consecutive =  CONCAT('Afiliación_',@id) WHERE Mem_id = @id;
  SELECT @id AS Mem_id;
END$$

DROP PROCEDURE IF EXISTS `sp_membership_form_security`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_membership_form_security` (IN `id` INT)  BEGIN
	SELECT Mem_servIp, Mem_servDate, Mem_hostHead, Mem_webHead, Mem_requestIp, Mem_requestPort, Mem_hash
    FROM membership
    WHERE Mem_id = id;
END$$

DROP PROCEDURE IF EXISTS `sp_membership_form_view`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_membership_form_view` (IN `id` INT)  BEGIN 
	SELECT Mem_id, Mem_consecutive, Mem_requestType, Mem_requestDate, Mem_city, Mem_assoType, Mem_pLastname1, Mem_pLastname2, Mem_pName1, Mem_pName2, 
  Mem_pDocType, Mem_pIdentification, Mem_pExpDate, Mem_pExpPlace, Mem_pGender, Mem_pBornDate, Mem_pNacionality, Mem_pTownship, 
  Mem_pDepartment, Mem_pCivilStatus, Mem_pLivingplaceType, Mem_pResAddress, Mem_pStratum, Mem_pResTel, Mem_pCell, Mem_department, 
  Mem_pResCity, Mem_pCorrespondence, Mem_pEmail, Mem_pProfession, Mem_pEducationLevel, Mem_sLastname1, Mem_sLastname2, Mem_sName1, 
  Mem_sName2, Mem_sDocType, Mem_sIdentification, Mem_sCell, Mem_wCompName, Mem_wCompTel, Mem_wCompTelExt, Mem_wCompDir, Mem_wDepartment, 
  Mem_wCity, Mem_wAdmiDate, Mem_wContractType, Mem_wCharge, Mem_wCivilServant, Mem_wPubResourAdmin, Mem_wPubPerson, Mem_lRPubPerson,
   Mem_wCompFax, Mem_wEmail, Mem_wCIIUDesc, Mem_wCIIUCode, Mem_monthlyInc, Mem_monthlyEgr, Mem_immovabAssets, Mem_othersInc, Mem_descEgr, 
   Mem_vehiclesAssets, Mem_othersDescInc, Mem_totalEgr, Mem_othersAssets, Mem_totalInc, Mem_totalAssets, Mem_totalLiabilities, 
   Mem_totalHeritage, Mem_fctransactions, Mem_fcWhich, Mem_fcAccount, Mem_fcAccountNumber, Mem_fcBank, Mem_fcCurrency, Mem_fcCity, 
   Mem_fcCountry, Mem_fcTransactionType, Mem_fcWichTransac, Stat_id 
   FROM membership 
   WHERE Mem_id = id;   
END$$

DROP PROCEDURE IF EXISTS `sp_new_user_active`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_new_user_active` (IN `n_hash` VARCHAR(600))  BEGIN 
SET @valid =(SELECT TIMESTAMPDIFF(MINUTE,NOW() ,DATE_ADD(Nuser_date,INTERVAL 24 HOUR)) AS Recover_difference FROM new_user WHERE Nuser_hash = n_hash);
IF @valid >= 0 THEN 
  SET @idUser = (SELECT User_id FROM new_user WHERE Nuser_hash = n_hash);
  UPDATE user SET Stat_id = 6 WHERE User_id = @idUser;
  DELETE FROM new_user WHERE User_id = @idUser;
  SELECT ROW_COUNT();
  ELSE
  SELECT "expire" AS Error_id;
 END IF; 
END$$

DROP PROCEDURE IF EXISTS `sp_new_user_insert_update`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_new_user_insert_update` (IN `us_id` INT(11), IN `n_date` VARCHAR(100), IN `n_hash` VARCHAR(600), IN `n_status` INT)  BEGIN 
	SET @count = (SELECT COUNT(User_id) FROM new_user WHERE User_id = us_id);
    IF @count = 0 THEN
    	INSERT INTO new_user (Nuser_id, User_id, Nuser_date, Nuser_hash, Nuser_state) VALUES (NULL, us_id, n_date, n_hash, n_status);
    ELSE
    	UPDATE new_user SET Nuser_date = n_date, Nuser_hash = n_hash, Nuser_state = n_status WHERE User_id = us_id;
    END IF;
    SELECT ROW_COUNT();
END$$

DROP PROCEDURE IF EXISTS `sp_obligation_insert_update`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_obligation_insert_update` (IN `id_` INT, IN `client_idmax_` VARCHAR(25), IN `client_name_` VARCHAR(25), IN `client_contract_` VARCHAR(25), IN `Bank_id_` INT, IN `credit_type_id_` INT, IN `interesting_type_id_` INT, IN `amortization_type_id_` INT, IN `desembolso_date_` VARCHAR(30), IN `initial_value_` DOUBLE, IN `cuotes_number_` INT, IN `residual_number_` DOUBLE, IN `dtf_` FLOAT, IN `dtf_points_` FLOAT, IN `ibr_` FLOAT, IN `ibr_points_` FLOAT, IN `fixed_rate_` FLOAT, IN `Stat_id_` INT, IN `obligation_cod_` VARCHAR(80), IN `pay_date_` VARCHAR(30))  BEGIN
    SET @exist = id_ ;  
    IF @exist = 0 THEN 
    INSERT INTO obligation (client_idmax, client_name, client_contract, Bank_id, credit_type_id,interesting_type_id, amortization_type_id, desembolso_date, initial_value, cuotes_number,  residual_number, dtf, dtf_points, ibr, ibr_points, fixed_rate,Stat_id, obligation_cod, pay_date) VALUES (client_idmax_,client_name_,client_contract_,Bank_id_,credit_type_id_,interesting_type_id_,amortization_type_id_,desembolso_date_,initial_value_,cuotes_number_,residual_number_,dtf_,dtf_points_,ibr_,ibr_points_,fixed_rate_,Stat_id_,obligation_cod_,pay_date_);
    ELSE
    UPDATE obligation SET client_idmax=client_idmax_,client_name=client_name_,client_contract=client_contract_,Bank_id=Bank_id_,credit_type_id=credit_type_id_,interesting_type_id=interesting_type_id_,amortization_type_id=amortization_type_id_, Stat_id=Stat_id_, pay_date=pay_date_ WHERE obligation_id=id_;
    END IF;
    SELECT ROW_COUNT();
     
END$$

DROP PROCEDURE IF EXISTS `sp_obligation_search`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_obligation_search` (IN `data_` VARCHAR(80))  BEGIN
        SELECT obligation_cod,client_idmax,client_name,client_contract,OB.Bank_id,BA.Bank_name,
obligation_id,OB.Stat_id,ST.Stat_name
        FROM obligation OB
        INNER JOIN bank BA
        ON OB.Bank_id=BA.Bank_id 
        INNER JOIN status ST
        ON OB.Stat_id=ST.Stat_id
        WHERE client_name 
        LIKE CONCAT('%', data_ , '%') OR client_idmax 
        LIKE CONCAT('%', data_ , '%') OR obligation_cod 
        LIKE CONCAT('%', data_ , '%') OR Stat_name 
        LIKE CONCAT('%', data_ , '%')
        ORDER BY desembolso_date ASC;
    END$$

DROP PROCEDURE IF EXISTS `sp_obligation_select`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_obligation_select` ()  BEGIN
    SELECT obligation_cod,client_idmax,client_name,client_contract,OB.Bank_id,BA.Bank_name,obligation_id,OB.Stat_id,ST.Stat_name
    	FROM obligation OB
        INNER JOIN bank BA 
        ON OB.Bank_id=BA.Bank_id
        INNER JOIN status ST
        ON OB.Stat_id=ST.Stat_id
        WHERE OB.Stat_id=3
        ORDER BY desembolso_date ASC;
    END$$

DROP PROCEDURE IF EXISTS `sp_obligation_select_update`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_obligation_select_update` (IN `obligation_cod_` VARCHAR(80))  BEGIN
    SELECT obligation_id, client_idmax, client_name, client_contract, Bank_id, credit_type_id, interesting_type_id, amortization_type_id, desembolso_date, initial_value, cuotes_number, residual_number, dtf, dtf_points, ibr, ibr_points, fixed_rate, Stat_id, obligation_cod, pay_date, FORMAT(initial_value,2,'de_DE') AS 'initial_value_format', FORMAT(residual_number,2,'de_DE') AS 'residual_number_format' FROM obligation 
    WHERE obligation_cod=obligation_cod_ AND Stat_id=3; 
END$$

DROP PROCEDURE IF EXISTS `sp_pay_for_provision`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_pay_for_provision` ()  BEGIN
SELECT pay_obligation_id,PO.obligation_cod,O.client_name,PO.pay_date_notif, pay_interesting_value
 FROM pay_obligation PO 
 INNER JOIN obligation O 
 ON PO.obligation_cod=O.obligation_cod 
 INNER JOIN status ST 
 ON PO.Stat_id=ST.Stat_id 
 INNER JOIN bank BA 
 ON O.Bank_id=BA.Bank_id 
 WHERE PO.Stat_id = 8 
 ORDER BY PO.pay_Date ASC;
    END$$

DROP PROCEDURE IF EXISTS `sp_pay_obligation`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_pay_obligation` ()  BEGIN
SELECT O.obligation_cod,O.client_name,BA.Bank_name,initial_value,O.cuotes_number, pay_obligation_actual_cuote, pay_date_notif,pay_value,pay_capital_value,pay_residue,pay_interesting_value,ST.Stat_name,PO.Stat_id 
 FROM pay_obligation PO 
 INNER JOIN obligation O 
 ON PO.obligation_cod=O.obligation_cod 
 INNER JOIN status ST 
 ON PO.Stat_id=ST.Stat_id 
 INNER JOIN bank BA 
 ON O.Bank_id=BA.Bank_id 
 WHERE PO.Stat_id = 9 
 ORDER BY pay_date_notif ASC;
    END$$

DROP PROCEDURE IF EXISTS `sp_pay_obligation_insert_update`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_pay_obligation_insert_update` (IN `id_` INT, IN `obligation_cod_` VARCHAR(80), IN `pay_obligation_actual_cuote_` INT, IN `pay_Dtf_` FLOAT, IN `pay_Ibr_` FLOAT, IN `pay_FixedRate_` DOUBLE, IN `pay_value_` DOUBLE, IN `pay_capital_value_` DOUBLE, IN `pay_residue_` DOUBLE, IN `pay_interesting_value_` DOUBLE, IN `pay_observation_` VARCHAR(500), IN `pay_Date_` VARCHAR(80))  BEGIN
    SET @exist = id_ ;
    SET @porPagar = 9;
    SET @countCode = (SELECT COUNT(obligation_cod) FROM pay_obligation WHERE obligation_cod = obligation_cod_ AND Stat_id = @porPagar);  
    SET @date = pay_Date_;

    SET @days = DATEDIFF(DATE_ADD(@date,INTERVAL 1 MONTH),@date); 
    
    SET @treintauno = DATE_ADD(@date,INTERVAL 1 MONTH);
    SET @ultDia = LAST_DAY(@treintauno);

    SET @dayOfMonth = DAYOFMONTH(@date);
    SET @fechaDesembolso = (SELECT desembolso_date FROM obligation WHERE obligation_cod = obligation_cod_);
    SET @dayOfMonthDateDesembolso = DAYOFMONTH(@fechaDesembolso);
    
    SET @fechaPago = DATE_ADD(@date,INTERVAL 1 MONTH);
    SET @mesPago = MONTH(@fechaPago);
    SET @diaproxPago = DAYOFMONTH(@fechaPago);
    SET @mesProxPago = MONTH(@fechaPago);
    SET @anoProxPago = YEAR(@fechaPago);
    SET @concatenacion = CONCAT(@dayOfMonthDateDesembolso,',',@mesProxPago,',',@anoProxPago);
    SET @fechaFinal = IF(@dayOfMonthDateDesembolso > @diaproxPago,STR_TO_DATE(@concatenacion, '%d,%m,%Y'),@fechaPago);

    IF @exist = 0 THEN 
      IF @countCode = 0 THEN
      INSERT INTO pay_obligation (obligation_cod, pay_obligation_actual_cuote, pay_Dtf, pay_Ibr,pay_FixedRate, pay_value, pay_capital_value, pay_residue,  Stat_id, pay_interesting_value,pay_observation,pay_date_notif ) VALUES (obligation_cod_, pay_obligation_actual_cuote_, pay_Dtf_, pay_Ibr_,pay_FixedRate_, pay_value_, pay_capital_value_, pay_residue_, 9, pay_interesting_value_,pay_observation_,pay_Date_);
      END IF;
    ELSE
      IF @dayOfMonthDateDesembolso = 31 THEN
        UPDATE pay_obligation SET pay_Date = CURRENT_DATE() ,pay_value=pay_value_, pay_capital_value=pay_capital_value_, pay_residue=pay_residue_,Stat_id=8,pay_interesting_value=pay_interesting_value_,pay_observation = pay_observation_ WHERE pay_obligation_id=id_;
        UPDATE obligation SET pay_date = @ultDia WHERE obligation_cod=obligation_cod_;
      ELSEIF @dayOfMonth = 30 OR @dayOfMonth = 29 OR @dayOfMonth = 28 THEN 
        UPDATE pay_obligation SET pay_Date = CURRENT_DATE() ,pay_value=pay_value_, pay_capital_value=pay_capital_value_, pay_residue=pay_residue_,Stat_id=8,pay_interesting_value=pay_interesting_value_,pay_observation = pay_observation_ WHERE pay_obligation_id=id_;
        UPDATE obligation SET pay_date = @fechaFinal WHERE obligation_cod=obligation_cod_;
      ELSE 
        UPDATE pay_obligation SET pay_Date = CURRENT_DATE() ,pay_value=pay_value_, pay_capital_value=pay_capital_value_, pay_residue=pay_residue_,Stat_id=8,pay_interesting_value=pay_interesting_value_,pay_observation = pay_observation_ WHERE pay_obligation_id=id_;
        UPDATE obligation SET pay_date = DATE_ADD(pay_Date_,INTERVAL @days DAY) WHERE obligation_cod=obligation_cod_;
      END IF;
    END IF;
    SELECT ROW_COUNT();
     
END$$

DROP PROCEDURE IF EXISTS `sp_pay_obligation_pays`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_pay_obligation_pays` ()  BEGIN
      SELECT PO.pay_date_notif,O.obligation_cod,O.client_name,BA.Bank_name,initial_value,O.cuotes_number, pay_obligation_actual_cuote, PO.pay_Date, pay_value,pay_capital_value,pay_residue,pay_interesting_value,ST.Stat_name,PO.Stat_id 
 FROM pay_obligation PO 
 INNER JOIN obligation O 
 ON PO.obligation_cod=O.obligation_cod 
 INNER JOIN status ST 
 ON PO.Stat_id=ST.Stat_id 
 INNER JOIN bank BA 
 ON O.Bank_id=BA.Bank_id 
 WHERE PO.Stat_id = 8 
 ORDER BY pay_date_notif ASC;
    END$$

DROP PROCEDURE IF EXISTS `sp_pay_obligation_select_amortization`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_pay_obligation_select_amortization` (IN `obligation_cod_` VARCHAR(80))  BEGIN
  SET @cuote = (SELECT COUNT(pay_obligation_actual_cuote)+1 FROM pay_obligation WHERE obligation_cod = obligation_cod_);
SET @date = (SELECT pay_date FROM obligation WHERE obligation_cod = obligation_cod_);
SELECT obligation_id, client_idmax, client_name, client_contract, Bank_id, credit_type_id, interesting_type_id, amortization_type_id, desembolso_date, initial_value, cuotes_number, residual_number, IT.interest_dtf AS 'dtf', IT.interest_ibr AS 'ibr', dtf_points, ibr_points, fixed_rate, Stat_id, obligation_cod, pay_date, FORMAT(initial_value,2,'de_DE') AS 'initial_value_format', FORMAT(residual_number,2,'de_DE') AS 'residual_number_format' , @cuote AS 'pay_obligation_actual_cuote' FROM obligation OB 
CROSS JOIN interest IT 
WHERE obligation_cod = obligation_cod_ and IT.interest_date = DATE_SUB(@date,INTERVAL 30 DAY);
END$$

DROP PROCEDURE IF EXISTS `sp_pay_obligation_to_notification`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_pay_obligation_to_notification` ()  BEGIN
SET @activo = 3;
SELECT obligation_cod
 FROM obligation  
 WHERE pay_date <= DATE_ADD(CURRENT_DATE(),INTERVAL 5 DAY) AND Stat_id = @activo;
END$$

DROP PROCEDURE IF EXISTS `sp_pay_obligation_to_pay`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_pay_obligation_to_pay` (IN `obligation_cod_` VARCHAR(80))  BEGIN
SET @date = (SELECT pay_date FROM obligation WHERE obligation_cod = obligation_cod_);
SELECT pay_obligation_id,O.obligation_cod,O.client_name,BA.Bank_name, pay_obligation_actual_cuote, O.pay_Date, pay_value,pay_capital_value,pay_residue,pay_interesting_value,ST.Stat_name,pay_Dtf,pay_Ibr,pay_FixedRate
 FROM pay_obligation PO 
 INNER JOIN obligation O 
 ON PO.obligation_cod=O.obligation_cod 
 INNER JOIN status ST 
 ON PO.Stat_id=ST.Stat_id 
 INNER JOIN bank BA 
 ON O.Bank_id=BA.Bank_id 
 CROSS JOIN interest IT 
 WHERE PO.obligation_cod = obligation_cod_ AND IT.interest_date = DATE_SUB(@date,INTERVAL 30 DAY) AND PO.Stat_id = 9
 ORDER BY pay_Date ASC;
    END$$

DROP PROCEDURE IF EXISTS `sp_pre_client_insert_update`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_pre_client_insert_update` (IN `name` VARCHAR(100), IN `identification` VARCHAR(15), IN `address` VARCHAR(200), IN `tel` VARCHAR(10), IN `email` VARCHAR(320), IN `contactName` VARCHAR(100), IN `contactTitle` VARCHAR(100), IN `contactTel` VARCHAR(10), IN `contactCel` VARCHAR(15), IN `contactEmail` VARCHAR(320), IN `stat` INT)  BEGIN
        SET @exist = (SELECT COUNT(Pre_client_identification)FROM pre_client WHERE Pre_client_email = email ); 
        IF @exist = 0 THEN 
            INSERT INTO pre_client (Pre_client_name, Pre_client_identification, Pre_client_address, Pre_client_tel, Pre_client_email, Pre_client_contactName, Pre_client_contactTitle, Pre_client_contactTel, Pre_client_contactCel, Pre_client_contactEmail, Stat_id) VALUES (name, identification, address, tel, email, contactName, contactTitle, contactTel, contactCel, email, stat);

        ELSE
            UPDATE Pre_client SET Pre_client_name = name, Pre_client_address = address, Pre_client_tel = tel, Pre_client_email = email, Pre_client_contactName = contactName, Pre_client_contactTitle = contactTitle, Pre_client_contactTel = contactTel, Pre_client_contactCel = contactCel, Pre_client_contactEmail = contactEmail, Stat_id = stat
            WHERE Pre_client_email = email;
        END IF;
        SELECT ROW_COUNT();
    END$$

DROP PROCEDURE IF EXISTS `sp_Pre_client_select`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Pre_client_select` (IN `email` VARCHAR(320))  BEGIN
    SELECT Pre_client_id FROM pre_client WHERE Pre_client_email = email; 
END$$

DROP PROCEDURE IF EXISTS `sp_pre_quote_select_all`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_pre_quote_select_all` (IN `name` VARCHAR(100))  BEGIN
    IF name IS NULL THEN
        SELECT Pre_quo_id,Pre_quo_consec, Pre_quo_project, Pre_quo_date, PQU.Stat_id AS "stat_id", PCLI.Pre_client_name AS "Pre_client_name"
        FROM pre_quote PQU INNER JOIN pre_client PCLI ON PQU.Pre_client_id=PCLI.Pre_client_id
        ORDER BY PCLI.Pre_client_name ASC;
    ELSE
        SELECT Pre_quo_id,Pre_quo_consec, Pre_quo_project, Pre_quo_date, PQU.Stat_id AS stat_id, PCLI.Pre_client_name AS Pre_client_name
        FROM pre_quote PQU INNER JOIN pre_client PCLI ON PQU.Pre_client_id=PCLI.Pre_client_id
        WHERE Pre_quo_consec LIKE CONCAT('%', name ,'%') 
        OR PCLI.Pre_client_name LIKE CONCAT('%', name ,'%') 
        OR Pre_quo_project LIKE CONCAT('%', name ,'%') ORDER BY PCLI.Pre_client_name ASC;
	END IF; 
END$$

DROP PROCEDURE IF EXISTS `sp_pre_quote_select_one`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_pre_quote_select_one` (IN `id` INT)  BEGIN
SELECT Pre_quo_id, PQU.Pre_client_id, Pre_quo_consec, Pre_quo_calendar, Pre_quo_date, Pre_quo_project, Pre_quo_year, Pre_quo_version, Pre_quo_students, Pre_quo_quantity, Pre_quo_width, Pre_quo_height, Pre_quo_format, Pre_quo_color, Pre_quo_colorPaper, Pre_quo_colorWeight, Pre_quo_bw, Pre_quo_bwPaper, Pre_quo_bwWeight, Pre_quo_inserts, Pre_quo_guards, Pre_quo_guardsPaper, Pre_quo_guardsWeight, Pre_quo_cover, Pre_quo_coverPaper, Pre_quo_coverWeight, Pre_quo_top, Pre_quo_coverFinish, Pre_quo_plast, Pre_quo_correction, Pre_quo_issn, Pre_quo_observ, Pre_quo_delivDate, Pre_quo_delivPlace, PQU.Stat_id, Pre_quo_pageTotal, Pre_quo_inser, Pre_quo_inserPaper, Pre_quo_inserWeight,
Pre_client_name, Pre_client_identification, Pre_client_address, Pre_client_tel, Pre_client_email, Pre_client_contactName, Pre_client_contactTitle, Pre_client_contactTel, Pre_client_contactCel, Pre_client_contactEmail, PCLI.Stat_id AS "Stat_cli_id"
FROM pre_quote PQU 
INNER JOIN pre_client PCLI ON PQU.Pre_client_id=PCLI.Pre_client_id 
WHERE Pre_quo_id= id;
END$$

DROP PROCEDURE IF EXISTS `sp_pre_quote_update`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_pre_quote_update` (IN `client` INT, IN `consec` VARCHAR(15), IN `calendar` VARCHAR(1), IN `quoteDate` DATE, IN `project` VARCHAR(100), IN `quoteYear` VARCHAR(4), IN `version` VARCHAR(11), IN `students` VARCHAR(11), IN `quantity` VARCHAR(11), IN `width` VARCHAR(20), IN `height` VARCHAR(20), IN `format` VARCHAR(40), IN `color` VARCHAR(100), IN `colorPaper` VARCHAR(100), IN `colorWeight` VARCHAR(100), IN `bw` VARCHAR(100), IN `bwPaper` VARCHAR(100), IN `bwWeight` VARCHAR(100), IN `inserts` VARCHAR(40), IN `guards` VARCHAR(100), IN `guardsPaper` VARCHAR(100), IN `guardsWeight` VARCHAR(100), IN `cover` VARCHAR(100), IN `coverPaper` VARCHAR(100), IN `coverWeight` VARCHAR(100), IN `top` VARCHAR(40), IN `coverFinish` VARCHAR(40), IN `plast` VARCHAR(40), IN `correction` VARCHAR(40), IN `issn` VARCHAR(40), IN `observ` VARCHAR(400), IN `delivDate` DATE, IN `delivPlace` VARCHAR(200), IN `stat` INT, IN `pageTotal` VARCHAR(100), IN `inser` VARCHAR(100), IN `inserPaper` VARCHAR(100), IN `inserWeight` INT, IN `client_identification` VARCHAR(15), IN `client_name` VARCHAR(100), IN `client_address` VARCHAR(200), IN `client_tel` VARCHAR(10), IN `client_email` VARCHAR(320), IN `client_contactName` VARCHAR(100), IN `client_contactTitle` VARCHAR(100), IN `client_contactTel` VARCHAR(10), IN `client_contactCel` VARCHAR(15), IN `client_contactEmail` VARCHAR(320))  BEGIN
UPDATE pre_client SET Pre_client_identification = client_identification, Pre_client_name = client_name, Pre_client_address = client_address, Pre_client_tel = client_tel, Pre_client_email = client_email,Pre_client_contactName = client_contactName,Pre_client_contactTitle = client_contactTitle, Pre_client_contactTel = client_contactTel, Pre_client_contactCel = client_contactCel, Pre_client_contactEmail = client_contactEmail
WHERE Pre_client_id = client;
UPDATE pre_quote SET Pre_quo_calendar=calendar,Pre_quo_date=quoteDate,Pre_quo_project=project,
Pre_quo_year=quoteYear,Pre_quo_version=version,Pre_quo_students=students,
Pre_quo_quantity=quantity,Pre_quo_width=width,Pre_quo_height=height,
Pre_quo_format=format,Pre_quo_color=color,Pre_quo_colorPaper=colorPaper,
Pre_quo_colorWeight=colorWeight,Pre_quo_bw=bw,Pre_quo_bwPaper=bwPaper,
Pre_quo_bwWeight=bwWeight,Pre_quo_inserts=inserts,Pre_quo_guards=guards,
Pre_quo_guardsPaper=guardsPaper,Pre_quo_guardsWeight=guardsWeight,Pre_quo_cover=cover,
Pre_quo_coverPaper=coverPaper,Pre_quo_coverWeight=coverWeight,Pre_quo_top=top,
Pre_quo_coverFinish=coverFinish,Pre_quo_plast=plast,Pre_quo_correction=correction,
Pre_quo_issn=issn,Pre_quo_observ=observ,Pre_quo_delivDate=delivDate,
Pre_quo_delivPlace=delivPlace,Stat_id=Stat_id,Pre_quo_pageTotal=pageTotal, Pre_quo_inser = inser,Pre_quo_inserPaper = inserPaper,Pre_quo_inserWeight = inserWeight 
WHERE Pre_quo_consec=consec;
SELECT ROW_COUNT();
END$$

DROP PROCEDURE IF EXISTS `sp_provider_active`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_provider_active` (IN `name` VARCHAR(100))  BEGIN
    IF name IS NULL THEN
        SELECT Pro_id, Pro_name, Pro_identification, Pro_tel, Pro_contactName, Pro_contactEmail FROM provider
       WHERE Stat_id = 8;
   ELSE
       SELECT Pro_id, Pro_name, Pro_identification, Pro_tel, Pro_contactName, Pro_contactEmail FROM provider WHERE (Pro_name LIKE CONCAT('%', name ,'%') OR Pro_identification LIKE CONCAT('%', name ,'%'))  AND Stat_id = 8;
   END IF;
END$$

DROP PROCEDURE IF EXISTS `sp_provider_insert`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_provider_insert` (IN `name` VARCHAR(100), IN `identification` VARCHAR(15), IN `tel` VARCHAR(10), IN `address` VARCHAR(200), IN `contactName` VARCHAR(100), IN `contactEmail` VARCHAR(320), IN `attach` BLOB)  BEGIN
INSERT INTO provider (Pro_name, Pro_identification, Pro_tel, Pro_address, Pro_contactName, Pro_contactEmail, Pro_attach) VALUES (name, identification, tel, address, contactName, contactEmail, attach);
  SELECT ROW_COUNT();
END$$

DROP PROCEDURE IF EXISTS `sp_provider_insert_update`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_provider_insert_update` (IN `name` VARCHAR(100), IN `identification` VARCHAR(15), IN `tel` VARCHAR(10), IN `address` VARCHAR(200), IN `contactName` VARCHAR(100), IN `contactEmail` VARCHAR(320), IN `attach` BLOB, IN `stat` INT)  NO SQL
BEGIN
	SET @exist = (SELECT COUNT(Pro_identification) FROM provider WHERE Pro_identification = identification); 
    IF @exist = 0 THEN 
		INSERT INTO provider (Pro_name, Pro_identification, Pro_tel, Pro_address, Pro_contactName, Pro_contactEmail, Pro_attach, Stat_id) VALUES (name, identification, tel, address, contactName, contactEmail, attach, stat);
    ELSE
    	UPDATE provider SET Pro_name = name, Pro_tel = tel, Pro_address = address, Pro_contactName = contactName, Pro_contactEmail = contactEmail, Pro_attach = attach, Stat_id = stat
        WHERE Pro_identification = identification;
    END IF;
    SELECT ROW_COUNT();
END$$

DROP PROCEDURE IF EXISTS `sp_provider_select_all`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_provider_select_all` ()  BEGIN
SELECT Pro_id, Pro_name, Pro_identification, Pro_tel, Pro_contactName, Pro_contactEmail, Stat_id  FROM provider;
END$$

DROP PROCEDURE IF EXISTS `sp_provider_select_identification`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_provider_select_identification` (IN `identification` VARCHAR(15))  BEGIN
    SELECT Pro_id, Pro_name, Pro_identification FROM provider WHERE Pro_identification = identification;
END$$

DROP PROCEDURE IF EXISTS `sp_provider_select_one`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_provider_select_one` (IN `id` VARCHAR(15))  BEGIN
SELECT Pro_name, Pro_identification, Pro_tel, Pro_address, Pro_contactName, Pro_contactEmail, Pro_attach, Stat_id FROM provider
WHERE Pro_id = id;
END$$

DROP PROCEDURE IF EXISTS `sp_provider_select_prov`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_provider_select_prov` ()  BEGIN
SELECT Pro_id, Pro_name FROM provider;
END$$

DROP PROCEDURE IF EXISTS `sp_provider_select_search`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_provider_select_search` (IN `name` VARCHAR(100))  NO SQL
BEGIN
    IF name IS NULL THEN
        SELECT Pro_id, Pro_name, Pro_identification, Pro_tel, Pro_contactName, Pro_contactEmail FROM provider;
   ELSE
       SELECT Pro_id, Pro_name, Pro_identification, Pro_tel, Pro_contactName, Pro_contactEmail FROM provider WHERE Pro_name LIKE CONCAT('%', name ,'%') OR Pro_identification LIKE CONCAT('%', name ,'%');
   END IF;
END$$

DROP PROCEDURE IF EXISTS `sp_provider_update`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_provider_update` (IN `id` VARCHAR(15), IN `name` VARCHAR(100), IN `identification` VARCHAR(15), IN `tel` VARCHAR(10), IN `address` VARCHAR(200), IN `contactName` VARCHAR(100), IN `contactEmail` VARCHAR(320), IN `attach` BLOB)  BEGIN
UPDATE provider SET Pro_name = name, Pro_identification = identification, Pro_tel = tel, Pro_address = address, Pro_contactName = contactName, Pro_contactEmail = contactEmail, Pro_attach = attach
WHERE Pro_id = id;
END$$

DROP PROCEDURE IF EXISTS `sp_provider_update_status`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_provider_update_status` (IN `id` INT, IN `stat` INT)  NO SQL
BEGIN
	UPDATE provider SET Stat_id = stat
    WHERE Pro_id = id;
    SELECT ROW_COUNT();
END$$

DROP PROCEDURE IF EXISTS `sp_provision`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_provision` ()  BEGIN
SELECT PR.obligation_cod,OB.client_name,BA.Bank_name,PR.provi_inicialDate,PR.provi_lastDate, PR.provi_interesting,PR.provi_actualMonth,PR.provi_afterMonth, PR.total_provision,PR.provi_month
FROM provision PR 
INNER JOIN obligation OB 
ON PR.obligation_cod=OB.obligation_cod
INNER JOIN bank BA 
ON BA.Bank_id=OB.Bank_id
ORDER BY PR.provi_inicialDate ASC;
     END$$

DROP PROCEDURE IF EXISTS `sp_provision_insert_update`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_provision_insert_update` (IN `obligation_cod_` VARCHAR(80), IN `provi_inicialDate_` DATE, IN `provi_lastDate_` DATE, IN `provi_interesting_` DOUBLE, IN `provi_actualMonth_` DOUBLE, IN `provi_afterMonth_` DOUBLE, IN `total_provision_` DOUBLE, IN `provi_month_` VARCHAR(80))  BEGIN
      INSERT INTO provision (obligation_cod, provi_inicialDate, provi_lastDate, provi_interesting , provi_actualMonth, provi_afterMonth, total_provision, provi_month) VALUES (obligation_cod_, provi_inicialDate_, provi_lastDate_, provi_interesting_,provi_actualMonth_, provi_afterMonth_, total_provision_, provi_month_);
SELECT ROW_COUNT();
     
END$$

DROP PROCEDURE IF EXISTS `sp_quote_create_pdf`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_quote_create_pdf` (IN `consec` VARCHAR(15), IN `entry` INT(1))  BEGIN
	IF entry = 1 THEN
	SELECT P.Pro_name, P.Pro_contactName, Q.Quo_consec, Q.Quo_date, Q.Quo_project, Q.Quo_year, Q.Quo_version, Q.Quo_quantity, Q.Quo_width, Q.Quo_height, Q.Quo_format, Q.Quo_color, Q.Quo_colorPaper, Q.Quo_colorWeight, Q.Quo_bw, Q.Quo_bwPaper, Q.Quo_bwWeight, Q.Quo_inserts, Q.Quo_guards, Q.Quo_guardsPaper, Q.Quo_guardsWeight, Q.Quo_cover, Q.Quo_coverPaper, Q.Quo_coverWeight, Q.Quo_pageTotal, Q.Quo_top, Q.Quo_coverFinish, Q.Quo_plast, Q.Quo_correction, Q.Quo_issn, Q.Quo_observ, Q.Quo_delivDate, Q.Quo_delivPlace, U.User_name, U.User_title, U.User_telephone, Q.Quo_inser, Q.Quo_inserPaper, Q.Quo_inserWeight FROM  quote Q
    LEFT JOIN provider P ON Q.Pro_id = P.Pro_id
    LEFT JOIN user U ON Q.User_id = U.User_id
    WHERE Q.Quo_consec = consec;
    ELSEIF entry = 2 THEN
        SELECT CL.Client_name, CL.Client_contactName, CL.Client_contactTitle, Q.Quo_consec, Q.Quo_date, Q.Quo_project, Q.Quo_year, Q.Quo_version, Q.Quo_quantity, Q.Quo_width, Q.Quo_height, Q.Quo_format, Q.Quo_color, Q.Quo_colorPaper, Q.Quo_colorWeight, Q.Quo_bw, Q.Quo_bwPaper, Q.Quo_bwWeight, Q.Quo_inserts, Q.Quo_guards, Q.Quo_guardsPaper, Q.Quo_guardsWeight, Q.Quo_cover, Q.Quo_coverPaper, Q.Quo_coverWeight, Q.Quo_pageTotal, Q.Quo_top, Q.Quo_coverFinish, Q.Quo_plast, Q.Quo_correction, Q.Quo_issn, Q.Quo_observ, Q.Quo_inser, Q.Quo_inserPaper, Q.Quo_inserWeight, Q.Quo_delivDate, Q.Quo_calendar, C.Cost_finalValue, C.Cost_description, Q.Quo_delivPlace, U.User_name, U.User_title, U.User_telephone 
        FROM quote Q 
        LEFT JOIN user U ON Q.User_id = U.User_id 
        LEFT JOIN costing C ON Q.Quo_id = C.Quo_id 
        LEFT JOIN client CL ON CL.Client_id = Q.Client_id 
        WHERE Q.Quo_consec = consec;
    END IF;
END$$

DROP PROCEDURE IF EXISTS `sp_quote_insert_upate`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_quote_insert_upate` (IN `client` INT, IN `consec` VARCHAR(15), IN `calendar` VARCHAR(1), IN `quoteDate` DATE, IN `project` VARCHAR(100), IN `quoteYear` VARCHAR(4), IN `version` VARCHAR(11), IN `students` VARCHAR(11), IN `quality` VARCHAR(11), IN `width` VARCHAR(20), IN `height` VARCHAR(20), IN `format` VARCHAR(40), IN `color` VARCHAR(100), IN `colorPaper` VARCHAR(100), IN `colorWeight` VARCHAR(100), IN `bw` VARCHAR(100), IN `bwPaper` VARCHAR(100), IN `bwWeight` VARCHAR(100), IN `inserts` VARCHAR(40), IN `guards` VARCHAR(100), IN `guardsPaper` VARCHAR(100), IN `guardsWeight` VARCHAR(100), IN `cover` VARCHAR(100), IN `coverPaper` VARCHAR(100), IN `coverWeight` VARCHAR(100), IN `top` VARCHAR(40), IN `coverFinish` VARCHAR(40), IN `plast` VARCHAR(40), IN `correction` VARCHAR(40), IN `issn` VARCHAR(40), IN `observ` VARCHAR(400), IN `delivDate` DATE, IN `delivPlace` VARCHAR(200), IN `user_id` INT, IN `prov` INT, IN `stat` INT, IN `pageTotal` VARCHAR(100), IN `inser` VARCHAR(100), IN `inserPaper` VARCHAR(100), IN `inserWeight` VARCHAR(100))  BEGIN
  SET @exist = (SELECT COUNT(Quo_consec)
  FROM quote
  WHERE Quo_consec = consec);
  IF @exist = 0 THEN
  INSERT INTO quote
    (Client_id, Quo_consec, Quo_calendar, Quo_date, Quo_project, Quo_year, Quo_version, Quo_students, Quo_quantity, Quo_width, Quo_height, Quo_format, Quo_color, Quo_colorPaper, Quo_colorWeight, Quo_bw, Quo_bwPaper, Quo_bwWeight, Quo_inserts, Quo_guards, Quo_guardsPaper, Quo_guardsWeight, Quo_cover, Quo_coverPaper, Quo_coverWeight, Quo_top, Quo_coverFinish, Quo_plast, Quo_correction, Quo_issn, Quo_observ, Quo_delivDate, Quo_delivPlace, User_id, Pro_id, Stat_id, Quo_pageTotal,Quo_inser, Quo_inserPaper, Quo_inserWeight)
  VALUES
    (client, consec, calendar, quoteDate, project, quoteYear, version, students, quality, width, height, format, color, colorPaper, colorWeight, bw, bwPaper, bwWeight, inserts, guards, guardsPaper, guardsWeight, cover, coverPaper, coverWeight, top, coverFinish, plast, correction, issn, observ, delivDate, delivPlace, user_id, prov, stat, pageTotal, inser, inserPaper, inserWeight);
  ELSE
  UPDATE quote SET Client_id = client,  Quo_calendar = calendar, Quo_date = quoteDate, Quo_project = project, Quo_year = quoteYear, Quo_version = version, Quo_students = students, Quo_quantity = quality, Quo_width = width, Quo_height = height, Quo_format = format, Quo_color = color, Quo_colorPaper = colorPaper, Quo_colorWeight = colorWeight, Quo_bw = bw, Quo_bwPaper = bwPaper, Quo_bwWeight = bwWeight, Quo_inserts = inserts, Quo_guards = guards, Quo_guardsPaper = guardsPaper, Quo_guardsWeight = guardsWeight, Quo_cover = cover, Quo_coverPaper = coverPaper, Quo_coverWeight = coverWeight, Quo_top = top, Quo_coverFinish = coverFinish, Quo_plast = plast, Quo_correction = correction, Quo_issn = issn, Quo_observ = observ, Quo_delivDate = delivDate, Quo_delivPlace = delivPlace, User_id = user_id, Pro_id = prov, Stat_id = stat, Quo_pageTotal = pageTotal, Quo_inser = inser, Quo_inserPaper = inserPaper, Quo_inserWeight = inserWeight WHERE Quo_consec=consec;
END
IF;
    SELECT ROW_COUNT();
END$$

DROP PROCEDURE IF EXISTS `sp_quote_select_all`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_quote_select_all` (IN `name` VARCHAR(100))  BEGIN
	IF name IS NULL THEN
		SELECT Quo_id,CLI.Client_name AS "Client_name" ,Quo_consec,Quo_project,Quo_date,QU.stat_id FROM quote QU 
INNER JOIN client CLI ON QU.Client_id=CLI.Client_id ORDER BY Quo_id DESC;
        
    ELSE
       SELECT Quo_id,CLI.Client_name,Quo_consec,Quo_project,Quo_date,QU.stat_id FROM quote QU 
INNER JOIN client CLI ON QU.Client_id=CLI.Client_id  WHERE Quo_consec LIKE CONCAT('%', name ,'%') OR CLI.Client_name LIKE CONCAT('%', name ,'%') OR Quo_project LIKE CONCAT('%', name ,'%') ORDER BY Quo_id DESC;
    END IF;
END$$

DROP PROCEDURE IF EXISTS `sp_quote_select_one`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_quote_select_one` (IN `id` INT)  BEGIN
SELECT Pro_identification,Pro_name,Client_identification,Client_name, Quo_id, QU.Client_id, Quo_consec, Quo_calendar, Quo_date, Quo_project, Quo_year, Quo_version, Quo_students, Quo_quantity, Quo_width, Quo_height, Quo_format, Quo_color, Quo_colorPaper, Quo_colorWeight, Quo_bw, Quo_bwPaper, Quo_bwWeight, Quo_inserts, Quo_guards, Quo_guardsPaper, Quo_guardsWeight, Quo_cover, Quo_coverPaper, Quo_coverWeight, Quo_top, Quo_coverFinish, Quo_plast, Quo_correction, Quo_issn, Quo_observ, Quo_delivDate, Quo_delivPlace, User_id, QU.Pro_id, QU.Stat_id, Quo_pageTotal, Quo_inser, Quo_inserPaper, Quo_inserWeight FROM quote QU INNER JOIN client CLI ON QU.Client_id=CLI.Client_id INNER JOIN provider PRO ON QU.Pro_id=PRO.Pro_id WHERE Quo_id = id;
END$$

DROP PROCEDURE IF EXISTS `sp_quote_select_status`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_quote_select_status` (IN `stat` INT)  BEGIN
    SELECT Q.Quo_id, C.Client_name, Q.Quo_date, Q.Quo_project, Q.Stat_id 
    FROM quote Q 
    INNER JOIN client C ON C.Client_id = Q.Client_id
    WHERE Q.Stat_id = stat
    ORDER BY Q.Quo_date;
END$$

DROP PROCEDURE IF EXISTS `sp_quote_update`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_quote_update` (IN `id` INT, IN `client` INT, IN `consec` VARCHAR(15), IN `calendar` VARCHAR(1), IN `quoteDate` DATE, IN `project` VARCHAR(100), IN `quoteYear` INT(4), IN `version` INT, IN `students` INT, IN `quality` INT, IN `width` DECIMAL(6,2), IN `height` DECIMAL(6,2), IN `format` VARCHAR(40), IN `color` INT, IN `colorPaper` INT, IN `colorWeight` INT, IN `bw` INT, IN `bwPaper` INT, IN `bwWeight` INT, IN `inserts` INT, IN `guards` INT, IN `guardsPaper` INT, IN `guardsWeight` INT, IN `cover` INT, IN `coverPaper` INT, IN `coverWeight` INT, IN `top` VARCHAR(40), IN `coverFinish` VARCHAR(40), IN `plast` VARCHAR(40), IN `correction` VARCHAR(40), IN `issn` VARCHAR(40), IN `observ` VARCHAR(400), IN `delivDate` DATE, IN `delivPlace` VARCHAR(200), IN `user_id` INT, IN `prov` INT, IN `stat` INT)  BEGIN
	UPDATE quote SET Client_id = client, Quo_consec = consec, Quo_calendar = calendar, Quo_date = quoteDate, Quo_project = project, Quo_year = quoteYear, Quo_version = version, Quo_students = students, Quo_quantity = quality, Quo_width = width, Quo_height = height, Quo_format = format, Quo_color = color, Quo_colorPaper = colorPaper, Quo_colorWeight = colorWeight, Quo_bw = bw, Quo_bwPaper = bwPaper, Quo_bwWeight = bwWeight, Quo_inserts = inserts, Quo_guards = guards, Quo_guardsPaper = guardsPaper, Quo_guardsWeight = guardsWeight, Quo_cover = cover, Quo_coverPaper = coverPaper, Quo_coverWeight = coverWeight, Quo_top = top, Quo_coverFinish = coverFinish, Quo_plast = plast, Quo_correction = correction, Quo_issn = issn, Quo_observ = observ, Quo_delivDate = delivDate, Quo_delivPlace = delivPlace, User_id = user_id, Pro_id = prov, Stat_id = stat
  WHERE Quo_id = id;
  SELECT ROW_COUNT();
END$$

DROP PROCEDURE IF EXISTS `sp_quote_update_status`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_quote_update_status` (IN `consec` VARCHAR(15), IN `stat` INT)  BEGIN
	UPDATE quote SET Stat_id = stat
    WHERE Quo_consec = consec;
    SELECT ROW_COUNT();
END$$

DROP PROCEDURE IF EXISTS `sp_recovery_password_insert`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_recovery_password_insert` (IN `user_id` INT, IN `pass_date` VARCHAR(100), IN `pass_hash` VARCHAR(600), IN `pass_state` INT)  BEGIN 
	SET @count = (SELECT COUNT(*) FROM recovery_password WHERE User_id = user_id);
    IF @count = 0 THEN
  		INSERT INTO recovery_password (Recover_pass_id, User_id, Recover_pass_date, Recover_pass_hash, Recover_pass_state) VALUES (NULL, user_id,pass_date, pass_hash,pass_state);
  	ELSE
    	UPDATE recovery_password SET Recover_pass_date = pass_date, Recover_pass_hash = pass_hash, Recover_pass_state = pass_state WHERE User_id = user_id;
    END IF;
    SELECT ROW_COUNT(); 
END$$

DROP PROCEDURE IF EXISTS `sp_recovery_password_select`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_recovery_password_select` (IN `pass_hash` VARCHAR(600))  BEGIN 
SET @valid =(SELECT TIMESTAMPDIFF(MINUTE,NOW() ,DATE_ADD(Recover_pass_date,INTERVAL 24 HOUR)) AS Recover_difference FROM recovery_password WHERE Recover_pass_hash=pass_hash);
IF @valid >= 0 THEN 
  SELECT User_id FROM recovery_password WHERE Recover_pass_hash=pass_hash;
  ELSE
  SELECT "expire" AS Error_id;
 END IF; 
END$$

DROP PROCEDURE IF EXISTS `sp_search_pay_obligation_for_pay`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_search_pay_obligation_for_pay` (IN `data_` VARCHAR(80))  BEGIN
SELECT PA.obligation_cod,client_name,BA.Bank_name,OB.cuotes_number,PA.pay_obligation_actual_cuote,OB.pay_date,PA.pay_value,St.Stat_name
        FROM pay_obligation PA
        INNER JOIN status ST
        ON PA.Stat_id = ST.Stat_id
        INNER JOIN obligation OB
        ON PA.obligation_cod = OB.obligation_cod
        INNER JOIN bank BA
        ON OB.Bank_id=BA.Bank_id 
        WHERE client_name LIKE '%data_%' OR PA.obligation_cod LIKE '%data_%' OR OB.pay_date LIKE '%data_%' AND PA.Stat_id = 9
        ORDER BY OB.pay_date ASC;
END$$

DROP PROCEDURE IF EXISTS `sp_select_role`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_select_role` ()  BEGIN
    SELECT * FROM role;
END$$

DROP PROCEDURE IF EXISTS `sp_select_security_group`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_select_security_group` ()  BEGIN
    SELECT * FROM security_group;
END$$

DROP PROCEDURE IF EXISTS `sp_select_status`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_select_status` (IN `stat` INT)  BEGIN
    SELECT * FROM status WHERE Type_id = stat;
END$$

DROP PROCEDURE IF EXISTS `sp_user_get_email`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_user_get_email` (IN `email` VARCHAR(320))  BEGIN
    SET @valid =(SELECT User_id FROM user WHERE User_email=email AND Stat_id = 6);
    IF @valid != 0 THEN 
    SELECT User_id, User_name FROM user WHERE User_email=email;
    ELSE
    SELECT "0" AS User_id;
    END IF; 
END$$

DROP PROCEDURE IF EXISTS `sp_user_insert_update`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_user_insert_update` (IN `name` VARCHAR(80), IN `identification` VARCHAR(15), IN `email` VARCHAR(320), IN `title` VARCHAR(30), IN `stat` INT, IN `pass` VARCHAR(30), IN `tel` VARCHAR(15), IN `id` INT, IN `role` INT, IN `securityGroup` INT, IN `company` INT)  BEGIN
    SET @exist =(SELECT COUNT(*)
    FROM user
    WHERE User_email = email AND User_identification = identification);
    SET @id = (SELECT User_id
    FROM user
    WHERE User_email = email);

    IF @exist = 0 AND id = 0 THEN
        INSERT INTO user (User_name, User_identification, User_email, User_title, Stat_id, User_telephone,Role_id,Sgroup_id, Comp_id) VALUES (name, identification, email, title, stat, tel, role, securityGroup, company);
        SET @user_id = LAST_INSERT_ID();
        INSERT INTO login(Login_password, User_id)VALUES(pass, @user_id);
        SET @return = @user_id;
    ELSE
        IF (SELECT COUNT(User_id) FROM new_user WHERE User_id = @id) =1 THEN
            SET @return = 'Inactive';
        ELSEIF id != 0 AND @exist = 1  THEN
            UPDATE user SET User_name = name, User_title = title, Stat_id = stat, User_telephone = tel, Role_id = role, Sgroup_id = securityGroup WHERE User_id = @id;
            SET @return = 'Update';
        ELSE
            SET @return = 'Registered';
        END IF;
    END IF;
    SELECT @return AS "return_value";
END$$

DROP PROCEDURE IF EXISTS `sp_user_select_active`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_user_select_active` (IN `name` VARCHAR(320))  NO SQL
BEGIN
    IF name IS NULL THEN
        SELECT User_id, User_name, User_email, User_title FROM user
       WHERE Stat_id = 6;
   ELSE
       SELECT User_id, User_name, User_email, User_title FROM user WHERE (User_name LIKE CONCAT('%', name ,'%') OR User_email LIKE CONCAT('%', name ,'%') OR User_title LIKE CONCAT('%', name ,'%')) AND Stat_id = 6;
   END IF;
END$$

DROP PROCEDURE IF EXISTS `sp_user_select_one`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_user_select_one` (IN `id` INT)  BEGIN
SELECT User_id, User_name, User_identification, User_email, User_title, Stat_id, User_telephone,Role_id ,Sgroup_id, Comp_id FROM user  WHERE User_id = id;
END$$

DROP PROCEDURE IF EXISTS `sp_user_validation`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_user_validation` (IN `id` INT)  BEGIN
   SELECT User_name, User_email FROM user
   WHERE User_id = id;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `amortization_type`
--

DROP TABLE IF EXISTS `amortization_type`;
CREATE TABLE IF NOT EXISTS `amortization_type` (
  `amortization_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `amortization_name` varchar(80) NOT NULL,
  PRIMARY KEY (`amortization_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `amortization_type`
--

INSERT INTO `amortization_type` (`amortization_type_id`, `amortization_name`) VALUES
(1, 'Abono Fijo a Cuota'),
(2, 'Abono Fijo a Capital');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `application`
--

DROP TABLE IF EXISTS `application`;
CREATE TABLE IF NOT EXISTS `application` (
  `App_id` int(11) NOT NULL AUTO_INCREMENT,
  `App_name` varchar(100) NOT NULL,
  `Mod_id` int(11) NOT NULL,
  PRIMARY KEY (`App_id`),
  KEY `Mod_id` (`Mod_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `bank`
--

DROP TABLE IF EXISTS `bank`;
CREATE TABLE IF NOT EXISTS `bank` (
  `Bank_id` int(11) NOT NULL AUTO_INCREMENT,
  `Bank_name` varchar(20) NOT NULL,
  PRIMARY KEY (`Bank_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `bank`
--

INSERT INTO `bank` (`Bank_id`, `Bank_name`) VALUES
(1, 'AV VILLAS'),
(2, 'BANCOLOMBIA'),
(3, 'BBVA'),
(4, 'BANCO AGRARIO'),
(5, 'DAVIVIENDA');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `client`
--

DROP TABLE IF EXISTS `client`;
CREATE TABLE IF NOT EXISTS `client` (
  `Client_id` int(11) NOT NULL AUTO_INCREMENT,
  `Client_name` varchar(100) NOT NULL,
  `Client_identification` varchar(15) NOT NULL,
  `Client_address` varchar(200) NOT NULL,
  `Client_tel` varchar(10) NOT NULL,
  `Client_email` varchar(320) NOT NULL,
  `Client_contactName` varchar(100) NOT NULL,
  `Client_contactTitle` varchar(100) NOT NULL,
  `Client_contactTel` varchar(10) NOT NULL,
  `Client_contactCel` varchar(15) NOT NULL,
  `Client_contactEmail` varchar(320) NOT NULL,
  `Stat_id` int(11) NOT NULL,
  PRIMARY KEY (`Client_id`),
  KEY `status_client` (`Stat_id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `client`
--

INSERT INTO `client` (`Client_id`, `Client_name`, `Client_identification`, `Client_address`, `Client_tel`, `Client_email`, `Client_contactName`, `Client_contactTitle`, `Client_contactTel`, `Client_contactCel`, `Client_contactEmail`, `Stat_id`) VALUES
(1, 'COLEGIO ABRAHAM MASLOWSES', '9000000577', 'Calle 1 Sur # 5-03 Vereda La Balsa. Chía, Cundinamarca', '8625153', 'director@colegiomaslow.edu.co', 'Nohora Janeth ', 'Rectora', '8625153', '', 'director@colegiomaslow.edu.co', 8),
(2, 'Sinapsis Technologies', '90000001', 'calle 65 a # 71 f - 35', '78007354', 'info@sinapsistechnolohies.com', 'Diego Casallas', 'Director de tecnología', '23456789', '', 'lauramggarcia@hotmail.com', 8),
(3, 'Sinapsis Technologies', '9008567485', 'calle 65 a # 71 f - 35', '123456', 'info@sinapsistechnolohies.com', 'Diego Casallas', 'Director de tecnología', '123456', '234569', 'd.casallas@sinapsistechnologies.com', 8),
(4, 'Grupo Trivia sas', '9002205681', 'calle 150 no 16 56', '4673070', 'administracion@grupotrivia.co', 'Lina Cortes', 'Coordinacion General', '00000000', '3012656571', 'disenio@grupotrivia.co', 8),
(7, 'Diego Casallas', '10203040', 'Calle 53 a # 31 ', '7800800', 'd.casallas@sinapsist.com.co', 'Diego H Casallas', '', '', '', '', 8),
(8, 'Luis Perez', '1030633098', '', '', 'gomez.laura@hotmail.com', 'Lina Ramiez', 'Directora', '123345345', '3123718171', 'luisperez@gmail.com', 8),
(9, 'Colegio Israel Lunitas Sede Administrativa', '808565456-7', 'Cr 98 54 67', '1234567', 'info@israelluna.com.co', 'Manuel Rivas', 'Coordinador', '1', '3124567654', 'm.rivas@israelluna.com.co', 8),
(10, 'Colegio Israel Lunas', '8085654-5', 'Cr 98 54 67', '1234567', 'info@israelluna.com.co', 'Manuel Rivas', 'Coordinador', '1', '3124567654', 'm.rivas@israelluna.com.co', 8),
(11, '', '123123123', '', '', '', '', '', '', '', '', 1),
(12, 'HSCS 2', '765765765', 'Cr 4 79 45', '', '', 'Laura Gutierrez', 'Rectora', '02323', '', 'lauramggarcia@hotmail.com', 8),
(13, 'HSCS 2', '765765765', 'Cr 4 79 45', '', '', 'Laura Gutierrez', 'Rectora', '02323', '', 'lauramggarcia@hotmail.com', 8),
(14, 'khkjh', '52180373-2', '', '', '', 'Olga García', 'Gerente', '23423423', '', 'lauramggarcia@hotmail.com', 8),
(15, 'HSCS 2', '765765765', 'Cr 4 79 45', '', '', 'Laura Gutierrez', 'Rectora', '02323', '', 'lauramggarcia@hotmail.com', 8),
(16, 'hbjbkjbkj', '098098908', 'Cr 90B 70A 32', '', '', 'Nohora Janeth', 'Rectora', '9086876876', '', 'lauramggarcia@hotmail.com', 8),
(17, 'Prueba final', '52180373', 'Cr 90B 70A 32', '', '', 'Olga García', 'Gerente', '3202381267', '', 'lauramggarcia@hotmail.com', 8),
(18, 'Prueba sin Debugger', '1234567890-1', 'Calle falsa 1234', '', '', 'Laura Gripuna', 'Gerente', '3126787', '', 'lauramggarcia@hotmail.com', 8),
(19, 'Prueba finalita', '9002348765432-1', '', '', '', 'Caro Moreno', 'Rectora', '3501265', '', 'lauramggarcia@hotmail.com', 8),
(20, 'High Speed C&S', '52180373-2', 'Carrera 90B 70A 45', '', 'hscs@hotmail.com', 'Olga Lucía García', 'Representante Legal', '6050101', '3202356799', 'hscs@hotmail.com', 8),
(21, 'CA000000: -Gerencia', '900939798', 'Ordinario', 'Banco Av V', 'dtf', 'AbonoInt', '1111111111', '121', '1212121', '2020-10-14', 8),
(22, '1111111111', '11111111111111', '1111111111', '1111111111', '1111111', '11111111111', '111111111111', '111111111', '111111111', '111111111111111', 8);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `company`
--

DROP TABLE IF EXISTS `company`;
CREATE TABLE IF NOT EXISTS `company` (
  `Comp_id` int(11) NOT NULL AUTO_INCREMENT,
  `Comp_identification` varchar(100) NOT NULL,
  `Comp_name` varchar(300) NOT NULL,
  `Comp_address` varchar(300) DEFAULT NULL,
  `Comp_phone` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`Comp_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `company`
--

INSERT INTO `company` (`Comp_id`, `Comp_identification`, `Comp_name`, `Comp_address`, `Comp_phone`) VALUES
(1, '860013472-1', 'Coominobras', 'Calle 44 No. 57-28', '3158555');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `credit_type`
--

DROP TABLE IF EXISTS `credit_type`;
CREATE TABLE IF NOT EXISTS `credit_type` (
  `credit_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `credit_type_name` varchar(80) NOT NULL,
  PRIMARY KEY (`credit_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `credit_type`
--

INSERT INTO `credit_type` (`credit_type_id`, `credit_type_name`) VALUES
(1, 'Crédito Ordinario'),
(2, 'Crédito de Tesorería'),
(3, 'Leasing');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `interest`
--

DROP TABLE IF EXISTS `interest`;
CREATE TABLE IF NOT EXISTS `interest` (
  `interest_id` int(11) NOT NULL AUTO_INCREMENT,
  `interest_dtf` float NOT NULL,
  `interest_date` date NOT NULL,
  `interest_ibr` float NOT NULL,
  PRIMARY KEY (`interest_id`)
) ENGINE=InnoDB AUTO_INCREMENT=813 DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `interest`
--

INSERT INTO `interest` (`interest_id`, `interest_dtf`, `interest_date`, `interest_ibr`) VALUES
(69, 4.48, '2020-01-01', 4.48),
(70, 4.48, '2020-01-02', 4.48),
(71, 4.48, '2020-01-03', 4.48),
(72, 4.48, '2020-01-04', 4.48),
(73, 4.48, '2020-01-05', 4.48),
(74, 4.49, '2020-01-06', 4.49),
(75, 4.49, '2020-01-07', 4.49),
(76, 4.49, '2020-01-08', 4.49),
(77, 4.49, '2020-01-09', 4.49),
(78, 4.49, '2020-01-10', 4.49),
(79, 4.49, '2020-01-11', 4.49),
(80, 4.49, '2020-01-12', 4.49),
(81, 4.5, '2020-01-13', 4.5),
(82, 4.5, '2020-01-14', 4.5),
(83, 4.5, '2020-01-15', 4.5),
(84, 4.5, '2020-01-16', 4.5),
(85, 4.5, '2020-01-17', 4.5),
(86, 4.5, '2020-01-18', 4.5),
(87, 4.5, '2020-01-19', 4.5),
(88, 4.43, '2020-01-20', 4.43),
(89, 4.43, '2020-01-21', 4.43),
(90, 4.43, '2020-01-22', 4.43),
(91, 4.43, '2020-01-23', 4.43),
(92, 4.43, '2020-01-24', 4.43),
(93, 4.43, '2020-01-25', 4.43),
(94, 4.43, '2020-01-26', 4.43),
(95, 4.62, '2020-01-27', 4.62),
(96, 4.62, '2020-01-28', 4.62),
(97, 4.62, '2020-01-29', 4.62),
(98, 4.62, '2020-01-30', 4.62),
(99, 4.62, '2020-01-31', 4.62),
(100, 4.62, '2020-02-01', 4.62),
(101, 4.62, '2020-02-02', 4.62),
(102, 4.58, '2020-02-03', 4.58),
(103, 4.58, '2020-02-04', 4.58),
(104, 4.58, '2020-02-05', 4.58),
(105, 4.58, '2020-02-06', 4.58),
(106, 4.58, '2020-02-07', 4.58),
(107, 4.58, '2020-02-08', 4.58),
(108, 4.58, '2020-02-09', 4.58),
(109, 4.43, '2020-02-10', 4.43),
(110, 4.43, '2020-02-11', 4.43),
(111, 4.43, '2020-02-12', 4.43),
(112, 4.43, '2020-02-13', 4.43),
(113, 4.43, '2020-02-14', 4.43),
(114, 4.43, '2020-02-15', 4.43),
(115, 4.43, '2020-02-16', 4.43),
(116, 4.49, '2020-02-17', 4.49),
(117, 4.49, '2020-02-18', 4.49),
(118, 4.49, '2020-02-19', 4.49),
(119, 4.49, '2020-02-20', 4.49),
(120, 4.49, '2020-02-21', 4.49),
(121, 4.49, '2020-02-22', 4.49),
(122, 4.49, '2020-02-23', 4.49),
(123, 4.45, '2020-02-24', 4.45),
(124, 4.45, '2020-02-25', 4.45),
(125, 4.45, '2020-02-26', 4.45),
(126, 4.45, '2020-02-27', 4.45),
(127, 4.45, '2020-02-28', 4.45),
(128, 4.45, '2020-02-29', 4.45),
(129, 4.45, '0000-00-00', 4.45),
(130, 4.45, '0000-00-00', 4.45),
(131, 4.45, '2020-03-01', 4.45),
(132, 4.43, '2020-03-02', 4.43),
(133, 4.43, '2020-03-03', 4.43),
(134, 4.43, '2020-03-04', 4.43),
(135, 4.43, '2020-03-05', 4.43),
(136, 4.43, '2020-03-06', 4.43),
(137, 4.43, '2020-03-07', 4.43),
(138, 4.43, '2020-03-08', 4.43),
(139, 4.56, '2020-03-09', 4.56),
(140, 4.56, '2020-03-10', 4.56),
(141, 4.56, '2020-03-11', 4.56),
(142, 4.56, '2020-03-12', 4.56),
(143, 4.56, '2020-03-13', 4.56),
(144, 4.56, '2020-03-14', 4.56),
(145, 4.56, '2020-03-15', 4.56),
(146, 4.46, '2020-03-16', 4.46),
(147, 4.46, '2020-03-17', 4.46),
(148, 4.46, '2020-03-18', 4.46),
(149, 4.46, '2020-03-19', 4.46),
(150, 4.46, '2020-03-20', 4.46),
(151, 4.46, '2020-03-21', 4.46),
(152, 4.46, '2020-03-22', 4.46),
(153, 4.5, '2020-03-23', 4.5),
(154, 4.5, '2020-03-24', 4.5),
(155, 4.5, '2020-03-25', 4.5),
(156, 4.5, '2020-03-26', 4.5),
(157, 4.5, '2020-03-27', 4.5),
(158, 4.5, '2020-03-28', 4.5),
(159, 4.5, '2020-03-29', 4.5),
(160, 4.59, '2020-03-30', 4.59),
(161, 4.59, '2020-03-31', 4.59),
(162, 4.59, '2020-04-01', 4.59),
(163, 4.59, '2020-04-02', 4.59),
(164, 4.59, '2020-04-03', 4.59),
(165, 4.59, '2020-04-04', 4.59),
(166, 4.59, '2020-04-05', 4.59),
(167, 4.42, '2020-04-06', 4.42),
(168, 4.42, '2020-04-07', 4.42),
(169, 4.42, '2020-04-08', 4.42),
(170, 4.42, '2020-04-09', 4.42),
(171, 4.42, '2020-04-10', 4.42),
(172, 4.42, '2020-04-11', 4.42),
(173, 4.42, '2020-04-12', 4.42),
(174, 4.43, '2020-04-13', 4.43),
(175, 4.43, '2020-04-14', 4.43),
(176, 4.43, '2020-04-15', 4.43),
(177, 4.43, '2020-04-16', 4.43),
(178, 4.43, '2020-04-17', 4.43),
(179, 4.43, '2020-04-18', 4.43),
(180, 4.43, '2020-04-19', 4.43),
(181, 4.52, '2020-04-20', 4.52),
(182, 4.52, '2020-04-21', 4.52),
(183, 4.52, '2020-04-22', 4.52),
(184, 4.52, '2020-04-23', 4.52),
(185, 4.52, '2020-04-24', 4.52),
(186, 4.52, '2020-04-25', 4.52),
(187, 4.52, '2020-04-26', 4.52),
(188, 4.66, '2020-04-27', 4.66),
(189, 4.66, '2020-04-28', 4.66),
(190, 4.66, '2020-04-29', 4.66),
(191, 4.66, '2020-04-30', 4.66),
(192, 4.66, '0000-00-00', 4.66),
(193, 4.66, '2020-05-01', 4.66),
(194, 4.66, '2020-05-02', 4.66),
(195, 4.66, '2020-05-03', 4.66),
(196, 4.53, '2020-05-04', 4.53),
(197, 4.53, '2020-05-05', 4.53),
(198, 4.53, '2020-05-06', 4.53),
(199, 4.53, '2020-05-07', 4.53),
(200, 4.53, '2020-05-08', 4.53),
(201, 4.53, '2020-05-09', 4.53),
(202, 4.53, '2020-05-10', 4.53),
(203, 4.44, '2020-05-11', 4.44),
(204, 4.44, '2020-05-12', 4.44),
(205, 4.44, '2020-05-13', 4.44),
(206, 4.44, '2020-05-14', 4.44),
(207, 4.44, '2020-05-15', 4.44),
(208, 4.44, '2020-05-16', 4.44),
(209, 4.44, '2020-05-17', 4.44),
(210, 4.36, '2020-05-18', 4.36),
(211, 4.36, '2020-05-19', 4.36),
(212, 4.36, '2020-05-20', 4.36),
(213, 4.36, '2020-05-21', 4.36),
(214, 4.36, '2020-05-22', 4.36),
(215, 4.36, '2020-05-23', 4.36),
(216, 4.36, '2020-05-24', 4.36),
(217, 4.25, '2020-05-25', 4.25),
(218, 4.25, '2020-05-26', 4.25),
(219, 4.25, '2020-05-27', 4.25),
(220, 4.25, '2020-05-28', 4.25),
(221, 4.25, '2020-05-29', 4.25),
(222, 4.25, '2020-05-30', 4.25),
(223, 4.25, '2020-05-31', 4.25),
(224, 4.17, '2020-06-01', 4.17),
(225, 4.17, '2020-06-02', 4.17),
(226, 4.17, '2020-06-03', 4.17),
(227, 4.17, '2020-06-04', 4.17),
(228, 4.17, '2020-06-05', 4.17),
(229, 4.17, '2020-06-06', 4.17),
(230, 4.17, '2020-06-07', 4.17),
(231, 3.95, '2020-06-08', 3.95),
(232, 3.95, '2020-06-09', 3.95),
(233, 3.95, '2020-06-10', 3.95),
(234, 3.95, '2020-06-11', 3.95),
(235, 3.95, '2020-06-12', 3.95),
(236, 3.95, '2020-06-13', 3.95),
(237, 3.95, '2020-06-14', 3.95),
(238, 3.83, '2020-06-15', 3.83),
(239, 3.83, '2020-06-16', 3.83),
(240, 3.83, '2020-06-17', 3.83),
(241, 3.83, '2020-06-18', 3.83),
(242, 3.83, '2020-06-19', 3.83),
(243, 3.83, '2020-06-20', 3.83),
(244, 3.83, '2020-06-21', 3.83),
(245, 3.76, '2020-06-22', 3.76),
(246, 3.76, '2020-06-23', 3.76),
(247, 3.76, '2020-06-24', 3.76),
(248, 3.76, '2020-06-25', 3.76),
(249, 3.76, '2020-06-26', 3.76),
(250, 3.76, '2020-06-27', 3.76),
(251, 3.76, '2020-06-28', 3.76),
(252, 3.71, '2020-06-29', 3.71),
(253, 3.71, '2020-06-30', 3.71),
(254, 3.71, '0000-00-00', 3.71),
(255, 3.71, '2020-07-01', 3.71),
(256, 3.71, '2020-07-02', 3.71),
(257, 3.71, '2020-07-03', 3.71),
(258, 3.71, '2020-07-04', 3.71),
(259, 3.71, '2020-07-05', 3.71),
(260, 3.6, '2020-07-06', 3.6),
(261, 3.6, '2020-07-07', 3.6),
(262, 3.6, '2020-07-08', 3.6),
(263, 3.6, '2020-07-09', 3.6),
(264, 3.6, '2020-07-10', 3.6),
(265, 3.6, '2020-07-11', 3.6),
(266, 3.6, '2020-07-12', 3.6),
(267, 3.46, '2020-07-13', 3.46),
(268, 3.46, '2020-07-14', 3.46),
(269, 3.46, '2020-07-15', 3.46),
(270, 3.46, '2020-07-16', 3.46),
(271, 3.46, '2020-07-17', 3.46),
(272, 3.46, '2020-07-18', 3.46),
(273, 3.46, '2020-07-19', 3.46),
(274, 3.38, '2020-07-20', 3.38),
(275, 3.38, '2020-07-21', 3.38),
(276, 3.38, '2020-07-22', 3.38),
(277, 3.38, '2020-07-23', 3.38),
(278, 3.38, '2020-07-24', 3.38),
(279, 3.38, '2020-07-25', 3.38),
(280, 3.38, '2020-07-26', 3.38),
(281, 3.29, '2020-07-27', 3.29),
(282, 3.29, '2020-07-28', 3.29),
(283, 3.29, '2020-07-29', 3.29),
(284, 3.29, '2020-07-30', 3.29),
(285, 3.29, '2020-07-31', 3.29),
(286, 3.29, '2020-08-01', 3.29),
(287, 3.29, '2020-08-02', 3.29),
(288, 3.14, '2020-08-03', 3.14),
(289, 3.14, '2020-08-04', 3.14),
(290, 3.14, '2020-08-05', 3.14),
(291, 3.14, '2020-08-06', 3.14),
(292, 3.14, '2020-08-07', 3.14),
(293, 3.14, '2020-08-08', 3.14),
(294, 3.14, '2020-08-09', 3.14),
(295, 3.1, '2020-08-10', 3.1),
(296, 3.1, '2020-08-11', 3.1),
(297, 3.1, '2020-08-12', 3.1),
(298, 3.1, '2020-08-13', 3.1),
(299, 3.1, '2020-08-14', 3.1),
(300, 3.1, '2020-08-15', 3.1),
(301, 3.1, '2020-08-16', 3.1),
(302, 2.93, '2020-08-17', 2.93),
(303, 2.93, '2020-08-18', 2.93),
(304, 2.93, '2020-08-19', 2.93),
(305, 2.93, '2020-08-20', 2.93),
(306, 2.93, '2020-08-21', 2.93),
(307, 2.93, '2020-08-22', 2.93),
(308, 2.93, '2020-08-23', 2.93),
(309, 2.7, '2020-08-24', 2.7),
(310, 2.7, '2020-08-25', 2.7),
(311, 2.7, '2020-08-26', 2.7),
(312, 2.7, '2020-08-27', 2.7),
(313, 2.7, '2020-08-28', 2.7),
(314, 2.7, '2020-08-29', 2.7),
(315, 2.7, '2020-08-30', 2.7),
(316, 2.64, '2020-08-31', 2.64),
(317, 2.64, '2020-09-01', 2.64),
(318, 2.64, '2020-09-02', 2.64),
(319, 2.64, '2020-09-03', 2.64),
(320, 2.64, '2020-09-04', 2.64),
(321, 2.64, '2020-09-05', 2.64),
(322, 2.64, '2020-09-06', 2.64),
(323, 2.65, '2020-09-07', 2.65),
(324, 2.65, '2020-09-08', 2.65),
(325, 2.65, '2020-09-09', 2.65),
(326, 2.65, '2020-09-10', 2.65),
(327, 2.65, '2020-09-11', 2.65),
(328, 2.65, '2020-09-12', 2.65),
(329, 2.65, '2020-09-13', 2.65),
(330, 2.5, '2020-09-14', 2.5),
(331, 2.5, '2020-09-15', 2.5),
(332, 2.5, '2020-09-16', 2.5),
(333, 2.5, '2020-09-17', 2.5),
(334, 2.5, '2020-09-18', 2.5),
(335, 2.5, '2020-09-19', 2.5),
(336, 2.5, '2020-09-20', 2.5),
(337, 2.39, '2020-09-21', 2.39),
(338, 2.39, '2020-09-22', 2.39),
(339, 2.39, '2020-09-23', 2.39),
(340, 2.39, '2020-09-24', 2.39),
(341, 2.39, '2020-09-25', 2.39),
(342, 2.39, '2020-09-26', 2.39),
(343, 2.39, '2020-09-27', 2.39),
(344, 2.32, '2020-09-28', 2.32),
(345, 2.32, '2020-09-29', 2.32),
(346, 2.32, '2020-09-30', 2.32),
(347, 2.32, '0000-00-00', 2.32),
(348, 2.32, '2020-10-01', 2.32),
(349, 2.32, '2020-10-02', 2.32),
(350, 2.32, '2020-10-03', 2.32),
(351, 2.32, '2020-10-04', 2.32),
(352, 2.14, '2020-10-05', 2.14),
(353, 2.14, '2020-10-06', 2.14),
(354, 2.14, '2020-10-07', 2.14),
(355, 2.14, '2020-10-08', 2.14),
(356, 2.14, '2020-10-09', 2.14),
(357, 2.14, '2020-10-10', 2.14),
(358, 2.14, '2020-10-11', 2.14),
(359, 2.09, '2020-10-12', 2.09),
(360, 2.09, '2020-10-13', 2.09),
(361, 2.09, '2020-10-14', 2.09),
(362, 2.09, '2020-10-15', 2.09),
(363, 2.09, '2020-10-16', 2.09),
(364, 2.09, '2020-10-17', 2.09),
(365, 2.09, '2020-10-18', 2.09),
(366, 2.04, '2020-10-19', 2.04),
(367, 2.04, '2020-10-20', 2.04),
(368, 2.04, '2020-10-21', 2.04),
(369, 2.04, '2020-10-22', 2.04),
(370, 2.04, '2020-10-23', 2.04),
(371, 2.04, '2020-10-24', 2.04),
(372, 2.04, '2020-10-25', 2.04),
(373, 1.98, '2020-10-26', 1.98),
(374, 1.98, '2020-10-27', 1.98),
(375, 1.98, '2020-10-28', 1.98),
(376, 1.98, '2020-10-29', 1.98),
(377, 1.98, '2020-10-30', 1.98),
(378, 1.98, '2020-10-31', 1.98),
(379, 1.98, '2020-11-01', 1.98),
(380, 2.01, '2020-11-02', 2.01),
(381, 2.01, '2020-11-03', 2.01),
(382, 2.01, '2020-11-04', 2.01),
(383, 2.01, '2020-11-05', 2.01),
(384, 2.01, '2020-11-06', 2.01),
(385, 2.01, '2020-11-07', 2.01),
(386, 2.01, '2020-11-08', 2.01),
(387, 1.97, '2020-11-09', 1.97),
(388, 1.97, '2020-11-10', 1.97),
(389, 1.97, '2020-11-11', 1.97),
(390, 1.97, '2020-11-12', 1.97),
(391, 1.97, '2020-11-13', 1.97),
(392, 1.97, '2020-11-14', 1.97),
(393, 1.97, '2020-11-15', 1.97),
(394, 1.98, '2020-11-16', 1.98),
(395, 1.98, '2020-11-17', 1.98),
(396, 1.98, '2020-11-18', 1.98),
(397, 1.98, '2020-11-19', 1.98),
(398, 1.98, '2020-11-20', 1.98),
(399, 1.98, '2020-11-21', 1.98),
(400, 1.98, '2020-11-22', 1.98),
(401, 1.97, '2020-11-23', 1.97),
(402, 1.97, '2020-11-24', 1.97),
(403, 1.97, '2020-11-25', 1.97),
(404, 1.97, '2020-11-26', 1.97),
(405, 1.97, '2020-11-27', 1.97),
(406, 1.97, '2020-11-28', 1.97),
(407, 1.97, '2020-11-29', 1.97),
(408, 1.96, '2020-11-30', 1.96),
(409, 1.96, '0000-00-00', 1.96),
(410, 1.96, '2020-12-01', 1.96),
(411, 1.96, '2020-12-02', 1.96),
(412, 1.96, '2020-12-03', 1.96),
(413, 1.96, '2020-12-04', 1.96),
(414, 1.96, '2020-12-05', 1.96),
(415, 1.96, '2020-12-06', 1.96),
(416, 1.95, '2020-12-07', 1.95),
(417, 1.95, '2020-12-08', 1.95),
(418, 1.95, '2020-12-09', 1.95),
(419, 1.95, '2020-12-10', 1.95),
(420, 1.95, '2020-12-11', 1.95),
(421, 1.95, '2020-12-12', 1.95),
(422, 1.95, '2020-12-13', 1.95),
(423, 1.94, '2020-12-14', 1.94),
(424, 1.94, '2020-12-15', 1.94),
(425, 1.94, '2020-12-16', 1.94),
(426, 1.94, '2020-12-17', 1.94),
(427, 1.94, '2020-12-18', 1.94),
(428, 1.94, '2020-12-19', 1.94),
(429, 1.94, '2020-12-20', 1.94),
(430, 1.94, '2020-12-21', 1.94),
(431, 1.94, '2020-12-22', 1.94),
(432, 1.94, '2020-12-23', 1.94),
(433, 1.94, '2020-12-24', 1.94),
(434, 1.94, '2020-12-25', 1.94),
(435, 1.94, '2020-12-26', 1.94),
(436, 1.94, '2020-12-27', 1.94),
(437, 1.89, '2020-12-28', 1.89),
(438, 1.89, '2020-12-29', 1.89),
(439, 1.89, '2020-12-30', 1.89),
(440, 1.89, '2020-12-31', 1.89),
(441, 4.48, '2019-01-01', 4.48),
(442, 4.48, '2019-01-02', 4.48),
(443, 4.48, '2019-01-03', 4.48),
(444, 4.48, '2019-01-04', 4.48),
(445, 4.48, '2019-01-05', 4.48),
(446, 4.49, '2019-01-06', 4.49),
(447, 4.49, '2019-01-07', 4.49),
(448, 4.49, '2019-01-08', 4.49),
(449, 4.49, '2019-01-09', 4.49),
(450, 4.49, '2019-01-10', 4.49),
(451, 4.49, '2019-01-11', 4.49),
(452, 4.49, '2019-01-12', 4.49),
(453, 4.5, '2019-01-13', 4.5),
(454, 4.5, '2019-01-14', 4.5),
(455, 4.5, '2019-01-15', 4.5),
(456, 4.5, '2019-01-16', 4.5),
(457, 4.5, '2019-01-17', 4.5),
(458, 4.5, '2019-01-18', 4.5),
(459, 4.5, '2019-01-19', 4.5),
(460, 4.43, '2019-01-20', 4.43),
(461, 4.43, '2019-01-21', 4.43),
(462, 4.43, '2019-01-22', 4.43),
(463, 4.43, '2019-01-23', 4.43),
(464, 4.43, '2019-01-24', 4.43),
(465, 4.43, '2019-01-25', 4.43),
(466, 4.43, '2019-01-26', 4.43),
(467, 4.62, '2019-01-27', 4.62),
(468, 4.62, '2019-01-28', 4.62),
(469, 4.62, '2019-01-29', 4.62),
(470, 4.62, '2019-01-30', 4.62),
(471, 4.62, '2019-01-31', 4.62),
(472, 4.62, '2019-02-01', 4.62),
(473, 4.62, '2019-02-02', 4.62),
(474, 4.58, '2019-02-03', 4.58),
(475, 4.58, '2019-02-04', 4.58),
(476, 4.58, '2019-02-05', 4.58),
(477, 4.58, '2019-02-06', 4.58),
(478, 4.58, '2019-02-07', 4.58),
(479, 4.58, '2019-02-08', 4.58),
(480, 4.58, '2019-02-09', 4.58),
(481, 4.43, '2019-02-10', 4.43),
(482, 4.43, '2019-02-11', 4.43),
(483, 4.43, '2019-02-12', 4.43),
(484, 4.43, '2019-02-13', 4.43),
(485, 4.43, '2019-02-14', 4.43),
(486, 4.43, '2019-02-15', 4.43),
(487, 4.43, '2019-02-16', 4.43),
(488, 4.49, '2019-02-17', 4.49),
(489, 4.49, '2019-02-18', 4.49),
(490, 4.49, '2019-02-19', 4.49),
(491, 4.49, '2019-02-20', 4.49),
(492, 4.49, '2019-02-21', 4.49),
(493, 4.49, '2019-02-22', 4.49),
(494, 4.49, '2019-02-23', 4.49),
(495, 4.45, '2019-02-24', 4.45),
(496, 4.45, '2019-02-25', 4.45),
(497, 4.45, '2019-02-26', 4.45),
(498, 4.45, '2019-02-27', 4.45),
(499, 4.45, '2019-02-28', 4.45),
(500, 4.45, '0000-00-00', 4.45),
(501, 4.45, '0000-00-00', 4.45),
(502, 4.45, '0000-00-00', 4.45),
(503, 4.45, '2019-03-01', 4.45),
(504, 4.43, '2019-03-02', 4.43),
(505, 4.43, '2019-03-03', 4.43),
(506, 4.43, '2019-03-04', 4.43),
(507, 4.43, '2019-03-05', 4.43),
(508, 4.43, '2019-03-06', 4.43),
(509, 4.43, '2019-03-07', 4.43),
(510, 4.43, '2019-03-08', 4.43),
(511, 4.56, '2019-03-09', 4.56),
(512, 4.56, '2019-03-10', 4.56),
(513, 4.56, '2019-03-11', 4.56),
(514, 4.56, '2019-03-12', 4.56),
(515, 4.56, '2019-03-13', 4.56),
(516, 4.56, '2019-03-14', 4.56),
(517, 4.56, '2019-03-15', 4.56),
(518, 4.46, '2019-03-16', 4.46),
(519, 4.46, '2019-03-17', 4.46),
(520, 4.46, '2019-03-18', 4.46),
(521, 4.46, '2019-03-19', 4.46),
(522, 4.46, '2019-03-20', 4.46),
(523, 4.46, '2019-03-21', 4.46),
(524, 4.46, '2019-03-22', 4.46),
(525, 4.5, '2019-03-23', 4.5),
(526, 4.5, '2019-03-24', 4.5),
(527, 4.5, '2019-03-25', 4.5),
(528, 4.5, '2019-03-26', 4.5),
(529, 4.5, '2019-03-27', 4.5),
(530, 4.5, '2019-03-28', 4.5),
(531, 4.5, '2019-03-29', 4.5),
(532, 4.59, '2019-03-30', 4.59),
(533, 4.59, '2019-03-31', 4.59),
(534, 4.59, '2019-04-01', 4.59),
(535, 4.59, '2019-04-02', 4.59),
(536, 4.59, '2019-04-03', 4.59),
(537, 4.59, '2019-04-04', 4.59),
(538, 4.59, '2019-04-05', 4.59),
(539, 4.42, '2019-04-06', 4.42),
(540, 4.42, '2019-04-07', 4.42),
(541, 4.42, '2019-04-08', 4.42),
(542, 4.42, '2019-04-09', 4.42),
(543, 4.42, '2019-04-10', 4.42),
(544, 4.42, '2019-04-11', 4.42),
(545, 4.42, '2019-04-12', 4.42),
(546, 4.43, '2019-04-13', 4.43),
(547, 4.43, '2019-04-14', 4.43),
(548, 4.43, '2019-04-15', 4.43),
(549, 4.43, '2019-04-16', 4.43),
(550, 4.43, '2019-04-17', 4.43),
(551, 4.43, '2019-04-18', 4.43),
(552, 4.43, '2019-04-19', 4.43),
(553, 4.52, '2019-04-20', 4.52),
(554, 4.52, '2019-04-21', 4.52),
(555, 4.52, '2019-04-22', 4.52),
(556, 4.52, '2019-04-23', 4.52),
(557, 4.52, '2019-04-24', 4.52),
(558, 4.52, '2019-04-25', 4.52),
(559, 4.52, '2019-04-26', 4.52),
(560, 4.66, '2019-04-27', 4.66),
(561, 4.66, '2019-04-28', 4.66),
(562, 4.66, '2019-04-29', 4.66),
(563, 4.66, '2019-04-30', 4.66),
(564, 4.66, '0000-00-00', 4.66),
(565, 4.66, '2019-05-01', 4.66),
(566, 4.66, '2019-05-02', 4.66),
(567, 4.66, '2019-05-03', 4.66),
(568, 4.53, '2019-05-04', 4.53),
(569, 4.53, '2019-05-05', 4.53),
(570, 4.53, '2019-05-06', 4.53),
(571, 4.53, '2019-05-07', 4.53),
(572, 4.53, '2019-05-08', 4.53),
(573, 4.53, '2019-05-09', 4.53),
(574, 4.53, '2019-05-10', 4.53),
(575, 4.44, '2019-05-11', 4.44),
(576, 4.44, '2019-05-12', 4.44),
(577, 4.44, '2019-05-13', 4.44),
(578, 4.44, '2019-05-14', 4.44),
(579, 4.44, '2019-05-15', 4.44),
(580, 4.44, '2019-05-16', 4.44),
(581, 4.44, '2019-05-17', 4.44),
(582, 4.36, '2019-05-18', 4.36),
(583, 4.36, '2019-05-19', 4.36),
(584, 4.36, '2019-05-20', 4.36),
(585, 4.36, '2019-05-21', 4.36),
(586, 4.36, '2019-05-22', 4.36),
(587, 4.36, '2019-05-23', 4.36),
(588, 4.36, '2019-05-24', 4.36),
(589, 4.25, '2019-05-25', 4.25),
(590, 4.25, '2019-05-26', 4.25),
(591, 4.25, '2019-05-27', 4.25),
(592, 4.25, '2019-05-28', 4.25),
(593, 4.25, '2019-05-29', 4.25),
(594, 4.25, '2019-05-30', 4.25),
(595, 4.25, '2019-05-31', 4.25),
(596, 4.17, '2019-06-01', 4.17),
(597, 4.17, '2019-06-02', 4.17),
(598, 4.17, '2019-06-03', 4.17),
(599, 4.17, '2019-06-04', 4.17),
(600, 4.17, '2019-06-05', 4.17),
(601, 4.17, '2019-06-06', 4.17),
(602, 4.17, '2019-06-07', 4.17),
(603, 3.95, '2019-06-08', 3.95),
(604, 3.95, '2019-06-09', 3.95),
(605, 3.95, '2019-06-10', 3.95),
(606, 3.95, '2019-06-11', 3.95),
(607, 3.95, '2019-06-12', 3.95),
(608, 3.95, '2019-06-13', 3.95),
(609, 3.95, '2019-06-14', 3.95),
(610, 3.83, '2019-06-15', 3.83),
(611, 3.83, '2019-06-16', 3.83),
(612, 3.83, '2019-06-17', 3.83),
(613, 3.83, '2019-06-18', 3.83),
(614, 3.83, '2019-06-19', 3.83),
(615, 3.83, '2019-06-20', 3.83),
(616, 3.83, '2019-06-21', 3.83),
(617, 3.76, '2019-06-22', 3.76),
(618, 3.76, '2019-06-23', 3.76),
(619, 3.76, '2019-06-24', 3.76),
(620, 3.76, '2019-06-25', 3.76),
(621, 3.76, '2019-06-26', 3.76),
(622, 3.76, '2019-06-27', 3.76),
(623, 3.76, '2019-06-28', 3.76),
(624, 3.71, '2019-06-29', 3.71),
(625, 3.71, '2019-06-30', 3.71),
(626, 3.71, '0000-00-00', 3.71),
(627, 3.71, '2019-07-01', 3.71),
(628, 3.71, '2019-07-02', 3.71),
(629, 3.71, '2019-07-03', 3.71),
(630, 3.71, '2019-07-04', 3.71),
(631, 3.71, '2019-07-05', 3.71),
(632, 3.6, '2019-07-06', 3.6),
(633, 3.6, '2019-07-07', 3.6),
(634, 3.6, '2019-07-08', 3.6),
(635, 3.6, '2019-07-09', 3.6),
(636, 3.6, '2019-07-10', 3.6),
(637, 3.6, '2019-07-11', 3.6),
(638, 3.6, '2019-07-12', 3.6),
(639, 3.46, '2019-07-13', 3.46),
(640, 3.46, '2019-07-14', 3.46),
(641, 3.46, '2019-07-15', 3.46),
(642, 3.46, '2019-07-16', 3.46),
(643, 3.46, '2019-07-17', 3.46),
(644, 3.46, '2019-07-18', 3.46),
(645, 3.46, '2019-07-19', 3.46),
(646, 3.38, '2019-07-20', 3.38),
(647, 3.38, '2019-07-21', 3.38),
(648, 3.38, '2019-07-22', 3.38),
(649, 3.38, '2019-07-23', 3.38),
(650, 3.38, '2019-07-24', 3.38),
(651, 3.38, '2019-07-25', 3.38),
(652, 3.38, '2019-07-26', 3.38),
(653, 3.29, '2019-07-27', 3.29),
(654, 3.29, '2019-07-28', 3.29),
(655, 3.29, '2019-07-29', 3.29),
(656, 3.29, '2019-07-30', 3.29),
(657, 3.29, '2019-07-31', 3.29),
(658, 3.29, '2019-08-01', 3.29),
(659, 3.29, '2019-08-02', 3.29),
(660, 3.14, '2019-08-03', 3.14),
(661, 3.14, '2019-08-04', 3.14),
(662, 3.14, '2019-08-05', 3.14),
(663, 3.14, '2019-08-06', 3.14),
(664, 3.14, '2019-08-07', 3.14),
(665, 3.14, '2019-08-08', 3.14),
(666, 3.14, '2019-08-09', 3.14),
(667, 3.1, '2019-08-10', 3.1),
(668, 3.1, '2019-08-11', 3.1),
(669, 3.1, '2019-08-12', 3.1),
(670, 3.1, '2019-08-13', 3.1),
(671, 3.1, '2019-08-14', 3.1),
(672, 3.1, '2019-08-15', 3.1),
(673, 3.1, '2019-08-16', 3.1),
(674, 2.93, '2019-08-17', 2.93),
(675, 2.93, '2019-08-18', 2.93),
(676, 2.93, '2019-08-19', 2.93),
(677, 2.93, '2019-08-20', 2.93),
(678, 2.93, '2019-08-21', 2.93),
(679, 2.93, '2019-08-22', 2.93),
(680, 2.93, '2019-08-23', 2.93),
(681, 2.7, '2019-08-24', 2.7),
(682, 2.7, '2019-08-25', 2.7),
(683, 2.7, '2019-08-26', 2.7),
(684, 2.7, '2019-08-27', 2.7),
(685, 2.7, '2019-08-28', 2.7),
(686, 2.7, '2019-08-29', 2.7),
(687, 2.7, '2019-08-30', 2.7),
(688, 2.64, '2019-08-31', 2.64),
(689, 2.64, '2019-09-01', 2.64),
(690, 2.64, '2019-09-02', 2.64),
(691, 2.64, '2019-09-03', 2.64),
(692, 2.64, '2019-09-04', 2.64),
(693, 2.64, '2019-09-05', 2.64),
(694, 2.64, '2019-09-06', 2.64),
(695, 2.65, '2019-09-07', 2.65),
(696, 2.65, '2019-09-08', 2.65),
(697, 2.65, '2019-09-09', 2.65),
(698, 2.65, '2019-09-10', 2.65),
(699, 2.65, '2019-09-11', 2.65),
(700, 2.65, '2019-09-12', 2.65),
(701, 2.65, '2019-09-13', 2.65),
(702, 2.5, '2019-09-14', 2.5),
(703, 2.5, '2019-09-15', 2.5),
(704, 2.5, '2019-09-16', 2.5),
(705, 2.5, '2019-09-17', 2.5),
(706, 2.5, '2019-09-18', 2.5),
(707, 2.5, '2019-09-19', 2.5),
(708, 2.5, '2019-09-20', 2.5),
(709, 2.39, '2019-09-21', 2.39),
(710, 2.39, '2019-09-22', 2.39),
(711, 2.39, '2019-09-23', 2.39),
(712, 2.39, '2019-09-24', 2.39),
(713, 2.39, '2019-09-25', 2.39),
(714, 2.39, '2019-09-26', 2.39),
(715, 2.39, '2019-09-27', 2.39),
(716, 2.32, '2019-09-28', 2.32),
(717, 2.32, '2019-09-29', 2.32),
(718, 2.32, '2019-09-30', 2.32),
(719, 2.32, '0000-00-00', 2.32),
(720, 2.32, '2019-10-01', 2.32),
(721, 2.32, '2019-10-02', 2.32),
(722, 2.32, '2019-10-03', 2.32),
(723, 2.32, '2019-10-04', 2.32),
(724, 2.14, '2019-10-05', 2.14),
(725, 2.14, '2019-10-06', 2.14),
(726, 2.14, '2019-10-07', 2.14),
(727, 2.14, '2019-10-08', 2.14),
(728, 2.14, '2019-10-09', 2.14),
(729, 2.14, '2019-10-10', 2.14),
(730, 2.14, '2019-10-11', 2.14),
(731, 2.09, '2019-10-12', 2.09),
(732, 2.09, '2019-10-13', 2.09),
(733, 2.09, '2019-10-14', 2.09),
(734, 2.09, '2019-10-15', 2.09),
(735, 2.09, '2019-10-16', 2.09),
(736, 2.09, '2019-10-17', 2.09),
(737, 2.09, '2019-10-18', 2.09),
(738, 2.04, '2019-10-19', 2.04),
(739, 2.04, '2019-10-20', 2.04),
(740, 2.04, '2019-10-21', 2.04),
(741, 2.04, '2019-10-22', 2.04),
(742, 2.04, '2019-10-23', 2.04),
(743, 2.04, '2019-10-24', 2.04),
(744, 2.04, '2019-10-25', 2.04),
(745, 1.98, '2019-10-26', 1.98),
(746, 1.98, '2019-10-27', 1.98),
(747, 1.98, '2019-10-28', 1.98),
(748, 1.98, '2019-10-29', 1.98),
(749, 1.98, '2019-10-30', 1.98),
(750, 1.98, '2019-10-31', 1.98),
(751, 1.98, '2019-11-01', 1.98),
(752, 2.01, '2019-11-02', 2.01),
(753, 2.01, '2019-11-03', 2.01),
(754, 2.01, '2019-11-04', 2.01),
(755, 2.01, '2019-11-05', 2.01),
(756, 2.01, '2019-11-06', 2.01),
(757, 2.01, '2019-11-07', 2.01),
(758, 2.01, '2019-11-08', 2.01),
(759, 1.97, '2019-11-09', 1.97),
(760, 1.97, '2019-11-10', 1.97),
(761, 1.97, '2019-11-11', 1.97),
(762, 1.97, '2019-11-12', 1.97),
(763, 1.97, '2019-11-13', 1.97),
(764, 1.97, '2019-11-14', 1.97),
(765, 1.97, '2019-11-15', 1.97),
(766, 1.98, '2019-11-16', 1.98),
(767, 1.98, '2019-11-17', 1.98),
(768, 1.98, '2019-11-18', 1.98),
(769, 1.98, '2019-11-19', 1.98),
(770, 1.98, '2019-11-20', 1.98),
(771, 1.98, '2019-11-21', 1.98),
(772, 1.98, '2019-11-22', 1.98),
(773, 1.97, '2019-11-23', 1.97),
(774, 1.97, '2019-11-24', 1.97),
(775, 1.97, '2019-11-25', 1.97),
(776, 1.97, '2019-11-26', 1.97),
(777, 1.97, '2019-11-27', 1.97),
(778, 1.97, '2019-11-28', 1.97),
(779, 1.97, '2019-11-29', 1.97),
(780, 1.96, '2019-11-30', 1.96),
(781, 1.96, '0000-00-00', 1.96),
(782, 1.96, '2019-12-01', 1.96),
(783, 1.96, '2019-12-02', 1.96),
(784, 1.96, '2019-12-03', 1.96),
(785, 1.96, '2019-12-04', 1.96),
(786, 1.96, '2019-12-05', 1.96),
(787, 1.96, '2019-12-06', 1.96),
(788, 1.95, '2019-12-07', 1.95),
(789, 1.95, '2019-12-08', 1.95),
(790, 1.95, '2019-12-09', 1.95),
(791, 1.95, '2019-12-10', 1.95),
(792, 1.95, '2019-12-11', 1.95),
(793, 1.95, '2019-12-12', 1.95),
(794, 1.95, '2019-12-13', 1.95),
(795, 1.94, '2019-12-14', 1.94),
(796, 1.94, '2019-12-15', 1.94),
(797, 1.94, '2019-12-16', 1.94),
(798, 1.94, '2019-12-17', 1.94),
(799, 1.94, '2019-12-18', 1.94),
(800, 1.94, '2019-12-19', 1.94),
(801, 1.94, '2019-12-20', 1.94),
(802, 1.94, '2019-12-21', 1.94),
(803, 1.94, '2019-12-22', 1.94),
(804, 1.94, '2019-12-23', 1.94),
(805, 1.94, '2019-12-24', 1.94),
(806, 1.94, '2019-12-25', 1.94),
(807, 1.94, '2019-12-26', 1.94),
(808, 1.94, '2019-12-27', 1.94),
(809, 1.89, '2019-12-28', 1.89),
(810, 1.89, '2019-12-29', 1.89),
(811, 1.89, '2019-12-30', 1.89),
(812, 1.89, '2019-12-31', 1.89);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `interesting_type`
--

DROP TABLE IF EXISTS `interesting_type`;
CREATE TABLE IF NOT EXISTS `interesting_type` (
  `interesting_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `interesting_type_name` varchar(80) NOT NULL,
  PRIMARY KEY (`interesting_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `interesting_type`
--

INSERT INTO `interesting_type` (`interesting_type_id`, `interesting_type_name`) VALUES
(1, 'DTF'),
(2, 'IBR'),
(3, 'Tasa Fija');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `login`
--

DROP TABLE IF EXISTS `login`;
CREATE TABLE IF NOT EXISTS `login` (
  `Login_id` int(11) NOT NULL AUTO_INCREMENT,
  `Login_password` varchar(30) NOT NULL,
  `User_id` int(11) NOT NULL,
  PRIMARY KEY (`Login_id`),
  KEY `user_login` (`User_id`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `login`
--

INSERT INTO `login` (`Login_id`, `Login_password`, `User_id`) VALUES
(1, '26dfeed238d61d520668fbc0884699', 1),
(2, '25f9e794323b453885f5181f1b624d', 2),
(3, '3526a6ca88b91bb2bcfc0487b3c050', 3),
(4, 'desarollo123', 4),
(5, 'desarollo123', 6),
(20, '202cb962ac59075b964b07152d234b', 25),
(22, '202cb962ac59075b964b07152d234b', 27),
(23, '81dc9bdb52d04dc20036dbd8313ed0', 28),
(24, '81dc9bdb52d04dc20036dbd8313ed0', 29),
(25, '81dc9bdb52d04dc20036dbd8313ed0', 30),
(26, '202cb962ac59075b964b07152d234b', 31),
(27, '202cb962ac59075b964b07152d234b', 32),
(28, '202cb962ac59075b964b07152d234b', 33),
(29, '202cb962ac59075b964b07152d234b', 34),
(30, '202cb962ac59075b964b07152d234b', 35),
(31, '202cb962ac59075b964b07152d234b', 36),
(32, '81dc9bdb52d04dc20036dbd8313ed0', 37),
(33, 'bcb759b5b8ab63b06295c7434345d7', 38),
(34, 'bcb759b5b8ab63b06295c7434345d7', 39),
(35, 'bcb759b5b8ab63b06295c7434345d7', 40),
(36, 'bcb759b5b8ab63b06295c7434345d7', 41),
(37, 'bcb759b5b8ab63b06295c7434345d7', 42),
(38, 'bcb759b5b8ab63b06295c7434345d7', 43),
(39, 'bcb759b5b8ab63b06295c7434345d7', 44);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `module`
--

DROP TABLE IF EXISTS `module`;
CREATE TABLE IF NOT EXISTS `module` (
  `Mod_id` int(11) NOT NULL AUTO_INCREMENT,
  `Mod_name` varchar(100) CHARACTER SET utf8 NOT NULL,
  PRIMARY KEY (`Mod_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `new_user`
--

DROP TABLE IF EXISTS `new_user`;
CREATE TABLE IF NOT EXISTS `new_user` (
  `Nuser_id` int(11) NOT NULL AUTO_INCREMENT,
  `User_id` int(11) NOT NULL,
  `Nuser_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `Nuser_hash` varchar(600) NOT NULL,
  `Nuser_state` tinyint(1) NOT NULL,
  PRIMARY KEY (`Nuser_id`),
  KEY `User_id` (`User_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `new_user`
--

INSERT INTO `new_user` (`Nuser_id`, `User_id`, `Nuser_date`, `Nuser_hash`, `Nuser_state`) VALUES
(1, 38, '2021-01-04 23:18:20', 'd52c6fdbfd4add62539c8a60943cf5f8', 1),
(2, 39, '2021-01-04 23:35:43', 'cc93914e7224f7ef07adb81b8822594e', 1),
(3, 40, '2021-01-04 23:46:18', '0309d289b1f6efcc66efb1657ab35a0a', 1),
(4, 41, '2021-01-04 23:48:10', '70f970f1b0d087f6902047ef7488f8e9', 1),
(5, 42, '2021-01-04 23:49:40', 'c5073d0707f5ac6a2c036cad8d916599', 1),
(6, 43, '2021-01-04 23:57:54', '6b6eeb0abd711a5acbc85e866858603d', 1),
(7, 44, '2021-01-05 00:01:20', '81e08fedc25654b64d78f729fd66251f', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `notification`
--

DROP TABLE IF EXISTS `notification`;
CREATE TABLE IF NOT EXISTS `notification` (
  `Not_id` int(11) NOT NULL AUTO_INCREMENT,
  `Form_consecutive` varchar(100) NOT NULL,
  `Not_message` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`Not_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `obligation`
--

DROP TABLE IF EXISTS `obligation`;
CREATE TABLE IF NOT EXISTS `obligation` (
  `obligation_id` int(11) NOT NULL AUTO_INCREMENT,
  `client_idmax` varchar(25) NOT NULL,
  `client_name` varchar(25) NOT NULL,
  `client_contract` varchar(25) NOT NULL,
  `Bank_id` int(11) NOT NULL,
  `credit_type_id` int(11) NOT NULL,
  `interesting_type_id` int(11) NOT NULL,
  `amortization_type_id` int(11) NOT NULL,
  `desembolso_date` date NOT NULL,
  `initial_value` double NOT NULL,
  `cuotes_number` int(5) NOT NULL,
  `residual_number` double NOT NULL DEFAULT 0,
  `dtf` float DEFAULT 0,
  `dtf_points` float DEFAULT 0,
  `ibr` float DEFAULT 0,
  `ibr_points` float DEFAULT 0,
  `fixed_rate` float DEFAULT 0,
  `Stat_id` int(11) NOT NULL,
  `obligation_cod` varchar(80) NOT NULL,
  `pay_date` date NOT NULL,
  PRIMARY KEY (`obligation_id`),
  UNIQUE KEY `obligation_cod` (`obligation_cod`),
  KEY `obligation_bank` (`Bank_id`),
  KEY `obligation_credit_type` (`credit_type_id`),
  KEY `obligation_interesting_type` (`interesting_type_id`),
  KEY `obligation_amortization_type` (`amortization_type_id`),
  KEY `obligation_status_id` (`Stat_id`)
) ENGINE=InnoDB AUTO_INCREMENT=119 DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `obligation`
--

INSERT INTO `obligation` (`obligation_id`, `client_idmax`, `client_name`, `client_contract`, `Bank_id`, `credit_type_id`, `interesting_type_id`, `amortization_type_id`, `desembolso_date`, `initial_value`, `cuotes_number`, `residual_number`, `dtf`, `dtf_points`, `ibr`, `ibr_points`, `fixed_rate`, `Stat_id`, `obligation_cod`, `pay_date`) VALUES
(97, '88202279', ' CESAR ORLANDO BERMUDEZ M', 'FU009921', 1, 1, 1, 1, '2020-12-31', 10000000, 10, 10000, 5, 5, 0, 0, 0, 4, 'prueba1', '2020-12-06'),
(99, '88202279', ' CESAR ORLANDO BERMUDEZ M', 'FU009921', 1, 1, 1, 1, '2020-12-31', 464868, 88, 484, 8, 0, 0, 0, 0, 4, 'prueba2', '2020-12-24'),
(107, '805020457', ' CENTRO NET S.A.S', 'CCP0251', 1, 1, 1, 2, '2020-11-23', 111863176, 36, 57816550, 1.97, 2.25, 0, 0, 0, 3, '28331710-1', '2021-02-06'),
(111, '830100710', ' AKAMON S.A', 'CA000117', 1, 1, 1, 2, '2020-01-30', 987654321, 48, 123456789, 5, 5, 0, 0, 0, 3, 'Prueba-10', '2020-07-30'),
(114, '88202279', ' CESAR ORLANDO BERMUDEZ M', 'FU009921', 1, 1, 1, 2, '2019-01-29', 987654321, 54, 123456789, 8, 8, 0, 0, 0, 3, 'prueba-28', '2019-07-29'),
(115, '830102841', ' SEPTIC AND SANITARY SERV', 'CA006220', 1, 1, 1, 2, '2019-01-28', 987654321, 45, 78946554, 5, 5, 0, 0, 0, 2, 'prueba-27', '2019-05-28'),
(117, '900809713', ' LICUAS SUCURSAL COLOMBIA', 'CA011021', 1, 1, 1, 2, '2020-01-31', 987654321, 45, 45645646, 5, 5, 0, 0, 0, 3, 'prueba-31', '2020-05-31'),
(118, '900939798', ' RENTING AUTOMAYOR', 'CA000000', 1, 1, 1, 2, '2020-06-12', 200000000, 48, 20000000, 5, 5, 0, 0, 0, 3, 'prueba_provision', '2021-01-12');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pay_obligation`
--

DROP TABLE IF EXISTS `pay_obligation`;
CREATE TABLE IF NOT EXISTS `pay_obligation` (
  `pay_obligation_id` int(11) NOT NULL AUTO_INCREMENT,
  `obligation_cod` varchar(80) NOT NULL,
  `pay_obligation_actual_cuote` int(11) NOT NULL,
  `pay_Date` date DEFAULT NULL,
  `pay_Dtf` float NOT NULL DEFAULT 0,
  `pay_Ibr` float NOT NULL DEFAULT 0,
  `pay_FixedRate` double NOT NULL DEFAULT 0,
  `pay_value` double NOT NULL,
  `pay_capital_value` double NOT NULL,
  `pay_residue` double NOT NULL,
  `Stat_id` int(11) NOT NULL,
  `pay_interesting_value` double NOT NULL,
  `pay_observation` varchar(500) NOT NULL,
  `pay_date_notif` date NOT NULL,
  PRIMARY KEY (`pay_obligation_id`),
  KEY `obligation_id` (`obligation_cod`),
  KEY `pay_obligation_status` (`Stat_id`)
) ENGINE=InnoDB AUTO_INCREMENT=235 DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `pay_obligation`
--

INSERT INTO `pay_obligation` (`pay_obligation_id`, `obligation_cod`, `pay_obligation_actual_cuote`, `pay_Date`, `pay_Dtf`, `pay_Ibr`, `pay_FixedRate`, `pay_value`, `pay_capital_value`, `pay_residue`, `Stat_id`, `pay_interesting_value`, `pay_observation`, `pay_date_notif`) VALUES
(185, 'prueba-1', 1, '2021-01-04', 1.97, 1.97, 0, 9289947, 8805562, 91194438, 8, 484385, 'pago 1 de 10', '2020-12-30'),
(187, '28331710-1', 1, '2020-12-30', 1.97, 1.97, 0, 1887271, 1501295, 110361881, 8, 385976, 'pago 1 de 10', '2020-12-30'),
(188, '28331710-1', 2, '2021-01-04', 1.97, 1.97, 0, 1882091, 1501295, 108860586, 8, 380796, 'asdfasdfasdf', '2020-12-30'),
(189, '28331710-1', 3, '2021-02-17', 2.01, 2.01, 0, 1880404, 1501295, 107359290, 8, 379109, '', '2021-01-06'),
(191, 'prueba-1', 2, NULL, 2.01, 2.01, 0, 9291850, 8847230, 82348465, 9, 444620, '', '2021-01-06'),
(211, 'prueba-28', 1, '2021-02-01', 4.62, 4.62, 0, 25834080, 16003658, 971650663, 8, 9830422, 'sadasdsadasdasd', '2019-02-28'),
(212, 'prueba-28', 2, '2021-02-01', 4.45, 4.45, 0, 25551263, 16003658, 955647005, 8, 9547605, 'gdhdfhgh', '2019-03-29'),
(213, 'prueba-28', 3, '2021-02-01', 4.59, 4.59, 0, 25494074, 16003658, 939643347, 8, 9490416, 'dfghdfh', '2019-04-29'),
(214, 'prueba-28', 4, '2021-02-18', 4.66, 4.66, 0, 25384296, 16003658, 923639689, 8, 9380638, '', '2019-05-29'),
(215, 'prueba-27', 1, '2021-02-01', 4.62, 4.62, 0, 27782153, 20193506, 967460815, 8, 7588648, 'sadfasdfasdfasdf', '2019-02-28'),
(216, 'prueba-27', 2, '2021-02-01', 4.45, 4.45, 0, 27500917, 20193506, 947267309, 8, 7307411, '', '2019-03-28'),
(217, 'prueba-27', 3, '2021-02-18', 4.5, 4.5, 0, 27384718, 20193506, 927073803, 8, 7191212, 'asdasdadadas', '2019-04-28'),
(224, 'prueba_provision', 1, '2021-02-10', 3.95, 3.95, 0, 5183763, 3750000, 196250000, 8, 2050000, 'hola linodo', '2020-07-12'),
(225, 'prueba_provision', 2, '2021-02-10', 3.46, 3.46, 0, 5082647, 3750000, 192500000, 8, 2000000, '123213123123', '2020-08-12'),
(226, 'Prueba-10', 1, '2021-02-18', 4.25, 4.25, 0, 25312392, 18004115, 969650206, 8, 7308277, '', '2020-06-30'),
(227, 'prueba_provision', 3, '2021-02-18', 3.1, 3.1, 0, 5003493, 3750000, 188750000, 8, 1253493, '', '2020-09-12'),
(228, 'prueba-31', 1, NULL, 4.66, 4.66, 0, 28552432, 20933526, 966720795, 9, 7618906, '', '2020-05-31'),
(229, 'prueba-28', 5, '2021-02-18', 4.25, 4.25, 0, 24941145, 16003658, 907636031, 8, 8937487, 'asdfasdf', '2019-06-29'),
(230, 'Prueba-10', 2, NULL, 3.71, 3.71, 0, 24775900, 18004115, 951646091, 9, 6771785, '', '2020-07-30'),
(231, 'prueba-28', 6, NULL, 3.71, 3.71, 0, 24418091, 16003658, 891632373, 9, 8414433, '', '2019-07-29'),
(232, 'prueba_provision', 4, '2021-02-22', 2.65, 2.65, 0, 4913045, 3750000, 185000000, 8, 1163045, 'prueba1', '2020-10-12'),
(233, 'prueba_provision', 5, '2021-02-22', 2.09, 2.09, 0, 4809052, 3750000, 181250000, 8, 1059052, 'dddsdsds', '2020-11-12'),
(234, 'prueba_provision', 6, '2021-02-22', 1.97, 1.97, 0, 4770555, 3750000, 177500000, 8, 1020555, '', '2020-12-12');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `permission`
--

DROP TABLE IF EXISTS `permission`;
CREATE TABLE IF NOT EXISTS `permission` (
  `Per_id` int(11) NOT NULL AUTO_INCREMENT,
  `Per_name` varchar(100) CHARACTER SET utf8 NOT NULL,
  PRIMARY KEY (`Per_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `provision`
--

DROP TABLE IF EXISTS `provision`;
CREATE TABLE IF NOT EXISTS `provision` (
  `id_provision` int(11) NOT NULL AUTO_INCREMENT,
  `obligation_cod` varchar(80) NOT NULL,
  `provi_inicialDate` date NOT NULL,
  `provi_lastDate` date NOT NULL,
  `provi_interesting` double NOT NULL,
  `provi_actualMonth` double NOT NULL,
  `provi_afterMonth` double NOT NULL,
  `total_provision` double NOT NULL,
  `provi_month` varchar(80) NOT NULL,
  PRIMARY KEY (`id_provision`),
  KEY `provision_obligation` (`obligation_cod`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `provision`
--

INSERT INTO `provision` (`id_provision`, `obligation_cod`, `provi_inicialDate`, `provi_lastDate`, `provi_interesting`, `provi_actualMonth`, `provi_afterMonth`, `total_provision`, `provi_month`) VALUES
(1, 'prueba_provision', '2020-12-13', '2021-01-12', 1020555, 408222, 597995, 1006217, 'December');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `recovery_password`
--

DROP TABLE IF EXISTS `recovery_password`;
CREATE TABLE IF NOT EXISTS `recovery_password` (
  `Recover_pass_id` int(11) NOT NULL,
  `User_id` int(11) NOT NULL,
  `Recover_pass_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `Recover_pass_hash` varchar(600) NOT NULL,
  `Recover_pass_state` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`Recover_pass_id`),
  KEY `recovery_password_user` (`User_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `recovery_password`
--

INSERT INTO `recovery_password` (`Recover_pass_id`, `User_id`, `Recover_pass_date`, `Recover_pass_hash`, `Recover_pass_state`) VALUES
(1, 1, '2020-12-22 22:56:11', '296154d3d6fa93a600f038683d25829a', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `role`
--

DROP TABLE IF EXISTS `role`;
CREATE TABLE IF NOT EXISTS `role` (
  `Role_id` int(11) NOT NULL,
  `Role_name` varchar(100) CHARACTER SET utf8 NOT NULL,
  PRIMARY KEY (`Role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `role`
--

INSERT INTO `role` (`Role_id`, `Role_name`) VALUES
(1, 'Root');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `security_group`
--

DROP TABLE IF EXISTS `security_group`;
CREATE TABLE IF NOT EXISTS `security_group` (
  `Sgroup_id` int(11) NOT NULL,
  `Sgroup_name` varchar(100) CHARACTER SET utf8 NOT NULL,
  PRIMARY KEY (`Sgroup_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `security_group`
--

INSERT INTO `security_group` (`Sgroup_id`, `Sgroup_name`) VALUES
(1, 'Grupo1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `security_gxmxa`
--

DROP TABLE IF EXISTS `security_gxmxa`;
CREATE TABLE IF NOT EXISTS `security_gxmxa` (
  `Sgxmxa_id` int(11) NOT NULL,
  `Sgxm_id` int(11) NOT NULL,
  `App_id` int(11) NOT NULL,
  PRIMARY KEY (`Sgxmxa_id`),
  KEY `Sgxm_id` (`Sgxm_id`),
  KEY `App_id` (`App_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `security_gxmxaxp`
--

DROP TABLE IF EXISTS `security_gxmxaxp`;
CREATE TABLE IF NOT EXISTS `security_gxmxaxp` (
  `Sgxmxaxp_id` int(11) NOT NULL,
  `Sgxmxa_id` int(11) NOT NULL,
  `Per_id` int(11) NOT NULL,
  PRIMARY KEY (`Sgxmxaxp_id`),
  KEY `Sgxmxa_id` (`Sgxmxa_id`),
  KEY `Per_id` (`Per_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `status`
--

DROP TABLE IF EXISTS `status`;
CREATE TABLE IF NOT EXISTS `status` (
  `Stat_id` int(11) NOT NULL,
  `Stat_name` varchar(30) NOT NULL,
  `Type_id` int(11) NOT NULL,
  PRIMARY KEY (`Stat_id`),
  KEY `type_status` (`Type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `status`
--

INSERT INTO `status` (`Stat_id`, `Stat_name`, `Type_id`) VALUES
(1, 'Desembolsado', 2),
(2, 'Borrador', 2),
(3, 'Activo', 2),
(4, 'Suspendido', 2),
(5, 'Anulado', 2),
(6, 'Activo', 1),
(7, 'Inactivo', 1),
(8, 'Pagado', 3),
(9, 'Por pagar', 3),
(10, 'No Pagado', 3),
(11, 'Revisado', 4);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `status_type`
--

DROP TABLE IF EXISTS `status_type`;
CREATE TABLE IF NOT EXISTS `status_type` (
  `Type_id` int(11) NOT NULL,
  `Type_name` varchar(30) NOT NULL,
  PRIMARY KEY (`Type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `status_type`
--

INSERT INTO `status_type` (`Type_id`, `Type_name`) VALUES
(1, 'Usuario'),
(2, 'Obligación'),
(3, 'Pago Obligación'),
(4, 'Formularios');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `User_id` int(11) NOT NULL,
  `User_name` varchar(80) NOT NULL,
  `User_identification` varchar(15) NOT NULL,
  `User_email` varchar(320) NOT NULL,
  `User_title` varchar(30) NOT NULL,
  `User_telephone` varchar(15) NOT NULL,
  `Stat_id` int(11) NOT NULL,
  `Role_id` int(11) NOT NULL,
  `Sgroup_id` int(11) NOT NULL,
  `Comp_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`User_id`),
  KEY `user_status` (`Stat_id`),
  KEY `Role_id` (`Role_id`),
  KEY `Sgroup_id` (`Sgroup_id`),
  KEY `Comp_id` (`Comp_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `user`
--

INSERT INTO `user` (`User_id`, `User_name`, `User_identification`, `User_email`, `User_title`, `User_telephone`, `Stat_id`, `Role_id`, `Sgroup_id`, `Comp_id`) VALUES
(1, 'cristian malaver', '11111111111', 'cristianmalaver95@gmail.com', 'TI DESARROLLO 1', '3052344577', 6, 1, 1, NULL),
(2, 'Cristian Malaver', '1000000000', 'c.malaver@rentingautomayor.com', 'Diseñadora', '1234567', 6, 1, 1, NULL),
(3, 'Laura Grisales', '1030654234', 'd.casallas@sinapsistechnologies.com.co', 'Ingeniero de Software', '3054752261', 6, 1, 1, NULL),
(4, 'Desarrollo Sinapsis', '9005222222', 'developer.sinapsist123@gmail.com', 'Desarrollador', '1234567', 6, 1, 1, NULL),
(6, 'Desarrollo Sinapsis', '9005222252', 'developer.sinapsist2@gmail.com', 'Desarrollador', '1234567', 6, 1, 1, NULL),
(25, 'Desarrollo', '123456789', 'depsist@gmail.com', 'Prueba', '1234567', 6, 1, 1, NULL),
(27, 'Diego Monterrrrroooooaaa', '10306448999', 'psist@gmail.com', 'Limpieza', '1234567897', 7, 1, 1, NULL),
(28, 'Carmen soler', '52180398', 'developer.t@gmail.com', 'Desarrollador', '123456789', 7, 1, 1, NULL),
(29, 'Lilia Romero', '825632154', 'napsist@gmail.com', 'Diseñador', '5203698', 7, 1, 1, NULL),
(30, 'Dilia Villabon', '789456123', 'develpsist@gmail.com', 'Ingeniero', '456789456', 6, 1, 1, NULL),
(31, 'Lupita Rombo', '789456132', 'st@gmail.com', 'Diseñadora Gráfica', '4651237', 7, 1, 1, NULL),
(32, 'Julio César', '7895643214', 'lerolero@gmail.com', 'Director Comercial', '45678912', 7, 1, 1, NULL),
(33, 'Jorge Alba', '12346578996', 'developer.sinapsist@hotmail.com', 'director', '456782554', 7, 1, 1, NULL),
(34, 'Violeta Rosada', '123', 'ist@gmail.com', 'Directora general', '123456', 7, 1, 1, NULL),
(35, 'Luna Lunero', '78999', 'develst@gmail.com', 'Vendedora', '4444', 7, 1, 1, NULL),
(36, 'Lupinita', '78941321', 'dev@gmail.com', 'Tintos', '12345895', 6, 1, 1, NULL),
(37, 'Duncan Nittz', '82569452', 'developer.sinapsist@gmail.com', 'Director Comercial', '12348956', 6, 1, 1, NULL),
(38, 'user prueba', '1254415814', 'pruiwew@asdas.com', 'dfsdfsd', '5645165', 7, 1, 1, NULL),
(39, 'prueba1', '51451', 'jkbhb@dsd.com', 'sdfsdgfsd', '4514511', 7, 1, 1, NULL),
(40, 'pruneb', '2131231', 'sadas@dfas.com', 'asdasd', '5451454', 7, 1, 1, NULL),
(41, 'prueba1', '123123123', 'prueba1@prueba1.com', 'desarrolador', '56156165', 7, 1, 1, NULL),
(42, 'sdfsdfgf', '84848', 'sefsdfsdf@ssdsd.cps', 'sdfds', '56151145', 7, 1, 1, NULL),
(43, 'prueba', '312312332', 'prueba1@prueba1.com', 'asdfwd|', '2321312312', 7, 1, 1, NULL),
(44, 'preuba1', '1234567890', 'prueba1@gmail.com', 'desarrollador', '3132321', 7, 1, 1, 1);

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `provision`
--
ALTER TABLE `provision`
  ADD CONSTRAINT `provision_obligation` FOREIGN KEY (`obligation_cod`) REFERENCES `obligation` (`obligation_cod`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
