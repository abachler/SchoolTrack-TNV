//%attributes = {}
  //WR_HandleRightClick

C_LONGINT:C283($1;$6;$0)
_O_C_INTEGER:C282($2;$3;$4;$5)
C_LONGINT:C283($table;$field;$info1;$info2;XSWR_RefTable;XSWR_RefField)
C_TEXT:C284($variable;$method;$html;$url;XSWR_RefMethod;XSWR_RefVariable;XSWR_HTML;XSWR_URL)
$0:=1
If ($6=1)
	WR GET REFERENCE:P12000:60 (xWrite;$info1;$info2;$name;$type)
	XSWR_RefTable:=0
	XSWR_RefField:=0
	XSWR_RefMethod:=""
	XSWR_RefVariable:=""
	XSWR_HTML:=""
	XSWR_URL:=""
	If ($type#0)
		Case of 
			: ($type=1)
				XSWR_RefTable:=$info1
				XSWR_RefField:=$info2
			: ($type=2)
				If ($name[[Length:C16($name)]]=" ")
					XSWR_RefMethod:=Substring:C12($name;1;Length:C16($name)-1)
				Else 
					XSWR_RefVariable:=Replace string:C233($name;Char:C90(215);"<>")
				End if 
		End case 
	Else 
		WR GET HYPERLINK:P12000:169 (xWrite;$type;$style;$label;XSWR_URL;$methodRef)
		If ($type=-1)
			XSWR_HTML:=WR Get HTML expression:P12000:118 (xWrite)
		End if 
	End if 
Else 
	XSWR_RefTable:=0
	XSWR_RefField:=0
	XSWR_RefMethod:=""
	XSWR_RefVariable:=""
	XSWR_HTML:=""
	XSWR_URL:=""
	$0:=0
End if 
Case of 
	: ($5=wr on right click:K12005:12)
		$text:=WR Get selected text:P12000:21 (xWrite)
		$menuHTML:="Insertar Expresión HTML..."
		$menuHiper:="Insertar Hipervínculo..."
		$menuExpresion:="Insertar Expresión..."
		$cut:=ST_Boolean2Str (($text#"");"Cortar";"(Cortar")
		$copy:=ST_Boolean2Str (($text#"");"Copiar";"(Copiar")
		$delete:=ST_Boolean2Str (($text#"");"Borrar";"(Borrar")
		$paste:=ST_Boolean2Str (((Pasteboard data size:C400(Picture data:K20:3)>0) | (Pasteboard data size:C400(Text data:K20:2)>0));"Pegar";"(Pegar")
		$selAll:="Seleccionar Todo"
		$line:="(-"
		Case of 
			: ((XSWR_RefTable#0) & (XSWR_RefField#0))
				$menuExpresion:="Editar Expresión..."
			: ((XSWR_RefMethod#"") | (XSWR_RefVariable#""))
				$menuExpresion:="Editar Expresión..."
			: (XSWR_HTML#"")
				$menuHTML:="Editar Expresión HTML..."
			: (XSWR_URL#"")
				$menuHiper:="Editar Hipervínculo..."
		End case 
		$menu:=ST_Concatenate (";";->$cut;->$copy;->$paste;->$delete;->$selAll;->$line;->$menuHTML;->$menuHiper;->$menuExpresion)
		$choice:=Pop up menu:C542($menu)
		Case of 
			: ($choice=1)
				WR EXECUTE COMMAND:P12000:113 (xWrite;wr cmd cut:K12007:3)
			: ($choice=2)
				WR EXECUTE COMMAND:P12000:113 (xWrite;wr cmd copy:K12007:4)
			: ($choice=3)
				WR EXECUTE COMMAND:P12000:113 (xWrite;wr cmd paste:K12007:5)
			: ($choice=4)
				WR EXECUTE COMMAND:P12000:113 (xWrite;wr cmd clear:K12007:6)
			: ($choice=5)
				WR EXECUTE COMMAND:P12000:113 (xWrite;wr cmd select all:K12007:7)
			: ($choice=7)
				WR EXECUTE COMMAND:P12000:113 (xWrite;wr cmd insert HTML expression:K12007:201)
			: ($choice=8)
				WR EXECUTE COMMAND:P12000:113 (xWrite;wr cmd insert hyperlink:K12007:202)
			: ($choice=9)
				WR_EditExpression 
		End case 
		$0:=1
	: ($5=wr on double click:K12005:2)
		If ($0=1)
			Case of 
				: (((XSWR_RefTable#0) & (XSWR_RefField#0)) | (XSWR_RefVariable#"") | (XSWR_RefMethod#""))
					WR_EditExpression 
				: (XSWR_HTML#"")
					WR EXECUTE COMMAND:P12000:113 (xWrite;wr cmd insert HTML expression:K12007:201)
				: (XSWR_URL#"")
					WR EXECUTE COMMAND:P12000:113 (xWrite;wr cmd insert hyperlink:K12007:202)
			End case 
		End if 
End case 