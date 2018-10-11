//%attributes = {}
  //QR_DeclareArraysCML

ARRAY TEXT:C222(at_dest_config;0)  //arreglo con los destinos que contiene una alerta de un nivel X

ARRAY TEXT:C222(at_AllDest;0)  //at_AllDest array con todos los destinos posibles
ARRAY LONGINT:C221(al_AllDest;0)

APPEND TO ARRAY:C911(at_AllDest;__ ("Alumnos"))
APPEND TO ARRAY:C911(al_AllDest;1)
APPEND TO ARRAY:C911(at_AllDest;__ ("Apoderados de Cuentas"))
APPEND TO ARRAY:C911(al_AllDest;2)
APPEND TO ARRAY:C911(at_AllDest;__ ("Apoderados Académicos"))
APPEND TO ARRAY:C911(al_AllDest;3)
  //APPEND TO ARRAY(at_AllDest;"Terceros")
  //APPEND TO ARRAY(al_AllDest;4)
ARRAY TEXT:C222(at_Intervalo_Envio;0)

APPEND TO ARRAY:C911(at_Intervalo_Envio;__ ("Envíos detenidos"))
APPEND TO ARRAY:C911(at_Intervalo_Envio;__ ("Hora"))
APPEND TO ARRAY:C911(at_Intervalo_Envio;__ ("2 Horas"))
APPEND TO ARRAY:C911(at_Intervalo_Envio;__ ("3 Horas"))
APPEND TO ARRAY:C911(at_Intervalo_Envio;__ ("4 Horas"))

ARRAY TEXT:C222(<>aModulos;0)
ARRAY LONGINT:C221(<>idModulos;0)

APPEND TO ARRAY:C911(<>aModulos;"AccountTrack")
APPEND TO ARRAY:C911(<>aModulos;"AdmissionTrack")
APPEND TO ARRAY:C911(<>aModulos;"MediaTrack")
APPEND TO ARRAY:C911(<>aModulos;"SchoolNet")
APPEND TO ARRAY:C911(<>aModulos;"SchoolTrack")
APPEND TO ARRAY:C911(<>aModulos;"TransportTrack")
APPEND TO ARRAY:C911(<>aModulos;"SchoolTrack Web Access")
APPEND TO ARRAY:C911(<>aModulos;"CommTrack")
APPEND TO ARRAY:C911(<>aModulos;"SchoolCenter")

APPEND TO ARRAY:C911(<>idModulos;0)
APPEND TO ARRAY:C911(<>idModulos;1)
APPEND TO ARRAY:C911(<>idModulos;2)
APPEND TO ARRAY:C911(<>idModulos;3)
APPEND TO ARRAY:C911(<>idModulos;4)
APPEND TO ARRAY:C911(<>idModulos;5)
APPEND TO ARRAY:C911(<>idModulos;6)
APPEND TO ARRAY:C911(<>idModulos;7)
APPEND TO ARRAY:C911(<>idModulos;8)
