//%attributes = {}
  // BBLcfg_TiposDocumentoPorDefecto()
  // Por: Alberto Bachler: 21/11/13, 09:16:46
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($b_guardar)

ARRAY TEXT:C222(<>atBBL_Media;0)
_O_ARRAY STRING:C218(3;<>asBBL_AbrevMedia;0)
ARRAY LONGINT:C221(<>alBBL_IDMedia;0)
C_LONGINT:C283(<>vlBBL_MediaPorDefecto)

ALL RECORDS:C47([xxBBL_Preferencias:65])
READ WRITE:C146([xxBBL_Preferencias:65])
FIRST RECORD:C50([xxBBL_Preferencias:65])

If (BLOB size:C605([xxBBL_Preferencias:65]Items_TipoDocumentos:31)>0)
	BLOB_Blob2Vars (->[xxBBL_Preferencias:65]Items_TipoDocumentos:31;0;-><>atBBL_Media;-><>asBBL_AbrevMedia;-><>alBBL_IDMedia;-><>vlBBL_MediaPorDefecto)
End if 

If (Size of array:C274(<>alBBL_IDMedia)=0)
	  //tipos de documento (media) por defecto
	ARRAY TEXT:C222(<>atBBL_Media;14)
	_O_ARRAY STRING:C218(3;<>asBBL_AbrevMedia;14)
	ARRAY LONGINT:C221(<>alBBL_IDMedia;14)
	<>atBBL_Media{1}:=__ ("Archivo Computacional")
	<>atBBL_Media{2}:=__ ("Casete")
	<>atBBL_Media{3}:=__ ("CD_Rom")
	<>atBBL_Media{4}:=__ ("CD_Audio")
	<>atBBL_Media{5}:=__ ("Gráfico")
	<>atBBL_Media{6}:=__ ("Impresos")
	<>atBBL_Media{7}:=__ ("Libro")
	<>atBBL_Media{8}:=__ ("Mapa")
	<>atBBL_Media{9}:=__ ("Programa Computacional")
	<>atBBL_Media{10}:=__ ("Registro Audio")
	<>atBBL_Media{11}:=__ ("Registro Audiovisual")
	<>atBBL_Media{12}:=__ ("Video")
	<>atBBL_Media{13}:=__ ("Disco Video Digital")
	<>atBBL_Media{14}:=__ ("Compact Disc")
	
	<>asBBL_AbrevMedia{1}:=__ ("ARC")
	<>asBBL_AbrevMedia{2}:=__ ("CAS")
	<>asBBL_AbrevMedia{3}:=__ ("CDR")
	<>asBBL_AbrevMedia{4}:=__ ("CDA")
	<>asBBL_AbrevMedia{5}:=__ ("GRF")
	<>asBBL_AbrevMedia{6}:=__ ("MP")
	<>asBBL_AbrevMedia{7}:=__ ("LIB")
	<>asBBL_AbrevMedia{8}:=__ ("MAP")
	<>asBBL_AbrevMedia{9}:=__ ("PRG")
	<>asBBL_AbrevMedia{10}:=__ ("RAU")
	<>asBBL_AbrevMedia{11}:=__ ("RAV")
	<>asBBL_AbrevMedia{12}:=__ ("VID")
	<>asBBL_AbrevMedia{13}:=__ ("DVD")
	<>asBBL_AbrevMedia{14}:=__ ("CD#")
	
	<>alBBL_IDMedia{1}:=-7
	<>alBBL_IDMedia{2}:=-6
	<>alBBL_IDMedia{3}:=-5
	<>alBBL_IDMedia{4}:=-4
	<>alBBL_IDMedia{5}:=-10
	<>alBBL_IDMedia{6}:=-2
	<>alBBL_IDMedia{7}:=-1
	<>alBBL_IDMedia{8}:=-9
	<>alBBL_IDMedia{9}:=-8
	<>alBBL_IDMedia{10}:=-11
	<>alBBL_IDMedia{11}:=-12
	<>alBBL_IDMedia{12}:=-3
	<>alBBL_IDMedia{13}:=-13
	<>alBBL_IDMedia{14}:=-14
	
	<>vlBBL_MediaPorDefecto:=-1
	$b_guardar:=True:C214
	
Else 
	If ((<>vlBBL_MediaPorDefecto=0) | (Find in array:C230(<>alBBL_IDMedia;<>vlBBL_MediaPorDefecto)=-1))
		<>vlBBL_MediaPorDefecto:=-1
		If (Find in array:C230(<>alBBL_IDMedia;<>vlBBL_MediaPorDefecto)<0)
			APPEND TO ARRAY:C911(<>alBBL_IDMedia;-1)
			APPEND TO ARRAY:C911(<>atBBL_Media;__ ("Libro"))
			APPEND TO ARRAY:C911(<>asBBL_AbrevMedia;"LIB")
			$b_guardar:=True:C214
		End if 
	End if 
End if 

If ($b_guardar)
	BBLcfg_GuardaCambiosMedia 
End if 