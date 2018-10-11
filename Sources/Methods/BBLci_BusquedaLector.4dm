//%attributes = {}
  // BBLci_BusquedaLector()
  // Por: Alberto Bachler: 23/10/13, 11:27:55
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($0)
C_TEXT:C284($1)

C_LONGINT:C283($l_indexPrefijoLector;$l_LectorBuscarSobreNombre;$l_LectorPalabraCompleta;$l_LectorTipoBusquedaNombre;$l_recNumLector;$l_resultado)
C_TEXT:C284($t_barcode;$t_barCodeSinPrefijo;$t_prefijo)

If (False:C215)
	C_LONGINT:C283(BBLci_BusquedaLector ;$0)
	C_TEXT:C284(BBLci_BusquedaLector ;$1)
End if 

$t_barcode:=$1
$l_recNumLector:=-1
$0:=-1

ARRAY LONGINT:C221($al_RecNumsPosibles;0)

  // conservo el lector actual para restablecerlo si el usuario cancela la búsqueda
$l_lectorEnConsola:=Record number:C243([BBL_Lectores:72])


  // busco el lector por el código de barra completo
$l_recNumLector:=Find in field:C653([BBL_Lectores:72]BarCode_SinFormato:38;$t_barCode)


If ($l_recNumLector=No current record:K29:2)
	  // si no encuentro busco el código de barra omitiendo el prefijo 
	If (Length:C16($t_barcode)>4)
		If ((Num:C11($t_barcode[[1]])=0) & (Num:C11($t_barcode[[2]])=0) & (Num:C11($t_barcode[[3]])=0))
			$t_prefijo:=Substring:C12($t_barcode;1;3)
			$l_indexPrefijoLector:=Find in array:C230(<>asBBL_AbrevGruposLectores;$t_Prefijo)
		End if 
	End if 
	
	If ($l_indexPrefijoLector>0)
		$t_barCodeSinPrefijo:=Substring:C12($t_barcode;4)
		$l_recNumLector:=Find in field:C653([BBL_Lectores:72]BarCode_SinFormato:38;$t_barCodeSinPrefijo)
	End if 
	
	If ($l_recNumLector>No current record:K29:2)
		APPEND TO ARRAY:C911($al_RecNumsPosibles;$l_recNumLector)
	End if 
End if 



If ($l_recNumLector=No current record:K29:2)
	  // determino si el codigo de barra esta compuesto solo de digitos y extraigo obtengo el número
	If ($t_barcode="SYS-@")
		$l_NumeroCodigoBarra:=Num:C11($t_barcode)
	Else 
		$l_NumeroCodigoBarra:=ST_String_IsNumber ($t_barcode)
	End if 
	
	  // si no encuentro busco el lector sobre el campo ID
	If ($l_NumeroCodigoBarra#0)
		$l_recNumLector:=Find in field:C653([BBL_Lectores:72]ID:1;$l_NumeroCodigoBarra)
	End if 
	
	If ($l_recNumLector=No current record:K29:2)
		  // intento la búsqueda sobre el id del lector
		$l_NumeroCodigoBarra:=Num:C11($t_barCodeSinPrefijo)
		  // si no encuentro busco el lector sobre el campo ID
		If ($l_NumeroCodigoBarra#0)
			$l_recNumLector:=Find in field:C653([BBL_Lectores:72]ID:1;$l_NumeroCodigoBarra)
		End if 
	End if 
	
	If ($l_recNumLector>No current record:K29:2)
		APPEND TO ARRAY:C911($al_RecNumsPosibles;$l_recNumLector)
	End if 
End if 


If ($l_recNumLector=No current record:K29:2)
	  // si no encuentro busco el lector sobre el campo Identificador Nacional 1
	$l_recNumLector:=Find in field:C653([BBL_Lectores:72]RUT:7;$t_barcode)
End if 

If ($l_recNumLector=No current record:K29:2)
	  // si no encuentro busco el lector sobre el campo Identificador Nacional 2
	$l_recNumLector:=Find in field:C653([BBL_Lectores:72]IDNacional_2:33;$t_barcode)
	If ($l_recNumLector>No current record:K29:2)
		APPEND TO ARRAY:C911($al_RecNumsPosibles;$l_recNumLector)
	End if 
End if 

If ($l_recNumLector=No current record:K29:2)
	  // si no encuentro busco el lector sobre el campo Identificador Nacional 2
	$l_recNumLector:=Find in field:C653([BBL_Lectores:72]IDNacional_3:34;$t_barcode)
	If ($l_recNumLector>No current record:K29:2)
		APPEND TO ARRAY:C911($al_RecNumsPosibles;$l_recNumLector)
	End if 
End if 


Case of 
	: ($l_recNumLector>No current record:K29:2) & (Size of array:C274($al_RecNumsPosibles)<=1)
		$0:=$l_recNumLector
		
	: (Size of array:C274($al_RecNumsPosibles)>1)
		$l_recNumLector:=-1
		CREATE SELECTION FROM ARRAY:C640([BBL_Lectores:72];$al_RecNumsPosibles)
		ORDER BY:C49([BBL_Lectores:72];[BBL_Lectores:72]NombreCompleto:3;>)
		$l_resultado:=BBLci_SeleccionLectores 
		If ($l_resultado=1)
			$l_recNumLector:=Record number:C243([BBL_Lectores:72])
			$0:=$l_recNumLector
		Else 
			KRL_GotoRecord (->[BBL_Lectores:72];$l_lectorEnConsola)
			$0:=$l_lectorEnConsola
		End if 
		
	: ($l_NumeroCodigoBarra=0)
		  // si no se encontró al lector por su código de barra, la expresión ingresada no contiene numeros
		  // y en las preferencias de la consola está autorizada la búsqueda sobre el nombre
		OT GetVariable (vl_refObjectoPreferencias_BBLci;"$l_LectorBuscarSobreNombre";->$l_LectorBuscarSobreNombre)
		OT GetVariable (vl_refObjectoPreferencias_BBLci;"$l_LectorTipoBusquedaNombre";->$l_LectorTipoBusquedaNombre)
		OT GetVariable (vl_refObjectoPreferencias_BBLci;"$l_LectorPalabraCompleta";->$l_LectorPalabraCompleta)
		If (($l_recNumLector=No current record:K29:2) & ($l_NumeroCodigoBarra=0) & ($l_LectorBuscarSobreNombre=1))
			QRY_BusquedaPorPalabrasClave (->[BBL_Lectores:72];->[BBL_Lectores:72]NombreCompleto:3;vt_InstruccionConsola_BBL;$l_LectorTipoBusquedaNombre;$l_LectorPalabraCompleta)
			If (Records in selection:C76([BBL_Lectores:72])>0)
				ORDER BY:C49([BBL_Lectores:72];[BBL_Lectores:72]NombreCompleto:3;>)
				$l_resultado:=BBLci_SeleccionLectores 
				If ($l_resultado=1)
					$l_recNumLector:=Record number:C243([BBL_Lectores:72])
					$0:=$l_recNumLector
				Else 
					KRL_GotoRecord (->[BBL_Lectores:72];$l_lectorEnConsola)
					$0:=$l_lectorEnConsola
				End if 
			End if 
		End if 
End case 

