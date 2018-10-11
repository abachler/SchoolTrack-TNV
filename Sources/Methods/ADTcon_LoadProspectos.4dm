//%attributes = {}
  //ADTcon_LoadProspectos

C_LONGINT:C283($idContacto;$1)
If (Count parameters:C259=1)
	$idContacto:=$1
Else 
	$idContacto:=[ADT_Contactos:95]ID:1
End if 
ARRAY TEXT:C222(aProsApPaterno;0)
ARRAY TEXT:C222(aProsApMaterno;0)
ARRAY TEXT:C222(aProsNombres;0)
ARRAY TEXT:C222(aProsNivel;0)
ARRAY TEXT:C222(aProsEdad;0)
ARRAY LONGINT:C221(aProsID;0)
ARRAY DATE:C224(aProsFechaNac;0)
ARRAY TEXT:C222(aProsNota;0)
_O_ARRAY STRING:C218(3;aProsSexo;0)
ARRAY INTEGER:C220(aProsNivelNum;0)
ARRAY BOOLEAN:C223(aProsMod;0)
ARRAY TEXT:C222(aProsRelacion;0)
READ ONLY:C145([ADT_Prospectos:163])
QUERY:C277([ADT_Prospectos:163];[ADT_Prospectos:163]ID_Contacto:2=$idContacto)
SELECTION TO ARRAY:C260([ADT_Prospectos:163]ID:1;aProsID;[ADT_Prospectos:163]Apellido_Paterno:3;aProsApPaterno;[ADT_Prospectos:163]Apellido_Materno:4;aProsApMaterno;[ADT_Prospectos:163]Nombres:5;aProsNombres;[ADT_Prospectos:163]Postula_a:11;aProsNivelNum;[ADT_Prospectos:163]Fecha_de_Nacimiento:9;aProsFechaNac)
SELECTION TO ARRAY:C260([ADT_Prospectos:163]Nota:8;aProsNota;[ADT_Prospectos:163]Sexo:7;aProsSexo;[ADT_Prospectos:163]Relacion_con_Contacto:10;aProsRelacion)
For ($i;1;Size of array:C274(aProsID))
	APPEND TO ARRAY:C911(aProsMod;False:C215)
	APPEND TO ARRAY:C911(aProsEdad;DT_ReturnAgeLongString (aProsFechaNac{$i}))
	$pos:=Find in array:C230(aiADT_NivNo;aProsNivelNum{$i})
	If ($pos#-1)
		APPEND TO ARRAY:C911(aProsNivel;atADT_NivName{$pos})
	Else 
		APPEND TO ARRAY:C911(aProsNivel;"")
	End if 
End for 