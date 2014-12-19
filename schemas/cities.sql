-- phpMyAdmin SQL Dump
-- version 4.1.14
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Dec 19, 2014 at 09:58 PM
-- Server version: 5.6.17
-- PHP Version: 5.5.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `cities`
--

-- --------------------------------------------------------

--
-- Table structure for table `allies`
--

CREATE TABLE IF NOT EXISTS `allies` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `ally_id` int(11) NOT NULL,
  `response` varchar(25) NOT NULL,
  `created_at` timestamp NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `id_2` (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `allies`
--

INSERT INTO `allies` (`id`, `user_id`, `ally_id`, `response`, `created_at`) VALUES
(1, 1, 3, 'Ja tack!', '2014-12-17 14:53:06');

-- --------------------------------------------------------

--
-- Table structure for table `buildings`
--

CREATE TABLE IF NOT EXISTS `buildings` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `city_id` int(11) NOT NULL,
  `x` int(11) NOT NULL,
  `y` int(11) NOT NULL,
  `shop_item_id` int(11) NOT NULL,
  `upgrade` int(11) NOT NULL DEFAULT '1',
  `health` int(11) NOT NULL DEFAULT '100',
  `created_at` timestamp NOT NULL,
  `destroyed` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_2` (`id`),
  UNIQUE KEY `id_3` (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `buildings`
--

INSERT INTO `buildings` (`id`, `user_id`, `city_id`, `x`, `y`, `shop_item_id`, `upgrade`, `health`, `created_at`, `destroyed`) VALUES
(2, 1, 4, 125, 200, 2, 1, 100, '2014-12-16 02:34:30', 0),
(3, 1, 4, 392, 125, 1, 1, 100, '2014-12-16 02:32:07', 0),
(4, 3, 10, 392, 125, 1, 1, 100, '2014-12-16 02:44:48', 0);

-- --------------------------------------------------------

--
-- Table structure for table `characters`
--

CREATE TABLE IF NOT EXISTS `characters` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `city_id` int(11) NOT NULL,
  `current_city_id` int(11) NOT NULL,
  `title` varchar(20) NOT NULL,
  `x` int(11) NOT NULL,
  `y` int(11) NOT NULL,
  `attributes` blob NOT NULL,
  `health` int(11) NOT NULL DEFAULT '100',
  `created_at` timestamp NOT NULL,
  `updated_at` timestamp NOT NULL,
  `dead` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `characters`
--

INSERT INTO `characters` (`id`, `user_id`, `city_id`, `current_city_id`, `title`, `x`, `y`, `attributes`, `health`, `created_at`, `updated_at`, `dead`) VALUES
(1, 1, 4, 4, 'Emil', 464, 256, '', 100, '2014-12-16 04:48:57', '2014-12-16 04:48:57', 0),
(2, 1, 4, 4, 'Emil2', 504, 262, '', 100, '2014-12-16 07:05:12', '2014-12-16 07:05:12', 0),
(4, 3, 10, 10, 'John Doe', 464, 256, 0x7b7d, 100, '2014-12-16 02:44:48', '2014-12-16 02:44:48', 0);

-- --------------------------------------------------------

--
-- Table structure for table `cities`
--

CREATE TABLE IF NOT EXISTS `cities` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `title` varchar(25) NOT NULL,
  `state` smallint(6) NOT NULL DEFAULT '0',
  `environment` varchar(16) NOT NULL DEFAULT 'forest',
  `layer` varchar(10) DEFAULT NULL,
  `x` int(11) NOT NULL,
  `y` int(11) NOT NULL,
  `data` blob NOT NULL,
  `created_at` timestamp NOT NULL,
  `updated_at` timestamp NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `id_2` (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=11 ;

--
-- Dumping data for table `cities`
--

INSERT INTO `cities` (`id`, `user_id`, `title`, `state`, `environment`, `layer`, `x`, `y`, `data`, `created_at`, `updated_at`) VALUES
(3, 1, 'Emils Bäverhydda', 0, '0', NULL, 400, 300, '', '2014-12-16 06:03:56', '2014-12-16 06:03:56'),
(4, 1, 'Emils Baverhydda 2', 0, 'forest', 'grass', 200, 250, '', '2014-12-19 19:20:05', '2014-12-19 19:20:05'),
(10, 3, 'Your first city', 0, '0', NULL, 195, 157, 0x7b7d, '2014-12-16 14:44:48', '2014-12-16 14:44:48');

-- --------------------------------------------------------

--
-- Table structure for table `email_confirmations`
--

CREATE TABLE IF NOT EXISTS `email_confirmations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `usersId` int(10) unsigned NOT NULL,
  `code` char(32) NOT NULL,
  `createdAt` int(10) unsigned NOT NULL,
  `modifiedAt` int(10) unsigned DEFAULT NULL,
  `confirmed` char(1) DEFAULT 'N',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `email_confirmations`
--

INSERT INTO `email_confirmations` (`id`, `usersId`, `code`, `createdAt`, `modifiedAt`, `confirmed`) VALUES
(1, 3, 'ygTgzjo5YhC8zTYuNj8RqaY5SYvInb', 1418611941, 1418612008, 'Y'),
(2, 4, 'SqAmEgVixMDHcgY6njiEnjZiQeFY1', 1418612072, NULL, 'N'),
(3, 5, 'KHcvRVtoLSLxcZ66NbWs3f3omjNtMBq', 1418612088, NULL, 'N');

-- --------------------------------------------------------

--
-- Table structure for table `failed_logins`
--

CREATE TABLE IF NOT EXISTS `failed_logins` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `usersId` int(10) unsigned DEFAULT NULL,
  `ipAddress` char(15) NOT NULL,
  `attempted` smallint(5) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `usersId` (`usersId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `failed_logins`
--

INSERT INTO `failed_logins` (`id`, `usersId`, `ipAddress`, `attempted`) VALUES
(1, 0, '127.0.0.1', 65535);

-- --------------------------------------------------------

--
-- Table structure for table `guide_messages`
--

CREATE TABLE IF NOT EXISTS `guide_messages` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `seconds` int(11) NOT NULL,
  `message` text NOT NULL,
  `icon` varchar(10) DEFAULT NULL,
  `seen` tinyint(1) NOT NULL DEFAULT '0',
  `expire` timestamp NOT NULL,
  `created_at` timestamp NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `guide_messages`
--

INSERT INTO `guide_messages` (`id`, `user_id`, `seconds`, `message`, `icon`, `seen`, `expire`, `created_at`) VALUES
(1, 1, 0, 'Welcome {{ user.name }}!<br>I\\''m your personal guide and I''m hre to help you with your first city.', 'rocket', 0, '2014-12-19 01:09:24', '2014-12-18 20:22:06');

-- --------------------------------------------------------

--
-- Table structure for table `password_changes`
--

CREATE TABLE IF NOT EXISTS `password_changes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `usersId` int(10) unsigned NOT NULL,
  `ipAddress` char(15) NOT NULL,
  `userAgent` varchar(48) NOT NULL,
  `createdAt` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `usersId` (`usersId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `password_changes`
--

INSERT INTO `password_changes` (`id`, `usersId`, `ipAddress`, `userAgent`, `createdAt`) VALUES
(1, 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/', 1419022390);

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE IF NOT EXISTS `permissions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `profilesId` int(10) unsigned NOT NULL,
  `resource` varchar(16) NOT NULL,
  `action` varchar(16) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `profilesId` (`profilesId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=37 ;

--
-- Dumping data for table `permissions`
--

INSERT INTO `permissions` (`id`, `profilesId`, `resource`, `action`) VALUES
(5, 1, 'users', 'index'),
(6, 1, 'users', 'search'),
(7, 1, 'users', 'edit'),
(8, 1, 'users', 'create'),
(9, 1, 'users', 'delete'),
(10, 1, 'users', 'changePassword'),
(11, 1, 'profiles', 'index'),
(12, 1, 'profiles', 'search'),
(13, 1, 'profiles', 'edit'),
(14, 1, 'profiles', 'create'),
(15, 1, 'profiles', 'delete'),
(16, 1, 'permissions', 'index'),
(23, 2, 'users', 'index'),
(24, 2, 'users', 'search'),
(25, 3, 'users', 'index'),
(26, 3, 'users', 'search'),
(27, 3, 'users', 'edit'),
(28, 3, 'users', 'create'),
(29, 3, 'users', 'delete'),
(30, 3, 'users', 'changePassword'),
(31, 3, 'profiles', 'index'),
(32, 3, 'profiles', 'search'),
(33, 3, 'profiles', 'edit'),
(34, 3, 'profiles', 'create'),
(35, 3, 'profiles', 'delete'),
(36, 3, 'permissions', 'index');

-- --------------------------------------------------------

--
-- Table structure for table `profiles`
--

CREATE TABLE IF NOT EXISTS `profiles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `active` char(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `active` (`active`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `profiles`
--

INSERT INTO `profiles` (`id`, `name`, `active`) VALUES
(1, 'Administrators', 'Y'),
(2, 'Users', 'Y'),
(3, 'Read-Only', 'Y');

-- --------------------------------------------------------

--
-- Table structure for table `remember_tokens`
--

CREATE TABLE IF NOT EXISTS `remember_tokens` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `usersId` int(10) unsigned NOT NULL,
  `token` char(32) NOT NULL,
  `userAgent` varchar(120) NOT NULL,
  `createdAt` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `token` (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `reset_passwords`
--

CREATE TABLE IF NOT EXISTS `reset_passwords` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `usersId` int(10) unsigned NOT NULL,
  `code` varchar(48) NOT NULL,
  `createdAt` int(10) unsigned NOT NULL,
  `modifiedAt` int(10) unsigned DEFAULT NULL,
  `reset` char(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `usersId` (`usersId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=69 ;

--
-- Dumping data for table `reset_passwords`
--

INSERT INTO `reset_passwords` (`id`, `usersId`, `code`, `createdAt`, `modifiedAt`, `reset`) VALUES
(1, 1, 'FDzApoARUai6ZTYZSE66Ok0lJpIHc9c', 1418601620, NULL, 'N'),
(2, 1, '0quHkzP3b9nlPIgKTqvFeB1U5gLWyZQL', 1418603707, NULL, 'N'),
(3, 1, 'wd781UePTOpemy2eslNPyXbfDJc0Ll', 1418603772, NULL, 'N'),
(4, 1, 'BrWaA732oYujdbFamGjVitzM1vwCgZ6', 1418603788, NULL, 'N'),
(5, 1, 'Pfi5MpyRFvbxM22krZiOwsg9ayXS4cG', 1418603804, NULL, 'N'),
(6, 1, 'vdUJxY6m2qReWQ28RRLsmQyJbG3QEW', 1418604787, NULL, 'N'),
(7, 1, '3kUoHyhXNEYjhGJoFvUGqSysOWrTx23', 1418604821, NULL, 'N'),
(8, 1, 'Y7IGqJa1qkoDFXkb2Hz2Xzo9Nz9H4A3', 1418604875, NULL, 'N'),
(9, 1, 'NtQ6HhFEdJXyjvhFnLuobHb4RFo9LT0', 1418605013, NULL, 'N'),
(10, 1, 'BvkVL9cYZm34bfDosdKT7yEGdkniL', 1418605043, NULL, 'N'),
(11, 1, 'RZNXN98ZWc4FKZvaOWZMHZTdY80eBrv', 1418605077, NULL, 'N'),
(12, 1, 'NC03pallnh6t7OeMgYmJ22G2qcMLkSDk', 1418605082, NULL, 'N'),
(13, 1, 'eLbZO1NBjbhN4hGz472DAPIZGVtg01VT', 1418605115, NULL, 'N'),
(14, 1, 'rzivf6kfLjNsRP8V2ZS4tcLU4eBWP2', 1418605327, NULL, 'N'),
(15, 1, 'DZ5TMIBpvKZQa1CKj1nzwMHHHqby7D', 1418605366, NULL, 'N'),
(16, 1, '5GiLsQuqKfi277fftkhVXLjKGDYehce5', 1418605404, NULL, 'N'),
(17, 1, 'OQxvcaeCocbXZ7kIwJg8Z7ir87TGgk', 1418605479, NULL, 'N'),
(18, 1, '6YhLUxOS846HX5pfvh1dAaz5JPbTyz7', 1418605536, NULL, 'N'),
(19, 1, 'dwrQSHy1pcS5MhZSFPLevlSpPkA6iB', 1418605700, NULL, 'N'),
(20, 2, 'Pe76T7BW5JAyffIg1zP4MvgS5PtYj4', 1418605746, NULL, 'N'),
(21, 2, 'bXPDxwGVCmbfJrW9s74wjZL3F8bvOWl', 1418605761, NULL, 'N'),
(22, 2, 'Obn5MJDkAZuTL3Hsn4cssTdcCFGXauIj', 1418606069, NULL, 'N'),
(23, 2, 'x6PKWxqWcRb0kUFTaK6meUFgBijTQNl', 1418606130, 1418606157, 'Y'),
(24, 1, 'WRvO14tucKKn6zBLK0FZWE9ApRM1BDe', 1418606180, NULL, 'N'),
(25, 1, 'zJ8O1sZ6al1vOqYlOOkjQpTkigNqgS9', 1418606305, NULL, 'N'),
(26, 2, 'xtq7dLY0mAckGeubesml0vbq8zoQdJ2R', 1418606419, NULL, 'N'),
(27, 2, 'jAct6kQS97FCe9e7e29EPJVPDF1Ltzr', 1418607033, NULL, 'N'),
(28, 2, 'bkU4eyGZkH97FtjAV32n3lDQ0mtKxQ', 1418607072, NULL, 'N'),
(29, 2, 'ZZ5zDecmLOygyX1SEL2IWI62HtVUu', 1418607229, NULL, 'N'),
(30, 2, 'Aa0r0eErZTzRcidbD3Pwp8H2hoDS5abg', 1418607266, NULL, 'N'),
(31, 2, 's48asrrUQOoNyWGEzlwYMkvUM2dQW8B', 1418607505, NULL, 'N'),
(32, 2, 'BBVgdKe9L9ZaPGZR9ek7XFMaJ1HTgcLb', 1418607976, NULL, 'N'),
(33, 2, 'sofZjUafvsMX9VA52qoY8eE8qD2Cg6h', 1418608115, NULL, 'N'),
(34, 2, 'NsKI05Q5no3vE7fVVELiINzocb0cgBNP', 1418608686, NULL, 'N'),
(35, 2, 'ss4gLqPnAEvkAqdbISomcBYmQPl3N0', 1418608706, NULL, 'N'),
(36, 2, 'RSI93ID81AlgvLxYoUWwvX1CFnOPs0j', 1418609097, NULL, 'N'),
(37, 2, '0yIww94yi1BhaNylNEvO3YRsiZDsY7', 1418609258, NULL, 'N'),
(38, 2, 'jNTy5us1BbDK11v7P0H7iSZRzJVOP7Qe', 1418609470, NULL, 'N'),
(39, 2, 'TF2W1hWBwvHxFqw54oMs0aW7kLL7x5U', 1418609495, NULL, 'N'),
(40, 2, 'OiCihLsrIUfRt8YSqeR4vp85LStA08O', 1418609905, NULL, 'N'),
(41, 2, 'owKsBR0apZIVjDfCDjAxf9RlMtFbD0io', 1418610013, NULL, 'N'),
(42, 2, 'Mo8sk5OvGj6AHzg7zL8zN5055zjfz9k', 1418610104, NULL, 'N'),
(43, 2, 'ymvCcrkq8RtQsex2lpfnS3ShfeI28pC', 1418610134, NULL, 'N'),
(44, 2, 'gQZw0XQPO4QN4wREbJNsDzl1qfh3IDWX', 1418610154, NULL, 'N'),
(45, 2, 'qOkRbKCxReiZUSbyi4y1zckPTiDpZaY1', 1418610177, NULL, 'N'),
(46, 2, 'uqZLypEHMZQHgsXLRCzLhdLDr2FNNQlq', 1418610189, NULL, 'N'),
(47, 2, '3K58el3MwZqUnlVQHwA3WfCUkfM68pn', 1418610288, NULL, 'N'),
(48, 2, 'MjF5WjqgstelYL6CBGsd4vFsDtzff5J', 1418610354, NULL, 'N'),
(49, 2, 'y1MWSHDEIFPS50DYbf0oDId7EWuVI4i', 1418610435, NULL, 'N'),
(50, 2, 'ScL2gkz0czVQJa3a4EDmURriLRc7CYfX', 1418610468, NULL, 'N'),
(51, 2, 'JYAYBDLJKCTOtfj7dMRrnj87uZ', 1418610623, NULL, 'N'),
(52, 2, 'TYaWTvCJNv0C3HRG004NDAtjMRYgGrvt', 1418610709, NULL, 'N'),
(53, 2, 'Ou0wvGZluSI3i2Hueom3Mk2EY7NoZvaf', 1418610824, NULL, 'N'),
(54, 2, '585LfivZyw5Waul0HGaBiWVceIyK', 1418610855, NULL, 'N'),
(55, 2, 'KlviU24T1UxClRa3sctyqG6htE4v', 1418611067, NULL, 'N'),
(56, 2, 'GhdIslCNkJokGG313cipp50mOUHank7', 1418611110, NULL, 'N'),
(57, 2, 'WJMWInQHdyeQ3CQL86Yixi3BQou9pF', 1418611129, NULL, 'N'),
(58, 2, 'cdCltpYmBUlyComMGIOFLwtNFjmnXj', 1418611198, NULL, 'N'),
(59, 2, 'Vn5Ioo100TRK65ZoOy3wmyCbsV82zvRN', 1418611243, NULL, 'N'),
(60, 2, 'GfwTD7gUeJAWg1d2f9adiIF8aXwiJi3', 1418611260, NULL, 'N'),
(61, 2, 'Ob0ZyYWuLiIkuxWtTzF0KuaGuV1UCmOc', 1418611481, NULL, 'N'),
(62, 2, 'AnIPDgAqW82qhQ6doMqeo0qzISZbGvF', 1418611496, NULL, 'N'),
(63, 2, '6uH6mAG4KbfWjUoVod9R4rld1EIpzJJC', 1418611540, NULL, 'N'),
(64, 2, 'e9UYx3ODVrbWxKWxBHm8jPBpcvsM1DA', 1418611588, NULL, 'N'),
(65, 2, 'vYvfR6fE6Vh7ew6bsKaBvHXIcrLwA2J', 1418611611, NULL, 'N'),
(66, 2, 'aZ6kuvoixooPE0flXT5Ez21Qxtqrnst', 1418611645, NULL, 'N'),
(67, 1, 'xN9i7uHIARnuSRJhn1flRqsBnKWT5buJ', 1418611772, NULL, 'N'),
(68, 1, 'h9MBiL3EDqOSz5ZHunDHq1SYWqh9eF', 1418611832, NULL, 'N');

-- --------------------------------------------------------

--
-- Table structure for table `resources`
--

CREATE TABLE IF NOT EXISTS `resources` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `stone` int(11) NOT NULL DEFAULT '0',
  `wood` int(11) NOT NULL DEFAULT '0',
  `food` int(11) NOT NULL DEFAULT '0',
  `gold` int(11) NOT NULL,
  `last_fillup` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fillup_interval` int(11) NOT NULL DEFAULT '5',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `shop`
--

CREATE TABLE IF NOT EXISTS `shop` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(10) NOT NULL,
  `title` varchar(20) NOT NULL,
  `width` int(11) NOT NULL,
  `length` int(11) NOT NULL,
  `description` text NOT NULL,
  `attributes` blob NOT NULL,
  `price` blob NOT NULL,
  `resource_folder` varchar(25) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `shop`
--

INSERT INTO `shop` (`id`, `type`, `title`, `width`, `length`, `description`, `attributes`, `price`, `resource_folder`) VALUES
(1, 'building', 'Home', 178, 129, 'This is your home, you better protect it because you will be homeless if someone destroys it!', 0x7b0a202022776f6f64223a20352c0a202022666f6f64223a20352c0a20202273746f6e65223a20350a7d, '', 'buildings/home'),
(2, 'building', 'Windmill', 100, 100, '', 0x7b0a202022666f6f64223a203520200a7d, 0x7b0a202022776f6f64223a20323020200a7d, 'buildings/windmill');

-- --------------------------------------------------------

--
-- Table structure for table `success_logins`
--

CREATE TABLE IF NOT EXISTS `success_logins` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `usersId` int(10) unsigned NOT NULL,
  `ipAddress` char(15) NOT NULL,
  `userAgent` varchar(120) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `usersId` (`usersId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=38 ;

--
-- Dumping data for table `success_logins`
--

INSERT INTO `success_logins` (`id`, `usersId`, `ipAddress`, `userAgent`) VALUES
(1, 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36'),
(2, 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36'),
(3, 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36'),
(4, 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36'),
(5, 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36'),
(6, 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36'),
(7, 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36'),
(8, 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36'),
(9, 3, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36'),
(10, 3, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36'),
(11, 3, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36'),
(12, 3, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36'),
(13, 3, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36'),
(14, 3, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36'),
(15, 3, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36'),
(16, 3, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36'),
(17, 3, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36'),
(18, 3, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36'),
(19, 3, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36'),
(20, 3, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36'),
(21, 3, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36'),
(22, 3, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36'),
(23, 3, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36'),
(24, 3, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36'),
(25, 3, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36'),
(26, 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36'),
(27, 3, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36'),
(28, 3, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36'),
(29, 3, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36'),
(30, 3, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36'),
(31, 3, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36'),
(32, 3, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36'),
(33, 3, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36'),
(34, 3, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36'),
(35, 3, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36'),
(36, 3, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36'),
(37, 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` char(60) NOT NULL,
  `mustChangePassword` char(1) DEFAULT NULL,
  `profilesId` int(10) unsigned NOT NULL,
  `banned` char(1) NOT NULL,
  `suspended` char(1) NOT NULL,
  `active` char(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `profilesId` (`profilesId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=7 ;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `mustChangePassword`, `profilesId`, `banned`, `suspended`, `active`) VALUES
(1, 'Emil Thidell', 'mail@emil.ninja', '$2a$08$Gl6i8unSG/XYiqBkbCL3Re4N6Q9Z7s.Dwb0rCEYckj5G76KEJVbdS', 'N', 1, 'N', 'N', 'Y'),
(2, 'Emil', 'mail@emilthidell.se', '$2a$08$f4llgFQQnhPKzpGmY1sOuuu23nYfXYM/EVOpnjjvAmbxxDxG3pbX.', 'N', 1, 'Y', 'Y', 'Y'),
(3, 'Bojakasha', 'emil@catenamedia.com', '$2a$08$Hp89tgQYEGd1Lj5wDpcDT.vQIrWN5TsbfIr2A6wyPSbUgdzR36npS', 'N', 2, 'N', 'N', 'Y'),
(4, 'Emil Test', 'testset', '$2a$08$EA64qS60SbzvOgi34uX3ROixja3VqBjnqbbdQscSzfG6F7.Z8JTGe', 'Y', 2, 'N', 'N', 'N'),
(5, 'aSADASD', '2asd@asdad.com', '$2a$08$2pPvQ1UPCZ0RCq6YjDRXO.PvogQa/NaGTOChtny51tMDKUndM6ghC', 'Y', 2, 'N', 'N', 'N'),
(6, 'Test User', 'test@test.com', '$2a$08$Gl6i8unSG/XYiqBkbCL3Re4N6Q9Z7s.Dwb0rCEYckj5G76KEJVbdS', '0', 1, 'N', 'N', 'Y');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
