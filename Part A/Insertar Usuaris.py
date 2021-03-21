import mysql.connector
import csv
import random



#Ens Connectem a la Base de dades
mydb = mysql.connector.connect(host='192.168.56.102',user='perepi',passwd='pastanaga',db='db_hotels')
cursor = mydb.cursor()






dni1=str('46192019S')
dni2=str('46256143S')
dni3=str('46889204Y')
dni4=str('20578188L')


suma=0;

for xifra in dni1+dni2+dni3+dni4:      # Suma els DNIS
    if xifra.isdecimal():              # Perquè agafi només els números i no la lletra

        suma+=int(xifra)
        mod=suma%2

print(suma)                         #Mostra la suma dels DNIS
print(mod)                          #Mostra el resultat de la fórmula  


if mod==0:
   fitxer='dades_clients-tab.csv'
   print("S'ha afegit el clients-tab")         # Això per comprovar que s'afegeixi el csv
   delimitador='\t'
   
else:
    fitxer='dades_clients-puntcoma.csv'
    print("S'ha afegit el clients-puntcoma")
    delimitador=';'


#Obrim el CSV
with open (fitxer,'r') as fitxer_csv:
    FitxerCSV = csv.reader(fitxer_csv, delimiter=delimitador)



    capçalera = next(FitxerCSV) #Això, el next i el if, el que fa és perquè el programa CSV es salti la capçalera 
    if capçalera != None:


        for fila in FitxerCSV: #Recorreix i llegeix totes les files del CSV que contenen la informació per afegir
            Files = (fila[0], fila[1], fila[2], fila[3], fila[4], fila[5])


            #Transformar la data de dd/mm/yyyy --> yyyy-mm-dd

            data = fila[4].split("/")
            nova_data_naixement = data[2] + "-" + data[1] + "-" + data[0]

            #Afegim la nova fila de data_naixement "nova_data_naixement" a Files2
            Files2 = (fila[0], fila[1], fila[2], fila[3], nova_data_naixement, fila[5])



            #Fem insert per afegir cap al SQL
            insert = "INSERT INTO clients (client_id, nom, cognom1, sexe, data_naixement, pais_origen_id) VALUES (%s,%s,%s,%s,%s,%s)"

           

            #Executem el insert i el camp Files2 *IMPORTANT* perquè s'afegeixin
            cursor.execute(insert, Files2)
            

#Tarda una estona a inserir tots els clients
print("S'estan inserint tots els clients, si us plau esperi...")

#Bucle per inserir en cada reserva un client_id aleatori
client_min=10001
client_max=27944
r_id_max=26991        #El max de reserva_id és 26990 però el range sempre arriba fins a un número menys. Per aixo posem un número de més.
for r_id in range(r_id_max):
    
    aleatori=random.randint(client_min,client_max)
    update=("UPDATE reserves SET client_id = %s  WHERE reserva_id= %s")
    val=(aleatori,r_id)
    cursor.execute(update,val)
    r_id+=1



mydb.commit()
cursor.close()
mydb.close

print ("S'han registrat tots els clients correctament")
