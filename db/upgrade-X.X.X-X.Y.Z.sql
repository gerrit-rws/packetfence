--
-- PacketFence SQL schema upgrade from X.X.X to X.Y.Z
--

--
-- Alter locationlog
--

ALTER TABLE `locationlog` ADD `connection_sub_type` varchar(50) default NULL AFTER connection_type;

--
-- Alter locationlog_archive
--

ALTER TABLE `locationlog_archive`
    ADD `connection_sub_type` varchar(50) default NULL AFTER connection_type;

--
-- Setting the major/minor/sub-minor version of the DB
--

SET @MAJOR_VERSION = 5;
SET @MINOR_VERSION = 2;
SET @SUBMINOR_VERSION = 0;

--
-- The VERSION_INT to ensure proper ordering of the version in queries
--

SET @VERSION_INT = @MAJOR_VERSION << 16 | @MINOR_VERSION << 8 | @SUBMINOR_VERSION;

--
-- Updating to current version
--

INSERT INTO pf_version (id, version) VALUES (@VERSION_INT, CONCAT_WS('.', @MAJOR_VERSION, @MINOR_VERSION, @SUBMINOR_VERSION));

