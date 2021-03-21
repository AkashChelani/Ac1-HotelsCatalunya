#EXERCICI 1	
/*Digues alguna de les reserves que tenen menys nits(més curta). Mostra només la reserva_id i el número de nits.
Mostra el camp reserva_id i el número de nits.Ordena el resultat per el camp reserva_id de forma ascendent.
*/
SELECT reserva_id, MIN(DATEDIFF(data_fi,data_inici)) AS nits
	FROM reserves
GROUP BY reserva_id
ORDER BY reserva_id ASC;

#EXERCICI 2

/*
Quants mesos té la reserva més curta de la BD?
Expressa el resultat en mesos i arrodonint el resultat a 0 decimals.
*/

SELECT ROUND(MIN(TIMESTAMPDIFF(MONTH, data_inici,data_fi)),0) AS mesos
  FROM reserves ;




#EXERCICI 3
/*
Ordena el nom dels hotels per longitud del seu nom (de més llarg a menys) i per nom lexicogràficament ascendentment(A,B,C)
*/
SELECT nom
FROM hotels
GROUP BY hotel_id
ORDER BY MAX(LENGTH(nom)) DESC, nom ASC;
   
   
#EXERCICI 4
/*
Mostra els clients que els hi coincideix el dia de naixement amb el mes.
Mostra el nom,el primer cognom i la data de naixement.
Ordena el resultat per client_id.
*/
SELECT c.nom, c.cognom1, c.data_naix
	FROM clients c
WHERE DAY(c.data_naix) = MONTH(c.data_naix)
ORDER BY c.client_id;

                    
#EXERCICI 5
/*
Digues alguna de les reserves que tenen més nits. Mostra només la reserva_id i el número de nits.
Mostra el camp reserva_id i el número de nits.Ordena el resultat per el camo reserva_id de forma ascendent.
*/
SELECT reserva_id, MAX(DATEDIFF(data_fi,data_inici)) AS nits
	FROM reserves
GROUP BY reserva_id;



#EXERCICI 6
/*
Mostra quants carrers diferents tenim entrats a la BD.
Només contempla les adreces que tenen el caràcter ',' per separar el nom del carrer i el número.
No contemplis noms de carrers amb diferents idiomes. Si un carrer està en català i en castellà seran dos carrers diferents.
Ordena el resultat per adreça.
*/
	
SELECT COUNT(DISTINCT TRIM(SUBSTR(h.adreca,1,INSTR(h.adreca,',')-1))) AS quantitat
  FROM hotels h
WHERE NOT TRIM(SUBSTR(h.adreca,1,INSTR(h.adreca,',')-1)) IS NULL
    AND TRIM(SUBSTR(h.adreca,1,INSTR(h.adreca,',')-1)) != '';




#PREGUNTA 7
/*
Mostra els hotels que tenen el mateix número d'habitacions que l'hotel "987 Barcelona" de Barcelona

    Mostra el nom dels hotels amb les seves poblacions
    Els hotels coincidents no cal que siguin de Barcelona
    Utilitza el camp habitacions de la taula hotels.
    No pots utilitzar l'identificador de l'hotel "987 Barcelona"
    No s'ha de mostrar l'hotel "987 Barcelona"
    Ordena el resultat per nom de l'hotel.
*/

SELECT h.nom hotel, p.nom poblacio
  FROM hotels h
  INNER JOIN poblacions p ON p.poblacio_id = h.poblacio_id
  INNER JOIN hotels  ON hotels.habitacions = h.habitacions AND hotels.hotel_id != h.hotel_id
WHERE hotels.nom = '987 Barcelona'
ORDER BY h.nom;





#PREGUNTA 8

/*
Mostra el codi client, el nom i el primer cognom dels clients que han realitzat  menys de  3 reserves durant l'any 2016

Una reserva pertany a l'any si la seva data d'inici hi pertany.
Ordena el resultat per codi client.
*/

SELECT c.client_id,nom,cognom1,(COUNT(r.reserva_id)) num_reserves FROM clients c
INNER JOIN reserves r  ON c.client_id = r.client_id
WHERE YEAR(data_inici) = 2016 
GROUP BY r.client_id
HAVING COUNT(r.reserva_id) < 3
ORDER BY r.client_id;




#PREGUNTA 9
/*
Mostra el codi client, el nom i el primer cognom dels clients que han realitzat  exactament 3 reserves durant l'any 2016

Una reserva pertany a l'any si la seva data d'inici hi pertany.
Ordena el resultat per codi client.
*/

SELECT c.client_id,nom,cognom1,(COUNT(r.reserva_id)) num_reserves FROM clients c
INNER JOIN reserves r  ON c.client_id = r.client_id
WHERE YEAR(data_inici) = 2016 
GROUP BY r.client_id
HAVING COUNT(r.reserva_id) = 3
ORDER BY r.client_id;





#PREGUNTA 10

/*
Mostra el rànquing dels 5 primers països amb més reserves durant l’any 2016.

Mostra per cada país el seu nom i el número de reserves
Una reserva pertany a l'any si la seva data d'inici hi pertany.
*/

SELECT paisos.nom,COUNT(reserva_id) num_reserves FROM reserves
INNER JOIN clients  ON clients.client_id = reserves.client_id
INNER JOIN paisos ON paisos.pais_id = clients.pais_origen_id
WHERE YEAR(data_inici) = 2016 
GROUP BY paisos.nom 
ORDER BY num_reserves DESC LIMIT 5;



#PREGUNTA 11

/*
RECURSIVITAT

MOSTRA EL NÚMERO DE NITS QUE HI HA CADA MES ENTRE DUES DATES.
DATA_INICI=2016-01-31 DATA_FI=2016-12-31

*/
 
SELECT MONTH(DATE("2016-01-31")) mes,TIMESTAMPDIFF(DAY, DATE("2016-01-31"),DATE("2016-12-31"))  nits 
GROUP BY MONTH(nits)
ORDER BY MONTH(mes) ASC;




#PREGUNTA 12 
/*
MOSTRA EL CLIENT_ID,NOM,COGNOM DELS CLIENTS QUE HAGIN FET ALGUNA RESERVA L'ANY 2015,
PERO QUE NO HAGIN FET CAP RESERVA L'ANY 2014. ORDENA PER CLIENT_ID.
*/
SELECT c.client_id,nom,cognom1  FROM clients c
INNER JOIN reserves r  ON c.client_id = r.client_id
WHERE YEAR(data_inici) = 2015  AND YEAR(data_inici)!= 2014
GROUP BY r.client_id
ORDER BY r.client_id;





#PREGUNTA 13 
/*MOSTRA EL PAIS_ID DELS PAISOS AMB MENYS CLIENTS.
*/

SELECT p.pais_id  FROM paisos p 
INNER JOIN clients ON p.pais_id = clients.pais_origen_id
GROUP BY pais_id
ORDER BY COUNT(client_id) ASC limit 1;




