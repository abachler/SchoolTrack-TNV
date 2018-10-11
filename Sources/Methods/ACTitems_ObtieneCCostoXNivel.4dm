//%attributes = {}
  //ACTitems_ObtieneCCostoXNivel
  // Modificado por: Saúl Ponce (30-11-2016)
  // Agregué un 4to parámetro puntero hacia la moneda del cargo (o item) que determina con cuál blob hay que trabajar
  // Aumenté las opciones de los CASE para manejar las nuevas peticiones

C_POINTER:C301($vy_campoRequerido)
C_LONGINT:C283($l_idItem;$l_idCuenta;$l_idAlumno;$l_nivel)
C_TEXT:C284($t_dato;$t_retorno;$0)
C_BOOLEAN:C305($b_retornaInfoItem)

READ ONLY:C145([xxACT_Items:179])

$l_idItem:=$1
$l_idCuenta:=$2
$t_dato:=$3

If (Count parameters:C259>=4)
	$t_moneda:=$4
End if 

$b_retornaInfoItem:=False:C215

KRL_FindAndLoadRecordByIndex (->[xxACT_Items:179]ID:1;->$l_idItem)
If ($l_idCuenta#0)
	
	  // La primera condición es para cuando se fija la moneda del cargo al ejecutar el asistente
	If (([xxACT_Items:179]Moneda:10#$t_moneda) & ([xxACT_Items:179]Moneda:10#<>vtACT_monedaPais) & (BLOB size:C605([xxACT_Items:179]ContaMonedaPagoPais:50)>0))
		$vy_campoRequerido:=->[xxACT_Items:179]ContaMonedaPagoPais:50
	Else 
		$vy_campoRequerido:=->[xxACT_Items:179]xCentro_Costo:41
	End if 
	
	
	  //If (BLOB size([xxACT_Items]xCentro_Costo)#0)
	If (BLOB size:C605($vy_campoRequerido->)#0)
		
		  //ACTitems_LeeCentrosCostoXNivel ($l_idItem)
		ACTitems_LeeCentrosCostoXNivel ($l_idItem;$vy_campoRequerido)
		
		$l_idAlumno:=KRL_GetNumericFieldData (->[ACT_CuentasCorrientes:175]ID:1;->$l_idCuenta;->[ACT_CuentasCorrientes:175]ID_Alumno:3)
		$l_nivel:=KRL_GetNumericFieldData (->[Alumnos:2]numero:1;->$l_idAlumno;->[Alumnos:2]nivel_numero:29)
		
		$l_pos:=Find in array:C230(alACT_CCXN_NivelID;$l_nivel)
		If ($l_pos=-1)
			$b_retornaInfoItem:=True:C214
		Else 
			If (abACT_CCXN_UsarConfItem{$l_pos})
				$b_retornaInfoItem:=True:C214
			Else 
				Case of 
					: ($t_dato="CC")
						$t_retorno:=atACT_CCXN_CentroCosto{$l_pos}
					: ($t_dato="CCC")
						$t_retorno:=atACT_CCXN_CentroCostoContra{$l_pos}
						
						  // Modificado por: Saúl Ponce (09-12-2016)
					: ($t_dato="CTA")
						$t_retorno:=atACT_CCXN_CodPlanCtas{$l_pos}
					: ($t_dato="CCTA")
						$t_retorno:=atACT_CCXN_CodPlanCCtas{$l_pos}
					: ($t_dato="CA")
						$t_retorno:=atACT_CCXN_CodAux{$l_pos}
					: ($t_dato="CCA")
						$t_retorno:=atACT_CCXN_CodAuxCC{$l_pos}
				End case 
			End if 
		End if 
	Else 
		$b_retornaInfoItem:=True:C214
	End if 
Else 
	$b_retornaInfoItem:=True:C214
End if 

If ($b_retornaInfoItem)
	Case of 
		: ($t_dato="CC")
			$t_retorno:=[xxACT_Items:179]Centro_de_Costos:21
		: ($t_dato="CCC")
			$t_retorno:=[xxACT_Items:179]CCentro_de_costos:23
			
			  // Modificado por: Saúl Ponce (09-12-2016)
		: ($t_dato="CTA")
			$t_retorno:=[xxACT_Items:179]No_de_Cuenta_Contable:15
		: ($t_dato="CCTA")
			$t_retorno:=[xxACT_Items:179]No_CCta_contable:22
		: ($t_dato="CA")
			$t_retorno:=[xxACT_Items:179]CodAuxCta:27
		: ($t_dato="CCA")
			$t_retorno:=[xxACT_Items:179]CodAuxCCta:28
	End case 
End if 

$0:=$t_retorno