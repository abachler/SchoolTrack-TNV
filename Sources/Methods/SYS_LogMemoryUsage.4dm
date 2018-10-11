//%attributes = {"executedOnServer":true}
  // SYS_LogMemoryUsage()
  // Por: Alberto Bachler K.: 30-09-15, 18:29:59
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BOOLEAN:C305(<>b_logMemoryUsage)
C_LONGINT:C283($i;$l_delay;$l_idProceso;$l_LogMemoryUsage;$l_proceso;$l_procesosUsuario;$l_processState;$l_tareas;$l_usuariosConectados)
C_TIME:C306($h_refDocumento)
C_TEXT:C284($t_encabezado;$t_linea;$t_LogMemoryUsage;$t_refElemento;$t_rutaElemento;$t_rutaLog;$t_XMLrefPropiedades)

ARRAY REAL:C219($ar_InfoValor;0)
ARRAY REAL:C219($ar_numeroObjeto;0)
ARRAY TEXT:C222($at_nombresValor;0)

$t_XMLrefPropiedades:=SYS_ParseXMLDatabaseSettings 


  // datos Schooltrack
$t_rutaElemento:="preferences/schooltrack/logMemory_active"
$t_refElemento:=DOM Find XML element:C864($t_XMLrefPropiedades;$t_rutaElemento)
If (OK=1)
	DOM GET XML ELEMENT VALUE:C731($t_refElemento;$l_LogMemoryUsage)
End if 
$t_rutaElemento:="preferences/schooltrack/logMemory_Delay"
$t_refElemento:=DOM Find XML element:C864($t_XMLrefPropiedades;$t_rutaElemento)
If (OK=1)
	DOM GET XML ELEMENT VALUE:C731($t_refElemento;$l_delay)
End if 
DOM CLOSE XML:C722($t_XMLrefPropiedades)

If ($l_delay=0)
	$l_delay:=3*60*60
End if 

If (Count parameters:C259=1)
	$l_delay:=$1
End if 

If ($l_delay>0)
	$l_LogMemoryUsage:=1
End if 

$l_idProceso:=Process number:C372("Log uso de memoria")
$l_processState:=Process state:C330($l_idProceso)
If ($l_LogMemoryUsage=1)
	Case of 
		: (($l_idProceso=0) | ($l_processState<Executing:K13:4))
			$l_proceso:=New process:C317(Current method name:C684;128000;"Log uso de memoria";$l_delay)
			
		: ($l_processState>Executing:K13:4)
			RESUME PROCESS:C320($l_idProceso)
			
		Else 
			<>b_logMemoryUsage:=True:C214
			GET MEMORY STATISTICS:C1118(3;$at_nombresValor;$ar_InfoValor;$ar_numeroObjeto)
			$t_rutaLog:=Get 4D folder:C485(Logs folder:K5:19)+"UsoDeMemoria.txt"
			If (Test path name:C476($t_rutaLog)#Is a document:K24:1)
				$h_refDocumento:=Create document:C266($t_rutaLog;".txt")
				$t_encabezado:="Fecha\tHora\tClientes\tProcesos usuario\tTotal procesos\t"
				For ($i;1;Size of array:C274($at_nombresValor))
					$t_encabezado:=$t_encabezado+$at_nombresValor{$i}+"\t"
				End for 
				$t_encabezado:=Substring:C12($t_encabezado;1;Length:C16($t_encabezado)-1)+"\r"
				SEND PACKET:C103($h_refDocumento;$t_encabezado)
				CLOSE DOCUMENT:C267($h_refDocumento)
			End if 
			
			
			While ((Not:C34(<>stopDaemons)) & (<>b_logMemoryUsage))
				If ((Not:C34(<>b_logMemoryUsage)) & ($h_refDocumento#?00:00:00?))
					CLOSE DOCUMENT:C267($h_refDocumento)
				Else 
					GET MEMORY STATISTICS:C1118(3;$at_nombresValor;$ar_InfoValor;$ar_numeroObjeto)
					$l_usuariosConectados:=Count users:C342
					$l_procesosUsuario:=Count user processes:C343
					$l_tareas:=Count tasks:C335
					$t_linea:=String:C10(Current date:C33;Internal date short special:K1:4)+"\t"+String:C10(Current time:C178;HH MM SS:K7:1)+"\t"+String:C10($l_usuariosConectados)+"\t"+String:C10($l_procesosUsuario)+"\t"+String:C10($l_tareas)+"\t"
					For ($i;1;Size of array:C274($at_nombresValor))
						If ($at_nombresValor{$i}#"nb@")
							$t_linea:=$t_linea+String:C10(Round:C94($ar_InfoValor{$i}/1024/1024;2))+"\t"
						Else 
							$t_linea:=$t_linea+String:C10($ar_InfoValor{$i})+"\t"
						End if 
					End for 
					$t_linea:=Substring:C12($t_linea;1;Length:C16($t_linea)-1)+"\r"
					$h_refDocumento:=Append document:C265($t_rutaLog;".txt")
					SEND PACKET:C103($h_refDocumento;$t_linea)
					CLOSE DOCUMENT:C267($h_refDocumento)
					DELAY PROCESS:C323(Current process:C322;$l_delay)
				End if 
			End while 
	End case 
	
Else 
	$l_idProceso:=Process number:C372("Log uso de memoria")
	If ($l_idProceso>0)
		<>b_logMemoryUsage:=False:C215
		RESUME PROCESS:C320($l_idProceso)
		  //SET PROCESS VARIABLE($l_idProceso;<>b_logMemoryUsage;<>b_logMemoryUsage)
		  //RESUME PROCESS($l_idProceso)
	End if 
End if 


