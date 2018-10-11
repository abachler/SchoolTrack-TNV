//%attributes = {}
  //KRL_DeleteSelection

If (False:C215)
	  //============================== IDENTIFICACION ==============================
	  // Procédure : mu_DeleteSelect
	  //Autor: Alberto Bachler
	  //Creada el 6/8/96 a 11:31 AM
	  //============================== DESCRIPCION ==============================
	  //Package:
	  //Descripción:
	  //Sintaxis:
	  //============================== MODIFICACIONES ==============================
	  //Fecha: 
	  //Autor:
	  //Descripción:
End if 


C_POINTER:C301($1)
C_LONGINT:C283($0)
C_BOOLEAN:C305($currentMode;$showMsg)
<>sy_LErr:=0
$result:=1

If (Records in selection:C76($1->)>0)
	$currentMode:=Read only state:C362($1->)
	$currentErr:=Method called on error:C704
	ON ERR CALL:C155("SYS_GncOnErr")
	READ WRITE:C146($1->)
	$deleted:=0
	
	
	  // ABK 20111115 Si la aplicación es 4D server no se despliega el mensaje evitando el inicio de los procesos de progreso.
	  // Se evita así el uso innecesario de recursos en el server y se mejoran los tiempos de ejecución
	Case of 
		: (Application type:C494=4D Server:K5:6)
			$showMsg:=False:C215
		: (Count parameters:C259=3)
			$msg2:=$3
			$showMsg:=True:C214
		: (Count parameters:C259=2)
			$showMsg:=$2
			$msg2:=__ ("Eliminando…")
		Else 
			$showMsg:=True:C214
	End case 
	
	
	$records:=Records in selection:C76($1->)
	
	$transLocal:=False:C215
	If (Not:C34(In transaction:C397))
		START TRANSACTION:C239  // inicio transacción
		$transLocal:=True:C214
	End if 
	
	
	  // ABK 20111115 
	  // se muestra el aviso de de progreso sólo cuando el número de registros a eliminar es superior a 1000
	  // esto debe mejorar el rendimiento en operaciones repetitivas. Puede ser necesario ajustar
	If (($showMsg) & ($records>1000))
		$Process:=IT_UThermometer (1;0;$msg2)
	End if 
	READ WRITE:C146($1->)
	DELETE SELECTION:C66($1->)
	If (Records in set:C195("Lockedset")#0)
		For ($i;1;4)
			USE SET:C118("Lockedset")
			DELETE SELECTION:C66($1->)
			If (Records in set:C195("Lockedset")=0)
				$i:=4
			Else 
				IT_WaitForTime (Current time:C178+10)
			End if 
		End for 
		If (Records in set:C195("Lockedset")>0)
			$result:=0
			CD_Dlog (0;__ ("Uno o más registros no pudieron ser eliminados (ocupados en otros procesos o por otros usuarios).\rIntente eliminarlos nuevamente más tarde."))
		End if 
	End if 
	If (($showMsg) & ($records>1000))  // ABK 20111115 
		IT_UThermometer (-2;$Process)
	End if 
	If ($currentMode)
		READ ONLY:C145($1->)
	Else 
		READ WRITE:C146($1->)
	End if 
	If (<>sy_lErr#0)
		$result:=0
	End if 
	<>sy_LErr:=0
	
	If (($result=1) & (<>sy_LErr=0))  // si la actualización de todos los registros se completó exitosamente
		If ($transLocal)
			VALIDATE TRANSACTION:C240  // valido la transacción
		End if 
	Else   // si el usuario cancelo la modificación o se produjo un error
		If ($transLocal)
			CANCEL TRANSACTION:C241  // cancelo la transacción
		End if 
	End if 
	<>sy_LErr:=0
	
	
	ON ERR CALL:C155($currentErr)
End if 


$0:=$result