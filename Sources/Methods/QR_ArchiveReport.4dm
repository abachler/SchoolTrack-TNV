//%attributes = {}
  //QR_ArchiveReport

If (False:C215)
	  // Procédure : dfn SaveModels
	  // Created by: Alberto Bächler
	  // Date creation: Junio de 23, 1994
	  // Date modifi: Junio de 23, 1994
	  //____________________
	  // Comments:
	  // Save file Modelos
End if 


GET LIST ITEM:C378(hl_informes;Selected list items:C379(hl_informes);$recNum;$CurrentReportName)
KRL_GotoRecord (->[xShell_Reports:54];$recNum)
  // MOD Ticket N° 209698 PA 20180615
C_LONGINT:C283($tableNumber;$l_op)
C_TEXT:C284($path;$t_error;$t_fileName)
ARRAY TEXT:C222($at_expresiones;0)
APPEND TO ARRAY:C911($at_expresiones;"0000_")
APPEND TO ARRAY:C911($at_expresiones;"_0000")
$t_error:=""

  //ticket 149583  JVP 08-09-15
  //se agrega validacion del modulo del reporte, debido a que si no lo tiene asignado
  //se valida para que se agrege al reporte asi en la restauracion no abra mensajes
  //erroneos en base al modulo donde se restaura
  //esto solo se hara en caso de que el modulo del reporte
  //no esta asignado correctamente
If ([xShell_Reports:54]Modulo:41="")
	  //cargo el registro nuevamente
	GOTO RECORD:C242([xShell_Reports:54];$recNum)
	  //cargo modalidad de escritura
	READ WRITE:C146([xShell_Reports:54])
	  //desbloqueo el registro
	LOAD RECORD:C52([xShell_Reports:54])
	[xShell_Reports:54]Modulo:41:=vsBWR_CurrentModule
	SAVE RECORD:C53([xShell_Reports:54])
	  //restauro estado de sistema a Read Write
	KRL_UnloadReadOnly (->[xShell_Reports:54])
	  //cargo nuevamente el registro
	KRL_GotoRecord (->[xShell_Reports:54];$recNum)
End if 




  // MOD Ticket N° 209698 PA 20180615
If (([xShell_Reports:54]ReportType:2="gSR2") & (Not:C34(Is compiled mode:C492)))
	$t_error:=0xDev_BuscaScriptEnInformeSR ("BuscaTextoEnInforme";->$at_expresiones;True:C214)
End if 

If ($t_error#"")
	SET TEXT TO PASTEBOARD:C523($t_error)
	$l_op:=CD_Dlog (0;__ ("El informe posee métodos de desarrollo. Se ha copiado el detalle de estos al portapapeles.\rDesea archivar el modelo de todas maneras?");"";"Si";"No")
	If ($l_op=1)
		$t_error:=""
	End if 
End if 
If ($t_error="")
	$path:=SYS_SelectFolder ("Seleccione la carpeta para guardar el informe...")
	If ($path#"")
		$tableNumber:=Table:C252(->[xShell_Reports:54])
		  //MONO
		$t_fileName:=[xShell_Reports:54]ReportName:26
		$t_fileName:=Replace string:C233($t_fileName;"/";"_")  //Antes "/";"|" la barra vertical o Pipe da problema en windows
		$t_fileName:=Replace string:C233($t_fileName;"(";"[")
		$t_fileName:=Replace string:C233($t_fileName;")";"]")
		$t_fileName:=Replace string:C233($t_fileName;"~";"_")
		$t_fileName:=Replace string:C233($t_fileName;"#";"_")
		$t_fileName:=Replace string:C233($t_fileName;"&";"_")
		$t_fileName:=Replace string:C233($t_fileName;"*";"_")
		$t_fileName:=Replace string:C233($t_fileName;"{";"[")
		$t_fileName:=Replace string:C233($t_fileName;"}";"]")
		$t_fileName:=Replace string:C233($t_fileName;"\\";"_")
		$t_fileName:=Replace string:C233($t_fileName;":";"_")
		$t_fileName:=Replace string:C233($t_fileName;"<";"[")
		$t_fileName:=Replace string:C233($t_fileName;">";"]")
		$t_fileName:=Replace string:C233($t_fileName;"?";"_")
		$t_fileName:=Replace string:C233($t_fileName;"|";"_")
		$t_fileName:=Replace string:C233($t_fileName;"\"";"")
		
		If (SYS_IsMacintosh )
			$t_fileName:=$path+Substring:C12($t_fileName;1;27)+".txt"
		Else 
			$t_fileName:=$path+$t_fileName
		End if 
		
		SET CHANNEL:C77(12;$t_fileName)
		SEND VARIABLE:C80($tableNumber)
		SEND RECORD:C78([xShell_Reports:54])
		SET CHANNEL:C77(11)
	End if 
End if 