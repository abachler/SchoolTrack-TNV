//%attributes = {}
  // UD_v20131122_GruposLectores()
  // Por: Alberto Bachler: 22/11/13, 14:39:56
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------



ARRAY TEXT:C222(<>atBBL_GruposLectores;0)
ARRAY LONGINT:C221(<>alBBL_GruposLectores;0)
_O_ARRAY STRING:C218(3;<>asBBL_AbrevGruposLectores;0)

READ ONLY:C145([xxBBL_Preferencias:65])
ALL RECORDS:C47([xxBBL_Preferencias:65])
FIRST RECORD:C50([xxBBL_Preferencias:65])

  //lectura de los prefijos para Media establecidos en la base  de datos
BBLcfg_GruposLectoresPorDefecto 
BLOB_Blob2Vars (->[xxBBL_Preferencias:65]Lector_GruposLectores:30;0;-><>atBBL_GruposLectores;-><>asBBL_AbrevGruposLectores;-><>alBBL_GruposLectores;-><>vlBBL_GrupoLectorPorDefecto)
SORT ARRAY:C229(<>atBBL_GruposLectores;<>alBBL_GruposLectores;<>asBBL_AbrevGruposLectores;>)

$l_posicionLectoresSistema:=Find in array:C230(<>alBBL_GruposLectores;-6)
If ($l_posicionLectoresSistema>0)
	AT_Delete ($l_posicionLectoresSistema;1;-><>atBBL_GruposLectores;-><>alBBL_GruposLectores;-><>asBBL_AbrevGruposLectores)
End if 

READ WRITE:C146([BBL_Lectores:72])
QUERY:C277([BBL_Lectores:72];[BBL_Lectores:72]ID:1<0)
APPLY TO SELECTION:C70([BBL_Lectores:72];[BBL_Lectores:72]ID_GrupoLectores:37:=0)
KRL_UnloadReadOnly (->[BBL_Lectores:72])

