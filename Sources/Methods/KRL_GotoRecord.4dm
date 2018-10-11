//%attributes = {}
  // KRL_GotoRecord()
  // Por: Alberto Bachler K.: 14-03-14, 12:51:13
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

  //REGISTRO DE MODIFICACIONES
  // 20080313 RCH. Se agrega un caso para testear si se solicitó la carga en READ WRITE y si el registro está Locked.
  // 20091225 ABK. Se agrega un parametro adicional: $4 Ountero sobre una variable de tipo longint en la que se retorna el record number del registro (utili para detectar corrupción de registros)
  // 20140314 ABK: se agrega un caso para volver a cargar el registro cuando estaba en memoria (es posible que el registro haya sido modificado en otro proceso)

C_POINTER:C301($1;$4;$recNumPointer)
C_LONGINT:C283($2)
C_BOOLEAN:C305($3;$readWriteMode)
$tablePointer:=$1
$recNum:=$2
$loadRecord:=False:C215
OK:=0
$0:=True:C214
$testIfLocked:=False:C215
$localRecNum:=0
$recNumPointer:=->$localRecNum
Case of 
	: (Count parameters:C259=3)
		$readWriteMode:=$3
	: (Count parameters:C259=4)
		$readWriteMode:=$3
		$recNumPointer:=$4  //agregado por ABK 20091225
End case 

error:=0  //20080803 agregado por ABK para inicializar la variable que retormna el código de error
$currentErr:=Method called on error:C704
ON ERR CALL:C155("ERR_GenericOnError")
If ($recNum>=0)
	Case of 
		: ($recNum#Record number:C243($tablePointer->))  //si el recNum del registro es distinto del registro en memoria se necesita cargar el registro de todas maneras
			$loadRecord:=True:C214
			If ($readWriteMode)
				$testIfLocked:=True:C214
				READ WRITE:C146($tablePointer->)
			End if 
			
		: (($readWriteMode) & (Read only state:C362($tablePointer->)))  //si la tabla está en sólo lectura y  se necesita cargar el registro en lectura-escritura
			$loadRecord:=True:C214
			$testIfLocked:=True:C214
			READ WRITE:C146($tablePointer->)
			
		: (($readWriteMode) & (Locked:C147($tablePointer->)))  //RCH en ciertos casos el registro puede estar locked y se necesita cargar en read-write
			$loadRecord:=True:C214
			$testIfLocked:=True:C214
			READ WRITE:C146($tablePointer->)
			
		: ((Not:C34($readWriteMode)) & (Read only state:C362($tablePointer->)) & (Not:C34(Locked:C147($tablePointer->))))  // el registro está en memoria pero puede haber sido modificado en otro proceso, lo volvemos a cargar
			READ ONLY:C145($tablePointer->)
			$testIfLocked:=False:C215
			$loadRecord:=True:C214
			$0:=True:C214
			
		Else   //el registro está en memoria pero volvemos a cargarlo (pudo haber sido modificado en otro proceso
			$loadRecord:=True:C214
			If ($readWriteMode)
				$testIfLocked:=True:C214
				READ WRITE:C146($tablePointer->)
			Else 
				$0:=True:C214
			End if 
	End case 
	
	If ($loadRecord)
		GOTO RECORD:C242($tablePointer->;$recNum)
		$recNumPointer->:=Record number:C243($tablePointer->)  //agregado por ABK 20091225
		If ($testIfLocked)
			$0:=Not:C34(Locked:C147($tablePointer->))
			If (Locked:C147($tablePointer->))
				LOCKED BY:C353($tablePointer->;$process;$user;$sessionUser;$processname)
			End if 
		End if 
		If (Record number:C243($tablePointer->)<0)
			$0:=False:C215
			REDUCE SELECTION:C351($tablePointer->;0)
		End if 
	End if 
Else 
	$0:=False:C215
	REDUCE SELECTION:C351($tablePointer->;0)
End if 
ON ERR CALL:C155($currentErr)

If ($0)
	OK:=1
Else 
	OK:=0
End if 