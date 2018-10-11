//%attributes = {}
  //SQ_RetornaNuevoID

C_POINTER:C301($vyFieldPointer;$1)
C_BOOLEAN:C305($vbSecuenciaNegativa;$2)
C_TEXT:C284($vtTableFieldRef)
C_REAL:C285($vrSequenceNumber;$0)


$vyFieldPointer:=$1
If (Count parameters:C259=2)
	$vbSecuenciaNegativa:=$2
End if 
$vtTableFieldRef:=String:C10(Table:C252($vyFieldPointer))+"."+String:C10(Field:C253($vyFieldPointer))


While (Semaphore:C143("Secuenciador"))
	DELAY PROCESS:C323(Current process:C322;10)
End while 

If (Application type:C494=4D Remote mode:K5:5)
	
	  //solo se necesita comunicación cliente servidor cuando la aplicación es un cliente
	ARRAY TEXT:C222($atSQ_TableFieldRef;0)
	ARRAY LONGINT:C221($alSQ_TableNumber;0)
	ARRAY LONGINT:C221($alSQ_FieldNumber;0)
	ARRAY REAL:C219($alSQ_PositiveSequence;0)
	ARRAY REAL:C219($alSQ_NegativeSequence;0)
	
	GET PROCESS VARIABLE:C371(-1;<>atSQ_TableFieldRef;$atSQ_TableFieldRef)
	$el:=Find in array:C230($atSQ_TableFieldRef;$vtTableFieldRef)
	If ($el<0)
		$p:=New process:C317("SQ_CreaRegistro";32000;"Creación registro SQ";$vyFieldPointer)  //creo el registro inexistente en otro proceso para no crearlo dentro de la transacción si este metodo es llamado en ese contexto
		GET PROCESS VARIABLE:C371(-1;<>alSQ_TableNumber;$alSQ_TableNumber;<>alSQ_FieldNumber;$alSQ_FieldNumber;<>alSQ_PositiveSequence;$alSQ_PositiveSequence;<>alSQ_NegativeSequence;$alSQ_NegativeSequence)
		APPEND TO ARRAY:C911($atSQ_TableFieldRef;$vtTableFieldRef)
		APPEND TO ARRAY:C911($alSQ_TableNumber;Num:C11(ST_GetWord ($vtTableFieldRef;1;".")))
		APPEND TO ARRAY:C911($alSQ_FieldNumber;Num:C11(ST_GetWord ($vtTableFieldRef;2;".")))
		APPEND TO ARRAY:C911($alSQ_PositiveSequence;0)
		APPEND TO ARRAY:C911($alSQ_NegativeSequence;0)
		$el:=Size of array:C274($atSQ_TableFieldRef)
		If (Not:C34($vbSecuenciaNegativa))
			$alSQ_PositiveSequence{$el}:=$alSQ_PositiveSequence{$el}+1
			$vrSequenceNumber:=$alSQ_PositiveSequence{$el}
		Else 
			$alSQ_NegativeSequence{$el}:=$alSQ_NegativeSequence{$el}-1
			$vrSequenceNumber:=$alSQ_NegativeSequence{$el}
		End if 
		VARIABLE TO VARIABLE:C635(-1;<>atSQ_TableFieldRef;$atSQ_TableFieldRef;<>alSQ_TableNumber;$alSQ_TableNumber;<>alSQ_FieldNumber;$alSQ_FieldNumber;<>alSQ_PositiveSequence;$alSQ_PositiveSequence;<>alSQ_NegativeSequence;$alSQ_NegativeSequence)
	Else 
		If (Not:C34($vbSecuenciaNegativa))
			GET PROCESS VARIABLE:C371(-1;<>alSQ_PositiveSequence{$el};$vrSequenceNumber)
			$vrSequenceNumber:=$vrSequenceNumber+1
			SET PROCESS VARIABLE:C370(-1;<>alSQ_PositiveSequence{$el};$vrSequenceNumber)
		Else 
			GET PROCESS VARIABLE:C371(-1;<>alSQ_NegativeSequence{$el};$vrSequenceNumber)
			$vrSequenceNumber:=$vrSequenceNumber-1
			SET PROCESS VARIABLE:C370(-1;<>alSQ_NegativeSequence{$el};$vrSequenceNumber)
		End if 
	End if 
	
	
Else 
	
	
	  //si la aplicación es 4D server, engine , 4D Desktop o Runtime operamos directamente sobre los arreglos cargados al iniciar la sesión
	$el:=Find in array:C230(<>atSQ_TableFieldRef;$vtTableFieldRef)
	If ($el<0)
		$p:=New process:C317("SQ_CreaRegistro";32000;"Creación registro SQ";$vyFieldPointer)  //creo el registro inexistente en otro proceso para no crearlo dentro de la transacción si este metodo es llamado en ese contexto
		APPEND TO ARRAY:C911(<>atSQ_TableFieldRef;$vtTableFieldRef)
		APPEND TO ARRAY:C911(<>alSQ_TableNumber;Num:C11(ST_GetWord ($vtTableFieldRef;1;".")))
		APPEND TO ARRAY:C911(<>alSQ_FieldNumber;Num:C11(ST_GetWord ($vtTableFieldRef;2;".")))
		APPEND TO ARRAY:C911(<>alSQ_PositiveSequence;0)
		APPEND TO ARRAY:C911(<>alSQ_NegativeSequence;0)
		$el:=Size of array:C274(<>atSQ_TableFieldRef)
		If (Not:C34($vbSecuenciaNegativa))
			<>alSQ_PositiveSequence{$el}:=<>alSQ_PositiveSequence{$el}+1
			$vrSequenceNumber:=<>alSQ_PositiveSequence{$el}
		Else 
			<>alSQ_NegativeSequence{$el}:=<>alSQ_NegativeSequence{$el}-1
			$vrSequenceNumber:=<>alSQ_NegativeSequence{$el}
		End if 
	Else 
		If (Not:C34($vbSecuenciaNegativa))
			<>alSQ_PositiveSequence{$el}:=<>alSQ_PositiveSequence{$el}+1
			$vrSequenceNumber:=<>alSQ_PositiveSequence{$el}
		Else 
			<>alSQ_NegativeSequence{$el}:=<>alSQ_NegativeSequence{$el}-1
			$vrSequenceNumber:=<>alSQ_NegativeSequence{$el}
		End if 
	End if 
End if 


$0:=$vrSequenceNumber
CLEAR SEMAPHORE:C144("Secuenciador")

