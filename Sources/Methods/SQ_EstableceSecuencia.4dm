//%attributes = {}
  //SQ_EstableceSecuencia

C_POINTER:C301($vyFieldPointer;$1)
C_TEXT:C284($vtTableFieldRef)
C_REAL:C285($vrSequenceNumber;$2)
C_BOOLEAN:C305($vbNegativeSequence;$3)


$vyFieldPointer:=$1
$vrSequenceNumber:=$2
If (Count parameters:C259=3)
	$vbNegativeSequence:=$3
End if 
Case of 
	: (($vbNegativeSequence) & ($vrSequenceNumber>0))
		$vrSequenceNumber:=0
	: ((Not:C34($vbNegativeSequence)) & ($vrSequenceNumber<0))
		$vrSequenceNumber:=0
End case 
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
		Case of 
			: (Not:C34($vbNegativeSequence))
				$alSQ_PositiveSequence{$el}:=$vrSequenceNumber
			: ($vbNegativeSequence)
				$alSQ_NegativeSequence{$el}:=$vrSequenceNumber
		End case 
		VARIABLE TO VARIABLE:C635(-1;<>atSQ_TableFieldRef;$atSQ_TableFieldRef;<>alSQ_TableNumber;$alSQ_TableNumber;<>alSQ_FieldNumber;$alSQ_FieldNumber;<>alSQ_PositiveSequence;$alSQ_PositiveSequence;<>alSQ_NegativeSequence;$alSQ_NegativeSequence)
	Else 
		GET PROCESS VARIABLE:C371(-1;<>alSQ_TableNumber;$alSQ_TableNumber;<>alSQ_FieldNumber;$alSQ_FieldNumber;<>alSQ_PositiveSequence;$alSQ_PositiveSequence;<>alSQ_NegativeSequence;$alSQ_NegativeSequence)
		Case of 
			: (Not:C34($vbNegativeSequence))
				$alSQ_PositiveSequence{$el}:=$vrSequenceNumber
			: ($vbNegativeSequence)
				$alSQ_NegativeSequence{$el}:=$vrSequenceNumber
		End case 
		VARIABLE TO VARIABLE:C635(-1;<>atSQ_TableFieldRef;$atSQ_TableFieldRef;<>alSQ_TableNumber;$alSQ_TableNumber;<>alSQ_FieldNumber;$alSQ_FieldNumber;<>alSQ_PositiveSequence;$alSQ_PositiveSequence;<>alSQ_NegativeSequence;$alSQ_NegativeSequence)
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
		
		Case of 
			: (Not:C34($vbNegativeSequence))
				<>alSQ_PositiveSequence{$el}:=$vrSequenceNumber
			: ($vbNegativeSequence)
				<>alSQ_NegativeSequence{$el}:=$vrSequenceNumber
		End case 
	Else 
		Case of 
			: (Not:C34($vbNegativeSequence))
				<>alSQ_PositiveSequence{$el}:=$vrSequenceNumber
			: ($vbNegativeSequence)
				<>alSQ_NegativeSequence{$el}:=$vrSequenceNumber
		End case 
	End if 
End if 


$0:=$vrSequenceNumber
CLEAR SEMAPHORE:C144("Secuenciador")

