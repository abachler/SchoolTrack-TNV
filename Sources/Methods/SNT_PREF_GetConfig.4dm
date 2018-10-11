//%attributes = {}
  //SNT_PREF_GetConfig

  // ABK - 09/01/2011: 
  // Este método se mantiene sólo para la migración a SN3
  // Debe eliminarse una vez que se haya completado la migración de todos los colegios
  // ----


C_LONGINT:C283($1;$vl_User)
C_TEXT:C284($2;$vt_Reference;$vt_QuickReference)
C_BLOB:C604($3;$vx_Blob;$vx_BlobReturn)
C_POINTER:C301($4)  //Blob de Respuesta
C_POINTER:C301($5)  //QuickReference Result
C_LONGINT:C283($0;$vl_Error;$vl_Compressed;$vl_ExpandedSized;$vl_CurrentSize)
$vl_User:=$1
$vt_Reference:=$2
$vx_Blob:=$3

READ ONLY:C145([SNT_Preferences:50])  //Colocar en lectura
  // //Busqueda compuesta de registros 
QUERY:C277([SNT_Preferences:50];[SNT_Preferences:50]ID_User:1=$vl_User;*)
QUERY:C277([SNT_Preferences:50]; & ;[SNT_Preferences:50]ID_Reference:2=$vt_Reference)
  // //Busqueda compuesta de registros  End
If (Records in selection:C76([SNT_Preferences:50])=0)  //Si No encuentra
	CREATE RECORD:C68([SNT_Preferences:50])
	[SNT_Preferences:50]ID_User:1:=$vl_User
	[SNT_Preferences:50]ID_Reference:2:=$vt_Reference
	[SNT_Preferences:50]xData:3:=$vx_Blob
	[SNT_Preferences:50]DTS_Modificacion:5:=DTS_MakeFromDateTime 
	SAVE RECORD:C53([SNT_Preferences:50])
	UNLOAD RECORD:C212([SNT_Preferences:50])
	$vl_Error:=0
Else   //Si encuentra
	If (BLOB size:C605([SNT_Preferences:50]xData:3)>=0)  //Si el Blob es mayor a cero
		$vx_Blob:=[SNT_Preferences:50]xData:3
		$vt_QuickReference:=[SNT_Preferences:50]QuickReference:6
		$vl_Error:=0
	Else   //Si el Blob es inferior a 1
		$vl_Error:=1
	End if 
End if 

  // //Entrega del Blob de Resultado con autoexpasion

BLOB_ExpandBlob_byPointer (->$vx_Blob)
$4->:=$vx_Blob
$5->:=$vt_QuickReference