//%attributes = {}
  //BBLcfg_GruposLectoresPorDefecto()
  // Por: Alberto Bachler: 21/11/13, 09:44:18
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($b_guardar)

ARRAY TEXT:C222(<>atBBL_GruposLectores;0)
ARRAY LONGINT:C221(<>alBBL_GruposLectores;0)
_O_ARRAY STRING:C218(3;<>asBBL_AbrevGruposLectores;0)

C_LONGINT:C283(<>vlBBL_GrupoLectorPorDefecto)

  // grupos de lectores por omisión
ARRAY TEXT:C222($at_BBL_GruposLectores;5)
ARRAY LONGINT:C221($al_BBL_GruposLectores;5)
_O_ARRAY STRING:C218(3;$as_BBL_AbrevGruposLectores;5)
$at_BBL_GruposLectores{1}:=__ ("Alumnos")
$at_BBL_GruposLectores{2}:=__ ("Docentes y para-docentes")
$at_BBL_GruposLectores{3}:=__ ("Apoderados y otras relaciones")
$at_BBL_GruposLectores{4}:=__ ("Ex-alumnos")
$at_BBL_GruposLectores{5}:=__ ("Usuarios externos")
$al_BBL_GruposLectores{1}:=-1
$al_BBL_GruposLectores{2}:=-2
$al_BBL_GruposLectores{3}:=-3
$al_BBL_GruposLectores{4}:=-4
$al_BBL_GruposLectores{5}:=-5
$as_BBL_AbrevGruposLectores{1}:="ALU"
$as_BBL_AbrevGruposLectores{2}:="PRF"
$as_BBL_AbrevGruposLectores{3}:="APO"
$as_BBL_AbrevGruposLectores{4}:="XAL"
$as_BBL_AbrevGruposLectores{5}:="UEX"

ALL RECORDS:C47([xxBBL_Preferencias:65])
READ WRITE:C146([xxBBL_Preferencias:65])
FIRST RECORD:C50([xxBBL_Preferencias:65])

If (BLOB size:C605([xxBBL_Preferencias:65]Lector_GruposLectores:30)>0)
	BLOB_Blob2Vars (->[xxBBL_Preferencias:65]Lector_GruposLectores:30;0;-><>atBBL_GruposLectores;-><>asBBL_AbrevGruposLectores;-><>alBBL_GruposLectores;-><>vlBBL_GrupoLectorPorDefecto)
End if 

If (Size of array:C274(<>alBBL_GruposLectores)=0)
	COPY ARRAY:C226($at_BBL_GruposLectores;<>atBBL_GruposLectores)
	COPY ARRAY:C226($al_BBL_GruposLectores;<>alBBL_GruposLectores)
	COPY ARRAY:C226($as_BBL_AbrevGruposLectores;<>asBBL_AbrevGruposLectores)
	$b_guardar:=True:C214
	
Else 
	
	  // me aseguro que todos los grupos de lectores por omisión estén efectivamente definidos
	For ($i;1;Size of array:C274($al_BBL_GruposLectores))
		If (Find in array:C230(<>alBBL_GruposLectores;$al_BBL_GruposLectores{$i})<0)
			APPEND TO ARRAY:C911(<>atBBL_GruposLectores;$at_BBL_GruposLectores{$i})
			APPEND TO ARRAY:C911(<>asBBL_AbrevGruposLectores;$as_BBL_AbrevGruposLectores{$i})
			APPEND TO ARRAY:C911(<>alBBL_GruposLectores;$al_BBL_GruposLectores{$i})
			$b_guardar:=True:C214
		End if 
	End for 
	
	If ((<>vlBBL_GrupoLectorPorDefecto=0) | (Find in array:C230(<>alBBL_GruposLectores;<>vlBBL_GrupoLectorPorDefecto)=-1))
		<>vlBBL_GrupoLectorPorDefecto:=-5
		If (Find in array:C230(<>alBBL_GruposLectores;<>vlBBL_GrupoLectorPorDefecto)<0)
			APPEND TO ARRAY:C911(<>alBBL_GruposLectores;<>vlBBL_GrupoLectorPorDefecto)
			APPEND TO ARRAY:C911(<>atBBL_GruposLectores;__ ("Usuarios xxternos"))
			APPEND TO ARRAY:C911(<>asBBL_AbrevGruposLectores;"UEX")
		End if 
		$b_guardar:=True:C214
	End if 
End if 

If ($b_guardar)
	BBLcfg_GuardaCambiosGruposLect 
End if 