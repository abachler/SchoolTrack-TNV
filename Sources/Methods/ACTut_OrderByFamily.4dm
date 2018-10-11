//%attributes = {}
  // ----------------------------------------------------
  // Nombre usuario (OS): roberto
  // Fecha y hora: 23-09-10, 17:31:55
  // ----------------------------------------------------
  // Método: ACTut_OrderByFamily
  // Descripción
  // Ordena registros en seleccion por un campo de familia. Hecho para personas
  //
  // Parámetros
  // ----------------------------------------------------

$ptr1:=$1
$ptr2:=$2
If (Count parameters:C259=3)
	$vt_orden:=$3
Else 
	$vt_orden:=">"
End if 

  //orden por familia
READ ONLY:C145([Familia:78])
READ ONLY:C145([Familia_RelacionesFamiliares:77])

ARRAY LONGINT:C221($aQR_Longint6;0)
ARRAY LONGINT:C221($aQR_Longint7;0)
ARRAY LONGINT:C221($aQR_Longint8;0)
ARRAY LONGINT:C221($aQR_Longint9;0)
ARRAY LONGINT:C221($aQR_Longint10;0)

Case of 
	: ((Table:C252(->[Personas:7]))=(Table:C252($ptr1)))
		SELECTION TO ARRAY:C260([Personas:7];$aQR_Longint6;[Personas:7]No:1;$aQR_Longint7)
End case 

KRL_RelateSelection (->[Familia_RelacionesFamiliares:77]ID_Persona:3;->[Personas:7]No:1;"")
SELECTION TO ARRAY:C260([Familia_RelacionesFamiliares:77]ID_Familia:2;$aQR_Longint8;[Familia_RelacionesFamiliares:77]ID_Persona:3;$aQR_Longint9)
KRL_RelateSelection (->[Familia:78]Numero:1;->[Familia_RelacionesFamiliares:77]ID_Familia:2;"")
If ($vt_orden=">")
	ORDER BY:C49([Familia:78];$ptr2->;>)
Else 
	ORDER BY:C49([Familia:78];$ptr2->;<)
End if 
SELECTION TO ARRAY:C260([Familia:78]Numero:1;$aQR_Longint10)

AT_OrderArraysByArray (MAXLONG:K35:2;->$aQR_Longint10;->$aQR_Longint8;->$aQR_Longint9)
AT_OrderArraysByArray (MAXLONG:K35:2;->$aQR_Longint9;->$aQR_Longint7;->$aQR_Longint6)

CREATE SELECTION FROM ARRAY:C640($ptr1->;$aQR_Longint6;"")
  //AT_Initialize (->$aQR_Longint6;->$aQR_Longint7;->$aQR_Longint8;->$aQR_Longint9;->$aQR_Longint10)