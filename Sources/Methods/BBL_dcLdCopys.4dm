//%attributes = {}
  //BBL_dcLdCopys

C_LONGINT:C283($i)
AL_UpdateArrays (xALP_Copy;0)
ARRAY INTEGER:C220(aCpyNo;0)
ARRAY TEXT:C222(atBBL_CopyBarCode;0)
ARRAY LONGINT:C221(alBBL_CopyID;0)
ARRAY LONGINT:C221(aCpyBCode;0)
ARRAY TEXT:C222(aTxtStatus;0)
ARRAY TEXT:C222(aCpyPlace;0)
ARRAY TEXT:C222(atBBL_CopyNotes;0)
ARRAY TEXT:C222(aCpyVol;0)
ARRAY DATE:C224(adBBL_dateBk;0)

READ ONLY:C145([BBL_Reservas:115])
QUERY:C277([BBL_Reservas:115];[BBL_Reservas:115]ID_Item:2=[BBL_Items:61]Numero:1)
iResv:=Records in selection:C76([BBL_Reservas:115])


  // Modificado por: Alexis Bustamante (29/08/2017) TICKET 187339 
ARRAY TEXT:C222($at_Nombres;0)
C_TEXT:C284($t_texto)
AT_DistinctsFieldValues (->[BBL_Reservas:115]UserName:6;->$at_Nombres)
$t_texto:=AT_array2text (->$at_Nombres;"\n")
OBJECT SET HELP TIP:C1181(iResv;$t_texto)

READ ONLY:C145([BBL_Registros:66])
QUERY:C277([BBL_Registros:66];[BBL_Registros:66]Número_de_item:1=[BBL_Items:61]Numero:1)
  //ORDER BY([BBL_Registros];[BBL_Registros]No_de_registro;>)

SELECTION TO ARRAY:C260([BBL_Registros:66]Número_de_volumen:19;aCpyvol;[BBL_Registros:66]Número_de_copia:2;aCpyNo;[BBL_Registros:66]Barcode_SinFormato:26;atBBL_CopyBarCode;[BBL_Registros:66]ID:3;alBBL_CopyID;[BBL_Registros:66]Lugar:13;aCpyPlace;[BBL_Registros:66]Status:10;aTxtStatus;[BBL_Registros:66]Prestado_hasta:14;ad_dateBk;[BBL_Registros:66]Comentario:11;atBBL_CopyNotes)

iDispo:=0

iOut:=0
iTotal:=Size of array:C274(aCpyNo)
AL_UpdateArrays (xALP_Copy;-2)
AL_SetLine (xALP_Copy;0)
For ($i;1;Size of array:C274(aTxtStatus))
	Case of 
		: (aTxtStatus{$i}=<>aCpyStatus{1})
			AL_SetRowColor (xALP_Copy;$i;"";192)
			iDispo:=iDispo+1
		: (aTxtStatus{$i}=<>aCpyStatus{2})
			iOut:=iOut+1
			AL_SetRowColor (xALP_Copy;$i;"";4)
		Else 
			AL_SetRowColor (xALP_Copy;$i;"";16)
	End case 
End for 
ALP_SetDefaultAppareance (xALP_Copy)
AL_SetSort (xALP_Copy;1)
ALP_SetAlternateLigneColor (xALP_Copy;Size of array:C274(aTxtStatus))
  // FRC
  // BBLitm_LeePrestamos (->alBBL_CopyID)
If (Size of array:C274(alBBL_CopyID)>0)
	ARRAY LONGINT:C221($al_copyID;0)
	APPEND TO ARRAY:C911($al_copyID;alBBL_CopyID{1})
	BBLitm_LeePrestamos (->$al_copyID)
Else 
	BBLitm_LeePrestamos (->alBBL_CopyID)
End if 

alBBL_CopyID:=0