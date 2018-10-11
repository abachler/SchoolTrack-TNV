//%attributes = {}
  //4D_ParseForm

C_DATE:C307($vd_Date)
C_LONGINT:C283($vl_ResourceID;$vl_Error;$vl_Size;$i)
C_BLOB:C604(vx_ResData)
_O_C_STRING:C293(4;$vs4_ResourceType)
C_TIME:C306($vh_Time)
C_LONGINT:C283($vl_TableNr;$vl_FieldNr)
_O_C_STRING:C293(40;$vs40_TableName)
C_LONGINT:C283($vl_Offset)
SET BLOB SIZE:C606(vx_ResData;0)

$vl_TableNr:=$1
$vt_FormName:=$2
$ParsePage:=-1
If (Count parameters:C259=3)
	$ParsePage:=$3
End if 

$vs4_ResourceType:="FO4D"
$vl_ResourceID:=4D_GetFormResourceID ($vl_TableNr;$vt_FormName)

$vl_Error:=API Get Resource ($vs4_ResourceType;$vl_ResourceID;vx_ResData)

  //--- parse FO4D

ARRAY LONGINT:C221(al_ResourceOffset;0)
ARRAY TEXT:C222(at_ResourceType;0)
ARRAY LONGINT:C221(ai_ResourceSize;0)
$vl_Offset:=0
$vl_Offset:=12
$res1:=BLOB to text:C555(vx_ResData;Mac text without length:K22:10;$vl_Offset;4)
If ($res1="Vers")
	byte:=Macintosh byte ordering:K22:2
	$invert:=False:C215
Else 
	byte:=PC byte ordering:K22:3
	$invert:=True:C214
End if 
$vl_Offset:=12
$pages:=0
While ($vl_Offset<BLOB size:C605(vx_ResData))
	APPEND TO ARRAY:C911(al_ResourceOffset;$vl_Offset)
	$res:=BLOB to text:C555(vx_ResData;Mac text without length:K22:10;$vl_Offset;4)
	If ($invert)
		$inverted:=""
		For ($l;Length:C16($res);1;-1)
			$inverted:=$inverted+$res[[$l]]
		End for 
		$res:=$inverted
	End if 
	APPEND TO ARRAY:C911(at_ResourceType;$res)
	$vl_Size:=BLOB to longint:C551(vx_ResData;byte;$vl_Offset)
	APPEND TO ARRAY:C911(ai_ResourceSize;$vl_Size)
	If (($vl_Size & 0x0001)#0)
		$vl_Size:=$vl_Size+1  // make sure we stay at a half-word boundary
	End if 
	$vl_Offset:=$vl_Offset+$vl_Size
	If (($res#"VAR ") & ($res#"TEXT") & ($res#"GRPB") & ($res#"PAGE") & ($res#"FILD"))
		DELETE FROM ARRAY:C228(al_ResourceOffset;Size of array:C274(al_ResourceOffset))
		DELETE FROM ARRAY:C228(at_ResourceType;Size of array:C274(at_ResourceType))
		DELETE FROM ARRAY:C228(ai_ResourceSize;Size of array:C274(ai_ResourceSize))
	Else 
		If ($res="VAR ")
			$top:=0
			$left:=0
			$bottom:=0
			$right:=0
			$text:=""
			$ObjName:=""
			$varType:=""
			4D_ParseFormObject (Size of array:C274(at_ResourceType);->$top;->$left;->$bottom;->$right;->$text;->$ObjName;->$varType)
			If (($varType#"boton 3D") & ($varType#"boton") & ($varType#"boton de opcion") & ($varType#"casilla de seleccion") & ($varType#"casilla de seleccion 3D") & ($varType#"boton defecto"))
				DELETE FROM ARRAY:C228(al_ResourceOffset;Size of array:C274(al_ResourceOffset))
				DELETE FROM ARRAY:C228(at_ResourceType;Size of array:C274(at_ResourceType))
				DELETE FROM ARRAY:C228(ai_ResourceSize;Size of array:C274(ai_ResourceSize))
			Else 
				If ($varType="boton 3D")
					$text:=ST_GetWord ($text;1;";")
				End if 
				If ($ParsePage=-1)
					APPEND TO ARRAY:C911(atXS_CLESText;$text)
					APPEND TO ARRAY:C911(atXS_IntText;$text)
					APPEND TO ARRAY:C911(alXS_Page;$pages)
					APPEND TO ARRAY:C911(alXS_Top;$top)
					APPEND TO ARRAY:C911(alXS_Left;$left)
					APPEND TO ARRAY:C911(alXS_Bottom;$bottom)
					APPEND TO ARRAY:C911(alXS_Right;$right)
					APPEND TO ARRAY:C911(atXS_ObjectName;$ObjName)
				Else 
					If (($pages=$ParsePage) | ($pages=0))
						APPEND TO ARRAY:C911(atXS_CLESText;$text)
						APPEND TO ARRAY:C911(atXS_IntText;$text)
						APPEND TO ARRAY:C911(alXS_Page;$pages)
						APPEND TO ARRAY:C911(alXS_Top;$top)
						APPEND TO ARRAY:C911(alXS_Left;$left)
						APPEND TO ARRAY:C911(alXS_Bottom;$bottom)
						APPEND TO ARRAY:C911(alXS_Right;$right)
						APPEND TO ARRAY:C911(atXS_ObjectName;$ObjName)
					End if 
				End if 
			End if 
		Else 
			If ($res="PAGE")
				4D_ParseFormObject (Size of array:C274(at_ResourceType);->$top;->$left;->$bottom;->$right;->$text;->$ObjName;->$varType;->$pages)
				$pages:=$pages+1
			Else 
				4D_ParseFormObject (Size of array:C274(at_ResourceType);->$top;->$left;->$bottom;->$right;->$text;->$ObjName;->$varType)
				If ($ParsePage=-1)
					APPEND TO ARRAY:C911(atXS_CLESText;$text)
					APPEND TO ARRAY:C911(atXS_IntText;$text)
					APPEND TO ARRAY:C911(alXS_Page;$pages)
					APPEND TO ARRAY:C911(alXS_Top;$top)
					APPEND TO ARRAY:C911(alXS_Left;$left)
					APPEND TO ARRAY:C911(alXS_Bottom;$bottom)
					APPEND TO ARRAY:C911(alXS_Right;$right)
					APPEND TO ARRAY:C911(atXS_ObjectName;$ObjName)
				Else 
					If (($pages=$ParsePage) | ($pages=0))
						If ($text#"")
							APPEND TO ARRAY:C911(atXS_CLESText;$text)
							APPEND TO ARRAY:C911(atXS_IntText;$text)
							APPEND TO ARRAY:C911(alXS_Page;$pages)
							APPEND TO ARRAY:C911(alXS_Top;$top)
							APPEND TO ARRAY:C911(alXS_Left;$left)
							APPEND TO ARRAY:C911(alXS_Bottom;$bottom)
							APPEND TO ARRAY:C911(alXS_Right;$right)
							APPEND TO ARRAY:C911(atXS_ObjectName;$ObjName)
						End if 
					End if 
				End if 
			End if 
		End if 
	End if 
End while 