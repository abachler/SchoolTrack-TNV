//%attributes = {}
  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda
  // Fecha y hora: 26-03-18, 11:00:47
  // ----------------------------------------------------
  // Método: ST_EjecutaProcesoServidor
  // Descripción
  // $1 Metodo a ejecutar en el servidor
  // $2 Nombre del proceso a crear
  // $0 en paso cero devuelve el numero del proceso
  // Parámetros
  // ----------------------------------------------------


C_DATE:C307($d_fechaSesion)
C_LONGINT:C283($processID)
C_TEXT:C284($t_dts;$t_metodo;$t_nombreProceso)


$t_metodo:=$1  //Metodo a ejecutar en el servidor
$t_nombreProceso:=$2  //Nombre del proceso

Case of 
	: ($t_metodo="dbu_CreaSesiones")
		$processID:=Process number:C372($t_nombreProceso)
		If ($processID=0)
			$t_dts:=DTS_MakeFromDateTime 
			$d_fechaSesion:=DTS_GetDate (PREF_fGet (0;"CreacionDeSesiones";$t_dts))
			If ($d_fechaSesion#Current date:C33(*))
				$processID:=Execute on server:C373("dbu_CreaSesiones";Pila_256K;$t_nombreProceso;*)
			End if 
		End if 
		$0:=$processID
End case 

