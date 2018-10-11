//%attributes = {}
  //MXLEG_ConoVtaXML 
  //Genera un txt con el cono de ventas de cada grado y lo guarda en la carpeta STMXCV para cuando sea requerido por el grupo integer a través de un webservice

C_TEXT:C284($vt_ciclo;$vt_date)

If (Count parameters:C259=1)
	$vt_date:=$1
Else 
	$vt_date:=Substring:C12(String:C10(Current date:C33(*);8);1;10)
End if 

$vl_aai:=Year of:C25(PERIODOS_InicioAñoSTrack )
$vl_aaf:=Year of:C25(PERIODOS_FinAñoPeriodosSTrack )

If ($vl_aai#$vl_aaf)
	$vt_ciclo:=String:C10($vl_aaf)+"-"+String:C10($vl_aaf+1)
Else 
	$vt_ciclo:=String:C10($vl_aaf)
End if 

C_BOOLEAN:C305($vb_ejecutadoenserver)
$vb_ejecutadoenserver:=False:C215




If (Application type:C494=4D Remote mode:K5:5)
	$proc:=Execute on server:C373("MXLEG_ConoVtaXML";Pila_256K;"Cono_en_Server";$vt_date)
	$vb_ejecutadoenserver:=True:C214
Else 
	
	
	C_LONGINT:C283($i;$fia)
	CD_THERMOMETREXSEC (1;0;__ ("Generando Cono de Ventas"))
	
	For ($i;1;Size of array:C274(<>al_NumeroNivelesActivos))
		$fia:=Find in array:C230(<>aNivNo;<>al_NumeroNivelesActivos{$i})
		$vt_FileName:=$vt_date+"-"+$vt_ciclo+"-G"+String:C10($fia)+".txt"
		
		$ref:=ACTabc_CreaDocumento ("STMXCV";$vt_FileName)
		If (ok=1)
			IO_SendPacket ($ref;"0"+"\r")
			IO_SendPacket ($ref;<>gRolBd+"\r")
			IO_SendPacket ($ref;"G"+String:C10($fia)+"\r")
			IO_SendPacket ($ref;$vt_date+"\r")
			IO_SendPacket ($ref;$vt_ciclo+"\r")
			
			ARRAY INTEGER:C220($ai_valCV;0)
			SRz_ConodeVentasxNivel (<>al_NumeroNivelesActivos{$i};$vt_ciclo;->$ai_valCV)
			
			For ($x;1;Size of array:C274($ai_valCV))
				IO_SendPacket ($ref;String:C10($ai_valCV{$x})+"\r")
			End for 
			
			CD_THERMOMETREXSEC (0;($i/Size of array:C274(<>al_NumeroNivelesActivos))*100)
			
			CLOSE DOCUMENT:C267($ref)
			
		End if 
		
		EM_ErrorManager ("Clear")
		
	End for 
	
	CD_THERMOMETREXSEC (-1)
End if 


