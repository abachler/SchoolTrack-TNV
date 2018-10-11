//%attributes = {}
  //ACTdteEmi_Generales
C_TEXT:C284($t_accion;$t_retorno;$0;$1)
C_POINTER:C301($vy_pointer1;$vy_pointer2;$vy_pointer3;$vy_pointer4;$vy_pointer5;$vy_pointer6)

$t_accion:=$1
If (Count parameters:C259>=2)
	$vy_pointer1:=$2
End if 
If (Count parameters:C259>=3)
	$vy_pointer2:=$3
End if 
If (Count parameters:C259>=4)
	$vy_pointer3:=$4
End if 
If (Count parameters:C259>=5)
	$vy_pointer4:=$5
End if 
If (Count parameters:C259>=6)
	$vy_pointer5:=$6
End if 
If (Count parameters:C259>=7)
	$vy_pointer6:=$7
End if 

Case of 
	: ($t_accion="InicializaOpcionesBusqueda")
		  //inicializa opciones de busqueda...
		atACTdteEmi_Periodo:=1
		vrACT_folio:=0
		vdACT_fechaEmision:=!00-00-00!
		vdACT_fechaEmisionH:=!00-00-00!
		
	: ($t_accion="ObtieneRUTADocumentos")
		C_TEXT:C284($vt_tipo;$folderPath;$t_carpeta;$t_rutEmisor;$t_tipoGen;$t_tipoArchivo)
		C_REAL:C285($r_folio)
		C_BOOLEAN:C305($b_cedible)
		  //$t_tipoArchivo:=$vy_pointer2->
		  //$r_folio:=$vy_pointer3->
		
		$t_rutEmisor:=$vy_pointer1->
		$t_tipoGen:=$vy_pointer2->
		$b_cedible:=$vy_pointer3->
		$d_fechaEmision:=$vy_pointer4->
		$t_tipoArchivo:=$vy_pointer5->
		$r_folio:=$vy_pointer6->
		
		
		$vt_tipo:=$t_rutEmisor+Folder separator:K24:12+"Emitidos"+Folder separator:K24:12
		$vt_tipo:=$vt_tipo+$t_tipoGen+Folder separator:K24:12
		$vt_tipo:=$vt_tipo+Choose:C955($b_cedible;"Cedible"+Folder separator:K24:12;"")
		$vt_tipo:=$vt_tipo+String:C10(Year of:C25($d_fechaEmision))+Folder separator:K24:12
		$vt_tipo:=$vt_tipo+String:C10(Month of:C24($d_fechaEmision);"00")
		
		
		$t_carpeta:=ACTabc_CreaRutaCarpetas ("DTE"+Folder separator:K24:12)
		
		$t_tipoArchivo:=Substring:C12($t_tipoArchivo;1;Position:C15(":";$t_tipoArchivo)-1)
		
		$vt_fileName:=$t_tipoArchivo+"_"+String:C10($r_folio)+"."+$t_tipoGen
		
		  //$vt_fileName:=$t_carpeta+$vt_fileName
		$vt_fileName:=$t_carpeta+$vt_tipo+Folder separator:K24:12+$vt_fileName  //20170530 RCH
		
		$t_retorno:=$vt_fileName
		
End case 

$0:=$t_retorno