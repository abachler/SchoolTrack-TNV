//%attributes = {}
  // QRY_QueryUserFields()
  // Por: Alberto Bachler: 21/02/13, 14:00:52
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_POINTER:C301($1)
C_LONGINT:C283($2)
C_TEXT:C284($3)

C_LONGINT:C283($i;$l_indiceItemConsulta;$l_numeroTabla;$r)
C_POINTER:C301($y_tabla)
C_REAL:C285($r_valorNumerico)
C_TEXT:C284($t_conector;$t_delimitador;$t_IdCampoPropio;$t_prefijoValor;$t_valor)

If (False:C215)
	C_POINTER:C301(QRY_QueryUserFields ;$1)
	C_LONGINT:C283(QRY_QueryUserFields ;$2)
	C_TEXT:C284(QRY_QueryUserFields ;$3)
End if 
C_POINTER:C301(vy_subTabla;vy_CampoPropio)




$y_tabla:=$1
$l_indiceItemConsulta:=$2
$t_conector:=$3

CREATE SET:C116($y_tabla->;"TempSearch")
CREATE EMPTY SET:C140($y_tabla->;"UFsearch")

$l_numeroTabla:=Table:C252($y_tabla)

QUERY:C277([xShell_Userfields:76];[xShell_Userfields:76]FileNo:6=$l_numeroTabla;*)
QUERY:C277([xShell_Userfields:76]; & ;[xShell_Userfields:76]ModuleName:10=vsBWR_CurrentModule;*)
QUERY:C277([xShell_Userfields:76]; & ;[xShell_Userfields:76]UserFieldName:1=Substring:C12(atQRY_NombreVirtualCampo{$l_indiceItemConsulta};Position:C15("]";atQRY_NombreVirtualCampo{$l_indiceItemConsulta})+1))
$t_prefijoValor:=String:C10([xShell_Userfields:76]FieldID:7;"00000/")
$t_IdCampoPropio:=$t_prefijoValor+"@"
$t_delimitador:=QRY_GetOperator (atQRY_Operador_Literal{$l_indiceItemConsulta})
Case of 
	: ([xShell_Userfields:76]FieldType:2=Is alpha field:K8:1)
		$t_valor:=atQRY_ValorLiteral{$l_indiceItemConsulta}
		Case of 
				  //20130520 RCH
				  //: ($t_delimitador=aDelims{1})
			: (atQRY_Operador_Literal{$l_indiceItemConsulta}=aDelims{1})
				$t_valor:=$t_valor+"@"
				  //: ($t_delimitador=aDelims{8})
			: (atQRY_Operador_Literal{$l_indiceItemConsulta}=aDelims{8})
				$t_valor:="@"+$t_valor+"@"
				  //: ($t_delimitador=aDelims{9})
			: (atQRY_Operador_Literal{$l_indiceItemConsulta}=aDelims{9})
				$t_valor:="@"+$t_valor+"@"
		End case 
	: ([xShell_Userfields:76]FieldType:2=Is real:K8:4)
		$t_valor:=String:C10(Num:C11(atQRY_ValorLiteral{$l_indiceItemConsulta});"0000000000,00")
	: ([xShell_Userfields:76]FieldType:2=Is date:K8:7)
		$t_valor:=String:C10(DT_Date2Num (Date:C102(atQRY_ValorLiteral{$l_indiceItemConsulta}));"0000000000")
	: ([xShell_Userfields:76]FieldType:2=Is longint:K8:6)
		$t_valor:=String:C10(Num:C11(atQRY_ValorLiteral{$l_indiceItemConsulta});"0000000000")
End case 

If (([xShell_Userfields:76]FieldType:2=Is real:K8:4) | ([xShell_Userfields:76]FieldType:2=Is date:K8:7) | ([xShell_Userfields:76]FieldType:2=Is longint:K8:6))
	  //los delimitadores "Comienza con", "Contiene" y "No Contiene" no aplican en campos fecha, real o longint
	If (($t_delimitador=aDelims{1}) | ($t_delimitador=aDelims{8}) | ($t_delimitador=aDelims{9}))
		$t_delimitador:="="
	End if 
End if 

$t_valor:=$t_prefijoValor+$t_valor
EXECUTE FORMULA:C63("vy_subTabla:=->"+"["+Table name:C256($l_numeroTabla)+"]Userfields")
EXECUTE FORMULA:C63("vy_CampoPropio:=»"+"["+Table name:C256($l_numeroTabla)+"]Userfields'Value")
vy_CampoPropio:=vy_CampoPropio
Case of 
	: ($t_delimitador="=")
		If (bSrchSel=1)
			QUERY SELECTION:C341($y_tabla->;vy_CampoPropio->=$t_valor)
		Else 
			QUERY:C277($y_tabla->;vy_CampoPropio->=$t_valor)
		End if 
	: ($t_delimitador=">")
		If (bSrchSel=1)
			QUERY SELECTION:C341($y_tabla->;vy_CampoPropio->=$t_IdCampoPropio)
		Else 
			QUERY:C277($y_tabla->;vy_CampoPropio->=$t_IdCampoPropio)
		End if 
		Case of 
			: ([xShell_Userfields:76]FieldType:2=Is real:K8:4)
				$r:=Num:C11(ST_GetWord (vy_CampoPropio->;2;"/"))
				QUERY SELECTION:C341($y_tabla->;vy_CampoPropio->=$t_IdCampoPropio)
				$r_valorNumerico:=Num:C11(ST_GetWord ($t_valor;2;"/"))
				$y_tabla:=Table:C252($l_numeroTabla)
				CREATE EMPTY SET:C140($y_tabla->;"found")
				For ($i;1;Records in selection:C76($y_tabla->))
					_O_QUERY SUBRECORDS:C108(vy_subTabla->;(Num:C11(ST_GetWord (vy_CampoPropio->;2;"/"))>$r_valorNumerico) & (vy_CampoPropio->=$t_IdCampoPropio))
					If (_O_Records in subselection:C7(vy_subTabla->)>0)
						ADD TO SET:C119($y_tabla->;"found")
					End if 
					NEXT RECORD:C51($y_tabla->)
				End for 
				USE SET:C118("found")
				
			: (([xShell_Userfields:76]FieldType:2=Is integer:K8:5) | ([xShell_Userfields:76]FieldType:2=Is longint:K8:6) | ([xShell_Userfields:76]FieldType:2=Is date:K8:7))
				$r:=Num:C11(ST_GetWord (vy_CampoPropio->;2;"/"))
				QUERY SELECTION:C341($y_tabla->;vy_CampoPropio->=$t_IdCampoPropio)
				$r_valorNumerico:=Num:C11(ST_GetWord ($t_valor;2;"/"))
				$y_tabla:=Table:C252($l_numeroTabla)
				CREATE EMPTY SET:C140($y_tabla->;"found")
				For ($i;1;Records in selection:C76($y_tabla->))
					_O_QUERY SUBRECORDS:C108(vy_subTabla->;(Num:C11(ST_GetWord (vy_CampoPropio->;2;"/"))>$r_valorNumerico) & (vy_CampoPropio->=$t_IdCampoPropio))
					If (_O_Records in subselection:C7(vy_subTabla->)>0)
						ADD TO SET:C119($y_tabla->;"found")
					End if 
					NEXT RECORD:C51($y_tabla->)
				End for 
				USE SET:C118("found")
				
			Else 
				QUERY SELECTION BY FORMULA:C207($y_tabla->;(vy_CampoPropio->=$t_IdCampoPropio) & (vy_CampoPropio->>$t_valor))
		End case 
		
	: ($t_delimitador=">=")
		If (bSrchSel=1)
			QUERY SELECTION:C341($y_tabla->;vy_CampoPropio->=$t_IdCampoPropio)
		Else 
			QUERY:C277($y_tabla->;vy_CampoPropio->=$t_IdCampoPropio)
		End if 
		Case of 
			: ([xShell_Userfields:76]FieldType:2=Is real:K8:4)
				$r:=Num:C11(ST_GetWord (vy_CampoPropio->;2;"/"))
				QUERY SELECTION:C341($y_tabla->;vy_CampoPropio->=$t_IdCampoPropio)
				$r_valorNumerico:=Num:C11(ST_GetWord ($t_valor;2;"/"))
				$y_tabla:=Table:C252($l_numeroTabla)
				CREATE EMPTY SET:C140($y_tabla->;"found")
				For ($i;1;Records in selection:C76($y_tabla->))
					_O_QUERY SUBRECORDS:C108(vy_subTabla->;(Num:C11(ST_GetWord (vy_CampoPropio->;2;"/"))>=$r_valorNumerico) & (vy_CampoPropio->=$t_IdCampoPropio))
					If (_O_Records in subselection:C7(vy_subTabla->)>0)
						ADD TO SET:C119($y_tabla->;"found")
					End if 
					NEXT RECORD:C51($y_tabla->)
				End for 
				USE SET:C118("found")
				
			: (([xShell_Userfields:76]FieldType:2=Is integer:K8:5) | ([xShell_Userfields:76]FieldType:2=Is longint:K8:6) | ([xShell_Userfields:76]FieldType:2=Is date:K8:7))
				$r:=Num:C11(ST_GetWord (vy_CampoPropio->;2;"/"))
				QUERY SELECTION:C341($y_tabla->;vy_CampoPropio->=$t_IdCampoPropio)
				$r_valorNumerico:=Num:C11(ST_GetWord ($t_valor;2;"/"))
				$y_tabla:=Table:C252($l_numeroTabla)
				CREATE EMPTY SET:C140($y_tabla->;"found")
				For ($i;1;Records in selection:C76($y_tabla->))
					_O_QUERY SUBRECORDS:C108(vy_subTabla->;(Num:C11(ST_GetWord (vy_CampoPropio->;2;"/"))>=$r_valorNumerico) & (vy_CampoPropio->=$t_IdCampoPropio))
					If (_O_Records in subselection:C7(vy_subTabla->)>0)
						ADD TO SET:C119($y_tabla->;"found")
					End if 
					NEXT RECORD:C51($y_tabla->)
				End for 
				USE SET:C118("found")
				
			Else 
				QUERY SELECTION BY FORMULA:C207($y_tabla->;(vy_CampoPropio->=$t_IdCampoPropio) & (vy_CampoPropio->>=$t_valor))
		End case 
		
	: ($t_delimitador="<")
		If (bSrchSel=1)
			QUERY SELECTION:C341($y_tabla->;vy_CampoPropio->=$t_IdCampoPropio)
		Else 
			QUERY:C277($y_tabla->;vy_CampoPropio->=$t_IdCampoPropio)
		End if 
		Case of 
			: ([xShell_Userfields:76]FieldType:2=Is real:K8:4)
				$r:=Num:C11(ST_GetWord (vy_CampoPropio->;2;"/"))
				QUERY SELECTION:C341($y_tabla->;vy_CampoPropio->=$t_IdCampoPropio)
				$r_valorNumerico:=Num:C11(ST_GetWord ($t_valor;2;"/"))
				$y_tabla:=Table:C252($l_numeroTabla)
				CREATE EMPTY SET:C140($y_tabla->;"found")
				For ($i;1;Records in selection:C76($y_tabla->))
					_O_QUERY SUBRECORDS:C108(vy_subTabla->;(Num:C11(ST_GetWord (vy_CampoPropio->;2;"/"))<$r_valorNumerico) & (vy_CampoPropio->=$t_IdCampoPropio))
					If (_O_Records in subselection:C7(vy_subTabla->)>0)
						ADD TO SET:C119($y_tabla->;"found")
					End if 
					NEXT RECORD:C51($y_tabla->)
				End for 
				USE SET:C118("found")
				
			: (([xShell_Userfields:76]FieldType:2=Is integer:K8:5) | ([xShell_Userfields:76]FieldType:2=Is longint:K8:6) | ([xShell_Userfields:76]FieldType:2=Is date:K8:7))
				$r:=Num:C11(ST_GetWord (vy_CampoPropio->;2;"/"))
				QUERY SELECTION:C341($y_tabla->;vy_CampoPropio->=$t_IdCampoPropio)
				$r_valorNumerico:=Num:C11(ST_GetWord ($t_valor;2;"/"))
				$y_tabla:=Table:C252($l_numeroTabla)
				CREATE EMPTY SET:C140($y_tabla->;"found")
				For ($i;1;Records in selection:C76($y_tabla->))
					_O_QUERY SUBRECORDS:C108(vy_subTabla->;(Num:C11(ST_GetWord (vy_CampoPropio->;2;"/"))<$r_valorNumerico) & (vy_CampoPropio->=$t_IdCampoPropio))
					If (_O_Records in subselection:C7(vy_subTabla->)>0)
						ADD TO SET:C119($y_tabla->;"found")
					End if 
					NEXT RECORD:C51($y_tabla->)
				End for 
				USE SET:C118("found")
				
			Else 
				QUERY SELECTION BY FORMULA:C207($y_tabla->;(vy_CampoPropio->=$t_IdCampoPropio) & (vy_CampoPropio-><$t_valor))
		End case 
		
	: ($t_delimitador="<=")
		If (bSrchSel=1)
			QUERY SELECTION:C341($y_tabla->;vy_CampoPropio->=$t_IdCampoPropio)
		Else 
			QUERY:C277($y_tabla->;vy_CampoPropio->=$t_IdCampoPropio)
		End if 
		Case of 
			: ([xShell_Userfields:76]FieldType:2=Is real:K8:4)
				$r:=Num:C11(ST_GetWord (vy_CampoPropio->;2;"/"))
				QUERY SELECTION:C341($y_tabla->;vy_CampoPropio->=$t_IdCampoPropio)
				$r_valorNumerico:=Num:C11(ST_GetWord ($t_valor;2;"/"))
				$y_tabla:=Table:C252($l_numeroTabla)
				CREATE EMPTY SET:C140($y_tabla->;"found")
				For ($i;1;Records in selection:C76($y_tabla->))
					_O_QUERY SUBRECORDS:C108(vy_subTabla->;(Num:C11(ST_GetWord (vy_CampoPropio->;2;"/"))<=$r_valorNumerico) & (vy_CampoPropio->=$t_IdCampoPropio))
					If (_O_Records in subselection:C7(vy_subTabla->)>0)
						ADD TO SET:C119($y_tabla->;"found")
					End if 
					NEXT RECORD:C51($y_tabla->)
				End for 
				USE SET:C118("found")
				
			: (([xShell_Userfields:76]FieldType:2=Is integer:K8:5) | ([xShell_Userfields:76]FieldType:2=Is longint:K8:6) | ([xShell_Userfields:76]FieldType:2=Is date:K8:7))
				$r:=Num:C11(ST_GetWord (vy_CampoPropio->;2;"/"))
				QUERY SELECTION:C341($y_tabla->;vy_CampoPropio->=$t_IdCampoPropio)
				$r_valorNumerico:=Num:C11(ST_GetWord ($t_valor;2;"/"))
				$y_tabla:=Table:C252($l_numeroTabla)
				CREATE EMPTY SET:C140($y_tabla->;"found")
				For ($i;1;Records in selection:C76($y_tabla->))
					_O_QUERY SUBRECORDS:C108(vy_subTabla->;(Num:C11(ST_GetWord (vy_CampoPropio->;2;"/"))<=$r_valorNumerico) & (vy_CampoPropio->=$t_IdCampoPropio))
					If (_O_Records in subselection:C7(vy_subTabla->)>0)
						ADD TO SET:C119($y_tabla->;"found")
					End if 
					NEXT RECORD:C51($y_tabla->)
				End for 
				USE SET:C118("found")
				
			Else 
				QUERY SELECTION BY FORMULA:C207($y_tabla->;(vy_CampoPropio->=$t_IdCampoPropio) & (vy_CampoPropio-><=$t_valor))
		End case 
		
	: ($t_delimitador="#")
		If (bSrchSel=1)
			QUERY SELECTION:C341($y_tabla->;vy_CampoPropio->=$t_IdCampoPropio)
		Else 
			QUERY:C277($y_tabla->;vy_CampoPropio->=$t_IdCampoPropio)
		End if 
		QUERY SELECTION BY FORMULA:C207($y_tabla->;(vy_CampoPropio->=$t_IdCampoPropio) & (vy_CampoPropio->#$t_valor))
		
End case 
CREATE SET:C116($y_tabla->;"UFSearch")
If (Table:C252($y_tabla)=Table:C252(vyQRY_TablePointer))
	Case of 
		: ($t_conector="&")
			INTERSECTION:C121("SearchResult";"UFsearch";"SearchResult")
		: ($t_conector="|")
			UNION:C120("SearchResult";"UFsearch";"SearchResult")
		: ($t_conector="#")
			DIFFERENCE:C122("SearchResult";"UFsearch";"SearchResult")
		: ($t_conector="")
			CREATE SET:C116($y_tabla->;"SearchResult")
	End case 
Else 
	Case of 
		: ($t_conector="&")
			INTERSECTION:C121("TempSearch";"UFSearch";"TempSearch")
		: ($t_conector="|")
			UNION:C120("TempSearch";"UFSearch";"TempSearch")
		: ($t_conector="#")
			DIFFERENCE:C122("TempSearch";"UFsearch";"TempSearch")
		: ($t_conector="")
			CREATE SET:C116($y_tabla->;"TempSearch")
	End case 
	USE SET:C118("TempSearch")
End if 

SET_ClearSets ("TempSearch";"UfSearch")