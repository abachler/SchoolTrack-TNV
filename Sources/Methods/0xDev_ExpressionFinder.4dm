//%attributes = {}
  // Método: `0xDev_ExpressionFinder
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 03/08/10, 14:18:11
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones


  // Código principal
C_TEXT:C284($method;$1;$parameters;$3)
C_POINTER:C301($objectPointer;$2;$noTable)
C_LONGINT:C283($tableNum;$fieldNum)
_O_C_STRING:C293(255;$varName)


  // Código principal
Case of 
	: (Count parameters:C259=1)
		$method:=$1
	: (Count parameters:C259=2)
		$method:=$1
		$ObjectPointer:=$2
	: (Count parameters:C259=3)
		$method:=$1
		$ObjectPointer:=$2
		$parameters:=$3
End case 

If (Not:C34(Is nil pointer:C315($objectPointer)))
	RESOLVE POINTER:C394($objectPointer;$varName;$tableNum;$fieldNum)
	If ($tableNum>0) & ($fieldNum>0)
		$fieldName:="["+Table name:C256($tableNum)+"]"+Field name:C257($tableNum;$fieldNum)
	End if 
End if 


C_LONGINT:C283($0)
Case of 
	: ($method="")
		$p:=New process:C317("0xDev_ExpressionFinder";128000;"ExpressionFinder";"Start")
		
		
		
	: ($method="Start")
		C_POINTER:C301($noTable)
		WDW_OpenFormWindow ($noTable;"0xDev_ExpressionFinder";1;8;__ ("Búsqueda de expresiones en el código"))
		DIALOG:C40("0xDev_ExpressionFinder")
		CLOSE WINDOW:C154
		
		
	: ($method="FormMethod")
		Case of 
			: (Form event:C388=On Load:K2:1)
				vt_ParsingMethod:=""
				SET MENU BAR:C67("XS_Edicion";Current process:C322)
				ARRAY LONGINT:C221(aCodeObjectIds;0)
				ARRAY TEXT:C222(aCodeObjectNames;0)
				ARRAY TEXT:C222(aCodeLineText;0)
				
				ARRAY TEXT:C222(aObjectCodeLines;0)
				ARRAY LONGINT:C221(aCodeLineNumbers;0)
				
				_O_DISABLE BUTTON:C193(bParse)
				_O_DISABLE BUTTON:C193(bEdit)
				
				OBJECT SET VISIBLE:C603(*;"counters@";False:C215)
				
			: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Clicked:K2:4))
				If (vt_ParsingMethod#"")
					$methodID:=API Get Method ID (vt_ParsingMethod)
					If ($methodID#0)
						_O_ENABLE BUTTON:C192(bParse)
						_O_ENABLE BUTTON:C192(bEdit)
					Else 
						_O_DISABLE BUTTON:C193(bParse)
						_O_DISABLE BUTTON:C193(bEdit)
					End if 
				End if 
			: (Form event:C388=On Close Box:K2:21)
				CANCEL:C270
			: (Form event:C388=On Unload:K2:2)
				
			: (Form event:C388=On Outside Call:K2:11)
				
			: (Form event:C388=On Resize:K2:27)
				
		End case 
		
		
		
		
	: ($method="EditParser")
		$methodID:=API Get Method ID (vt_ParsingMethod)
		If ($methodID#0)
			4D_openMethodEditor ($methodID)
		End if 
		
	: ($method="ParserExists")
		$methodID:=API Get Method ID (vt_ParsingMethod)
		If ($methodID=0)
			ALERT:C41("El nombre de método registrado no existe.")
			vt_ParsingMethod:=""
			_O_DISABLE BUTTON:C193(bParse)
			_O_DISABLE BUTTON:C193(bEdit)
		End if 
		
		
	: ($method="ExecuteParser")
		ARRAY LONGINT:C221(aCodeObjectIds;0)
		ARRAY TEXT:C222(aCodeObjectNames;0)
		ARRAY TEXT:C222(aCodeLineText;0)
		
		ARRAY LONGINT:C221($aResourcesIDs;0)
		$counts:=API Count Resources ("CC4D")
		$error:=API Get Resource ID List ("CC4D";$aResourcesIDs)
		
		$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Analizando objetos..."))
		For ($iCodeObjects;1;Size of array:C274($aResourcesIDs))
			EXECUTE METHOD:C1007(vt_parsingMethod;*;$aResourcesIDs{$iCodeObjects})
			$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$iCodeObjects/Size of array:C274($aResourcesIDs);__ ("Analizando objetos...\r")+String:C10($iCodeObjects)+__ ("/")+String:C10(Size of array:C274($aResourcesIDs)))
		End for 
		$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
		
		
		ARRAY LONGINT:C221($al_IdMetodos;0)
		_O_ARRAY STRING:C218(31;$at_nombresMetodos;0)
		4D_GetMethodList (->$at_NombresMetodos;->$al_IdMetodos)
		
		
		vl_ErrorCount:=0
		vl_AlertCount:=0
		ARRAY TEXT:C222(aCodeObjectNames;Size of array:C274(aCodeObjectIds))
		For ($i;1;Size of array:C274(aCodeObjectIds))
			$el:=Find in array:C230($al_IdMetodos;Abs:C99(aCodeObjectIds{$i}))
			If ($el>0)
				aCodeObjectNames{$i}:=$at_nombresMetodos{$el}
			End if 
			vl_ErrorCount:=vl_ErrorCount+Num:C11(aCodeObjectIds{$i}>0)
			vl_AlertCount:=vl_AlertCount+Num:C11(aCodeObjectIds{$i}<0)
		End for 
		
		ARRAY LONGINT:C221(aStyles;0)
		ARRAY LONGINT:C221(aColors;0)
		ARRAY LONGINT:C221(aStyles;Size of array:C274(aObjectCodeLines))
		ARRAY LONGINT:C221(aColors;Size of array:C274(aObjectCodeLines))
		
		ARRAY TEXT:C222(aObjectCodeLines;0)
		LISTBOX SELECT ROW:C912(lbObjects;0;lk remove from selection:K53:3)
		LISTBOX SELECT ROW:C912(lbCodeLines;0;lk remove from selection:K53:3)
		
		  //If ((vl_ErrorCount+vl_AlertCount)>0)
		OBJECT SET VISIBLE:C603(*;"counters@";True:C214)
		  //End if 
		
	: ($method="LoadCode")
		C_BLOB:C604($xMethod)
		C_TEXT:C284($code)
		
		$xMethod:=4D_GetMethodTextBlob_By_CC4D_ID (Abs:C99(aCodeObjectIds{aCodeObjectIds}))
		$code:=BLOB to text:C555($xMethod;Mac text without length:K22:10)
		
		ARRAY LONGINT:C221(aCodeLineNumbers;0)
		ARRAY TEXT:C222(aObjectCodeLines;0)
		AT_Text2Array (->aObjectCodeLines;$code;"\r")
		
		ARRAY LONGINT:C221(aStyles;0)
		ARRAY LONGINT:C221(aColors;0)
		ARRAY LONGINT:C221(aStyles;Size of array:C274(aObjectCodeLines))
		ARRAY LONGINT:C221(aColors;Size of array:C274(aObjectCodeLines))
		ARRAY LONGINT:C221(aCodeLineNumbers;Size of array:C274(aObjectCodeLines))
		$color:=0x00FFFFFF
		AT_Populate (->aColors;->$color)
		
		
		For ($i;1;Size of array:C274(aCodeLineNumbers))
			aCodeLineNumbers{$i}:=$i
		End for 
		
		If (Position:C15("`";aCodeLineText{aCodeObjectIds})>0)
			aCodeLineText{aCodeObjectIds}:=Substring:C12(aCodeLineText{aCodeObjectIds};1;Position:C15("`";aCodeLineText{aCodeObjectIds})-1)
		End if 
		
		$string2Find:="@"+aCodeLineText{aCodeObjectIds}+"@"
		
		
		$el:=Find in array:C230(aObjectCodeLines;$string2Find)
		If ($el>0)
			If (aCodeObjectIds{aCodeObjectIds}>0)
				aStyles{$el}:=1
				  //aColors{$el}:=0x00FFFF27
				aColors{$el}:=0x00FFBEC1
			Else 
				aStyles{$el}:=0
				aColors{$el}:=0x00D8FFFF
			End if 
			OBJECT SET SCROLL POSITION:C906(lbCodeLines;$el;*)
		End if 
		
		
		
		
		
	: ($method="EditFoundedMethod")
		$methodID:=Abs:C99(aCodeObjectIds{aCodeObjectIds})
		$err:=4D_openMethodEditor ($methodID)
		
		
		
		
		
		
End case 

