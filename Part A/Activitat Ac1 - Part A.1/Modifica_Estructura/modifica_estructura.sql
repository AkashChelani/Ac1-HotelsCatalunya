
use db_hotels;

#Crearem la taula de Clients
CREATE TABLE clients(
  client_id	                               INT(10) UNSIGNED AUTO_INCREMENT NOT NULL  ,
  nom                                      VARCHAR(30) DEFAULT NULL,
  cognom1                                  VARCHAR(30) DEFAULT NULL,
  sexe                                     ENUM('M','F') DEFAULT  NULL,
  data_naixement                           DATE DEFAULT NULL,
  pais_origen_id 						               TINYINT(4) UNSIGNED DEFAULT NULL ,
  
  CONSTRAINT PK_client_id 				         PRIMARY KEY (client_id),
  
  CONSTRAINT FK_CLIENTS_PAISOS             FOREIGN KEY (pais_origen_id)
    REFERENCES paisos (pais_id)
);


#Afegirem la columna client_id i la FK_RESERVES_CLIENTS a la taula de reserves
ALTER TABLE reserves
  ADD COLUMN client_id 						         INT UNSIGNED,
  ADD CONSTRAINT FK_RESERVES_CLIENTS       FOREIGN KEY (client_id)
    REFERENCES clients (client_id);




