  // [xShell_Queries].QueryEditor.criterio1_btnConector()
  //
  //
  // creado por: Alberto Bachler Klein: 23-02-16, 10:24:19
  // -----------------------------------------------------------
C_LONGINT:C283($l_fila;$l_opcion)
C_POINTER:C301($y_menuConector;$y_index)

$y_index:=OBJECT Get pointer:C1124(Object named:K67:5;"index")
$y_menuConector:=OBJECT Get pointer:C1124(Object named:K67:5;"conector")
$l_fila:=Num:C11(OBJECT Get name:C1087(Object current:K67:2))

$l_elemento:=Find in array:C230($y_index->;$l_fila)
$y_menuConector:=OBJECT Get pointer:C1124(Object named:K67:5;"criterio"+String:C10($l_fila)+"_conector")

$l_opcion:=Pop up menu:C542("Y;O;Excepto")
If ($l_opcion>0)
	Case of 
		: ($l_opcion=1)
			atQRY_Conector_Literal{$l_elemento}:=__ ("Y")
			atQRY_Conector_Simbolo{$l_elemento}:="&"
		: ($l_opcion=2)
			atQRY_Conector_Literal{$l_elemento}:=__ ("O")
			atQRY_Conector_Simbolo{$l_elemento}:="|"
		: ($l_opcion=3)
			atQRY_Conector_Literal{$l_elemento}:=__ ("Excepto")
			atQRY_Conector_Simbolo{$l_elemento}:="#"
	End case 
	
	If (atQRY_Conector_Literal{$l_elemento}#"")
		If (Size of array:C274($y_menuConector->)=0)
			APPEND TO ARRAY:C911($y_menuConector->;atQRY_Conector_Literal{$l_elemento})
		Else 
			$y_menuConector->{1}:=atQRY_Conector_Literal{$l_elemento}
		End if 
		$y_menuConector->:=1
	End if 
End if 



