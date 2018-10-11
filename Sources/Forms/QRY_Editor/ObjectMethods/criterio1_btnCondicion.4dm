  // [xShell_Queries].QueryEditor.criterio1_btncondicion()
  //
  //
  // creado por: Alberto Bachler Klein: 23-02-16, 11:09:16
  // -----------------------------------------------------------
C_LONGINT:C283($l_fila;$l_opcion;$l_Posicion)
C_POINTER:C301($y_menuCondicion;$y_Index)

$l_fila:=Num:C11(OBJECT Get name:C1087(Object current:K67:2))
$y_menuCondicion:=OBJECT Get pointer:C1124(Object named:K67:5;"criterio"+String:C10($l_fila)+"_condicion")
$y_Index:=OBJECT Get pointer:C1124(Object named:K67:5;"index")
$y_variable:=OBJECT Get pointer:C1124(Object named:K67:5;"criterio"+String:C10($l_fila)+"_variable")
$l_fila:=Find in array:C230($y_Index->;$l_fila)
If (Not:C34(Is nil pointer:C315(ayQRY_Campos{$l_fila})))
	$l_tipo:=Type:C295(ayQRY_Campos{$l_fila}->)
	If ($l_tipo=Is picture:K8:10)
		$l_opcion:=Pop up menu:C542(__ ("Existe")+";"+__ ("No existe"))
	Else 
		$l_opcion:=Pop up menu:C542(AT_array2text (->aDelims))
	End if 
	If (($l_opcion>0) & ($l_fila>0))
		If ($l_tipo=Is picture:K8:10)
			AT_Initialize ($y_menuCondicion)
			Case of 
				: ($l_opcion=1)
					APPEND TO ARRAY:C911($y_menuCondicion->;__ ("Existe"))
					atQRY_Operador_Literal{$l_fila}:=aDelims{3}
					alQRY_Operador_ID{$l_fila}:=3
					$y_variable->:="0"
					
				: ($l_opcion=2)
					APPEND TO ARRAY:C911($y_menuCondicion->;__ ("No existe"))
					atQRY_Operador_Literal{$l_fila}:=aDelims{2}
					alQRY_Operador_ID{$l_fila}:=2
					$y_variable->:="0"
			End case 
			
		Else 
			atQRY_Operador_Literal{$l_fila}:=aDelims{$l_opcion}
			$l_Posicion:=Find in array:C230(<>atXS_QueryOperators_Text;atQRY_Operador_Literal{$l_fila})
			alQRY_Operador_ID{$l_fila}:=<>alXS_QueryOperators_NumRef{$l_posicion}
			
			If (atQRY_Operador_Literal{$l_fila}#"")
				If (Size of array:C274($y_menuCondicion->)=0)
					APPEND TO ARRAY:C911($y_menuCondicion->;atQRY_Operador_Literal{$l_fila})
				Else 
					$y_menuCondicion->{1}:=atQRY_Operador_Literal{$l_fila}
				End if 
				$y_menuCondicion->:=1
			End if 
		End if 
		
		
	End if 
	
End if 