//%attributes = {}
  // Método: KRL_VerifyAllRelations
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 30/12/10, 08:48:57
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones

C_BOOLEAN:C305($autoOne;$autoMany)
C_LONGINT:C283($iTables;$iFields;$oneTable;$oneFile;$choiceField;$iRecords)
C_POINTER:C301($yfromTable;$yfromField)
C_DATE:C307($vd_NoValue)
C_LONGINT:C283($vl_NoValue)
C_TEXT:C284($vt_NoValue)

ARRAY POINTER:C280($aRelationsFrom;0)
ARRAY POINTER:C280($aRelationsTo;0)
ARRAY LONGINT:C221($aRecNums;0)

ARRAY LONGINT:C221($aDetailErrorRecNums;0)
ARRAY POINTER:C280($aDetailErrorRelationsFrom;0)
ARRAY TEXT:C222($aDetailErrorFieldvalues;0)
ARRAY TEXT:C222($aDetailErrorFieldNames;0)

ARRAY LONGINT:C221($alSourceRecNums;0)
ARRAY LONGINT:C221($alDestRecNums;0)

ARRAY TEXT:C222($at_SourceValues;0)
ARRAY REAL:C219($ar_SourceValues;0)
ARRAY DATE:C224($ad_SourceValues;0)

ARRAY TEXT:C222($at_DestValues;0)
ARRAY REAL:C219($ar_DestValues;0)
ARRAY DATE:C224($ad_DestValues;0)


ARRAY TEXT:C222($aStatusRelations;0)


  // Código principal
For ($iTables;1;Get last table number:C254)
	If (Is table number valid:C999($iTables))
		
		For ($iFields;1;Get last field number:C255($iTables))
			If (Is field number valid:C1000($iTables;$iFields))
				GET RELATION PROPERTIES:C686($iTables;$iFields;$oneTable;$oneField;$choiceField;$autoOne;$autoMany)
				If (($oneTable#0) & ($oneField#0))
					If ((Is table number valid:C999($oneTable)) & (Is field number valid:C1000($oneTable;$oneField)))
						APPEND TO ARRAY:C911($aRelationsFrom;Field:C253($iTables;$ifields))
						APPEND TO ARRAY:C911($aRelationsTo;Field:C253($oneTable;$oneField))
					End if 
				End if 
			End if 
		End for 
	End if 
End for 


SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
APPEND TO ARRAY:C911($aStatusRelations;"Resultado\tRelación\tOperativa\tRegistros huérfanos\tIndex dañados")
$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Verificando todas las relaciones...")
For ($iRelations;1;Size of array:C274($aRelationsFrom))
	$yfromTable:=Table:C252(Table:C252($aRelationsFrom{$iRelations}))
	$yfromField:=$aRelationsFrom{$iRelations}
	
	
	$yToTable:=Table:C252(Table:C252($aRelationsTo{$iRelations}))
	$yToField:=$aRelationsTo{$iRelations}
	
	
	
	
	
	$relacion:=Table name:C256($yfromTable)+"."+Field name:C257($yfromField)+" -> "+Table name:C256($yToTable)+"."+Field name:C257($yToField)
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$iRelations/Size of array:C274($aRelationsFrom);"Verificando todas las relaciones...\r"+$relacion)
	
	
	If (Not:C34(Type:C295($yToField->)=Is subtable:K8:11))
		$type:=Type:C295($yfromField->)
		Case of 
			: (($type=Is integer:K8:5) | ($type=Is longint:K8:6) | ($type=Is real:K8:4) | ($type=Is integer 64 bits:K8:25))
				QUERY:C277($yfromTable->;$yfromField->;#;0)
			: (($type=Is alpha field:K8:1) | ($type=Is text:K8:3))
				QUERY:C277($yfromTable->;$yfromField->;#;"")
			: ($type=Is date:K8:7)
				QUERY:C277($yfromTable->;$yfromField->;#;!00-00-00!)
			: ($type=Is time:K8:8)
				QUERY:C277($yfromTable->;$yfromField->;#;?00:00:00?)
			Else 
				ALL RECORDS:C47($yfromTable->)
		End case 
		
		
		$errorCount:=0
		$orphans:=0
		$OK:=0
		$badPointers:=0
		$noValues:=0
		
		$typeSourceField:=Type:C295($yfromField->)
		$typeDestField:=Type:C295($yToField->)
		
		
		Case of 
			: ($typeSourceField#$typeDestField)
				$stop:=True:C214
				$fault:="Los tipos de campos son diferentes."
			: (($typeSourceField=Is real:K8:4) | ($typeSourceField=Is longint:K8:6) | ($typeSourceField=Is integer:K8:5) | ($typeSourceField=Is time:K8:8))
				$sourceArrayPointer:=->$ar_SourceValues
				$destArrayPointer:=->$ar_DestValues
				$vy_NoValue:=->$vl_NoValue
				
			: (($typeSourceField=Is text:K8:3) | ($typeSourceField=Is alpha field:K8:1))
				$sourceArrayPointer:=->$at_SourceValues
				$destArrayPointer:=->$at_DestValues
				$vy_NoValue:=->$vt_NoValue
				
			: (($typeSourceField=Is date:K8:7))
				$sourceArrayPointer:=->$ad_SourceValues
				$destArrayPointer:=->$ad_DestValues
				$vy_NoValue:=->$vd_NoValue
				
		End case 
		SELECTION TO ARRAY:C260($yfromTable->;$alSourceRecNums;$yToTable->;$alDestRecNums;$yfromField->;$sourceArrayPointer->;$yToField->;$destArrayPointer->)
		
		
		For ($iRecords;1;Size of array:C274($alSourceRecNums))
			
			
			$relateAutoRecNum:=-1
			
			$foundedField:=Find in field:C653($yToField->;$destArrayPointer->{$iRecords})
			$relateAutoRecNum:=$alDestRecNums{$iRecords}
			$relationOK:=(($sourceArrayPointer->{$iRecords}=$destArrayPointer->{$iRecords}) & ($foundedField>=0))
			$noValue:=$sourceArrayPointer->{$iRecords}=$vy_NoValue->
			
			
			Case of 
				: ($relationOK)
					$OK:=$OK+1
					
				: ((($sourceArrayPointer->{$iRecords}#$vy_NoValue->) & ($destArrayPointer->{$iRecords}=$vy_NoValue->)) | ($sourceArrayPointer->{$iRecords}=$vy_NoValue->))
					  //APPEND TO ARRAY($aDetailErrorRecNums;$alSourceRecNums{$iRecords})
					  //APPEND TO ARRAY($aDetailErrorRelationsFrom;$yfromField)
					  //APPEND TO ARRAY($aDetailErrorFieldNames;Table name($yfromTable)+"."+Field name($yfromField))
					  //APPEND TO ARRAY($aDetailErrorFieldvalues;ST_Coerce_to_Text ($yfromField))
					$orphans:=$orphans+1
					
				: (($destArrayPointer->{$iRecords}=$vy_NoValue->) & ($foundedField>=0))
					  //APPEND TO ARRAY($aDetailErrorRecNums;$alSourceRecNums{$iRecords})
					  //APPEND TO ARRAY($aDetailErrorRelationsFrom;$yfromField)
					  //APPEND TO ARRAY($aDetailErrorFieldNames;Table name($yfromTable)+"."+Field name($yfromField))
					  //APPEND TO ARRAY($aDetailErrorFieldvalues;ST_Coerce_to_Text ($yfromField))
					$errorCount:=$errorCount+1
					
					
				: (($foundedField>=0) & ($sourceArrayPointer->{$iRecords}#$destArrayPointer->{$iRecords}))
					  //APPEND TO ARRAY($aDetailErrorRecNums;$alSourceRecNums{$iRecords})
					  //APPEND TO ARRAY($aDetailErrorRelationsFrom;$yfromField)
					  //APPEND TO ARRAY($aDetailErrorFieldNames;Table name($yfromTable)+"."+Field name($yfromField))
					  //APPEND TO ARRAY($aDetailErrorFieldvalues;ST_Coerce_to_Text ($yfromField))
					$badPointers:=$badPointers+1
					
					
				Else 
					  //APPEND TO ARRAY($aDetailErrorRecNums;$alSourceRecNums{$iRecords})
					  //APPEND TO ARRAY($aDetailErrorRelationsFrom;$yfromField)
					  //APPEND TO ARRAY($aDetailErrorFieldNames;Table name($yfromTable)+"."+Field name($yfromField))
					  //APPEND TO ARRAY($aDetailErrorFieldvalues;ST_Coerce_to_Text ($yfromField))
					
			End case 
		End for 
		
		$fault:=""
		$addDetail:=False:C215
		Case of 
			: (Size of array:C274($alSourceRecNums)=0)
				$fault:="N/A"+Char:C90(Tab:K15:37)+Table name:C256($yfromTable)+"."+Field name:C257($yfromField)+" -> "+Table name:C256($yToTable)+"."+Field name:C257($yToField)+Char:C90(Tab:K15:37)+"No hay registros en la tabla."
				
			: ($OK=Size of array:C274($alSourceRecNums))
				$fault:="OK"+Char:C90(Tab:K15:37)+Table name:C256($yfromTable)+"."+Field name:C257($yfromField)+" -> "+Table name:C256($yToTable)+"."+Field name:C257($yToField)+Char:C90(Tab:K15:37)+"SI"
				
			: ($errorCount=Size of array:C274($alSourceRecNums))
				$fault:="ERROR"+Char:C90(Tab:K15:37)+Table name:C256($yfromTable)+"."+Field name:C257($yfromField)+" -> "+Table name:C256($yToTable)+"."+Field name:C257($yToField)+Char:C90(Tab:K15:37)+"NO"
				
			: ($orphans=Size of array:C274($alSourceRecNums))
				$fault:="N/A"+Char:C90(Tab:K15:37)+Table name:C256($yfromTable)+"."+Field name:C257($yfromField)+" -> "+Table name:C256($yToTable)+"."+Field name:C257($yToField)+Char:C90(Tab:K15:37)+"Todos los registros son huerfanos."
				
			: ($badPointers=Size of array:C274($alSourceRecNums))
				$fault:="ERROR"+Char:C90(Tab:K15:37)+Table name:C256($yfromTable)+"."+Field name:C257($yfromField)+" -> "+Table name:C256($yToTable)+"."+Field name:C257($yToField)+Char:C90(Tab:K15:37)+"Index Dañados"
				
			: ($errorCount>0)
				$fault:="ERROR"+Char:C90(Tab:K15:37)+Table name:C256($yfromTable)+"."+Field name:C257($yfromField)+" -> "+Table name:C256($yToTable)+"."+Field name:C257($yToField)+Char:C90(Tab:K15:37)+"NO"
				$addDetail:=True:C214
				
			: (($errorCount=0) & ($orphans>0))
				$fault:="AVISO"+Char:C90(Tab:K15:37)+Table name:C256($yfromTable)+"."+Field name:C257($yfromField)+" -> "+Table name:C256($yToTable)+"."+Field name:C257($yToField)+Char:C90(Tab:K15:37)+"SI"
				$addDetail:=True:C214
				
			Else 
				$fault:="ERROR"+Char:C90(Tab:K15:37)+Table name:C256($yfromTable)+"."+Field name:C257($yfromField)+" -> "+Table name:C256($yToTable)+"."+Field name:C257($yToField)+Char:C90(Tab:K15:37)
				$addDetail:=True:C214
		End case 
		
		If ($addDetail)
			If ($errorCount>0)
				$fault:=$fault+" ("+String:C10($errorCount)+"/"+String:C10(Size of array:C274($alSourceRecNums))+" analizadas)"
			End if 
			If (($errorCount=0) & ($orphans>0))
				$fault:=$fault+" ("+String:C10(Size of array:C274($alSourceRecNums)-$orphans-$badPointers)+"/"+String:C10(Size of array:C274($alSourceRecNums))+" analizadas)"
			End if 
			If ($orphans>0)
				$fault:=$fault+Char:C90(Tab:K15:37)+String:C10($orphans)+"/"+String:C10(Size of array:C274($alSourceRecNums))+" registros huérfanos"
			End if 
			If ($badPointers>0)
				$fault:=$fault+Char:C90(Tab:K15:37)+String:C10($badPointers)+"/"+String:C10(Size of array:C274($alSourceRecNums))+" relaciones apuntan a un registro incorrecto"
			End if 
		End if 
		
	Else 
		$fault:="N/A"+Char:C90(Tab:K15:37)+Table name:C256($yfromTable)+"."+Field name:C257($yfromField)+" -> "+Table name:C256($yToTable)+"."+Field name:C257($yToField)+Char:C90(Tab:K15:37)+"Relación sobre subtabla"
	End if 
	
	APPEND TO ARRAY:C911($aStatusRelations;$fault)
End for 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)


$text:=""
For ($iRelations;1;Size of array:C274($aStatusRelations))
	$text:=$text+$aStatusRelations{$iRelations}+Char:C90(Carriage return:K15:38)
End for 
SET TEXT TO PASTEBOARD:C523($text)

ALERT:C41("El resultado del análisis de las relaciones automáticas está en el portapapeles")


