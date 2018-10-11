//%attributes = {}
  //KRL_IsRecordLocked

C_BOOLEAN:C305($0)
C_POINTER:C301($1)
$0:=False:C215

READ WRITE:C146($1->)
LOAD RECORD:C52($1->)
If (Locked:C147($1->))
	LOCKED BY:C353($1->;$procID;$user;$station;$procName)
	$0:=True:C214
	$Record:=Table name:C256($1)+" "+String:C10(Record number:C243($1->))
	If ($procName="Batch Tasks Processor")
		For ($i;1;6)
			LOAD RECORD:C52($1->)
			If (Not:C34(Locked:C147($1->)))
				$i:=9
				OK:=0
			Else 
				DELAY PROCESS:C323(Current process:C322;15)
			End if 
		End for 
	End if 
	READ WRITE:C146($1->)
	LOAD RECORD:C52($1->)
	
	If (Locked:C147($1->))
		OK:=1
		If ($user="")
			ok:=CD_Dlog (2;__ ("Registro en uso por el proceso: ")+$procName+__ ("\r\r¿Desea esperar que se liberen o reintentar más tarde?");__ ("");__ ("Esperar");__ ("Omitir"))
		Else 
			ok:=CD_Dlog (2;__ ("Registro en uso: ")+$record+__ ("\rUsuario: ")+$user+__ ("\rComputador: ")+$station+__ ("\rProceso: ")+$procName+__ ("\r\r¿Desea esperar que se liberen o reintentar más tarde?");__ ("");__ ("Esperar");__ ("Cancelar"))
		End if 
	Else 
		$0:=False:C215
		OK:=0
	End if 
	
	If (OK=1)
		<>stopExec:=False:C215
		$Process:=IT_UThermometer (1;0;__ ("Esperando que se liberen los registros.\rPresione la tecla Escape para interrumpir."))
		While ((Locked:C147($1->)) & (<>stopExec=False:C215))
			LOAD RECORD:C52($1->)
			DELAY PROCESS:C323(Current process:C322;15)
		End while 
		If (<>stopExec)
			$0:=True:C214
		Else 
			$0:=False:C215
		End if 
		IT_UThermometer (-2;$Process)
	Else 
		$0:=True:C214
	End if 
End if 