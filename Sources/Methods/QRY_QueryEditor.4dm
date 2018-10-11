//%attributes = {}
  // QRY_QueryEditor()
  // Por: Alberto Bachler: 08/03/13, 18:15:42
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_POINTER:C301($1)
C_BLOB:C604($2)

C_POINTER:C301($y_Nil)
C_TEXT:C284($t_NombreTabla)


If (False:C215)
	C_POINTER:C301(QRY_QueryEditor ;$1)
	C_BLOB:C604(QRY_QueryEditor ;$2)
End if 

C_BLOB:C604(vx_QueryBlob)

QRY_Init 

SET BLOB SIZE:C606(vx_QueryBlob;0)



Case of 
	: (Count parameters:C259=0)
		USR_RegisterUserEvent (UE_QueryEditor;vlBWR_SelectedTableRef)
		vyQRY_TablePointer:=Table:C252(vlBWR_SelectedTableRef)
		REDUCE SELECTION:C351([xShell_Queries:53];0)
		
	: (Count parameters:C259=1)
		vyQRY_TablePointer:=$1
		
		
	: (Count parameters:C259=2)
		vyQRY_TablePointer:=$1
		vx_QueryBlob:=$2
End case 

$t_nombreTabla:=XSvs_nombreTablaLocal_puntero (vyQRY_TablePointer)

CREATE EMPTY SET:C140(vyQRY_TablePointer->;"SearchResult")
READ ONLY:C145(vyQRY_TablePointer->)

WDW_OpenFormWindow ($y_Nil;"Qry_Editor";10;8;__ ("Búsqueda de ")+$t_NombreTabla;"WDW_CloseDlog")
bload:=1

If (BLOB size:C605(vx_QueryBlob)>0)
	REDUCE SELECTION:C351([xShell_Queries:53];0)
End if 


While (bLoad=1)
	DIALOG:C40("Qry_Editor")
End while 
CLOSE WINDOW:C154




