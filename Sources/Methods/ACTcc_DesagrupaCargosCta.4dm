//%attributes = {}
  //ACTcc_DesagrupaCargosCta

C_BOOLEAN:C305($1;$borrarlos)  // (ABK_Integracion_AT)


$0:=""
$borrarlos:=$1

QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_CuentaCorriente:2=[ACT_CuentasCorrientes:175]ID:1;*)  //Buscamos cargos asociados con la cuenta
QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]FechaEmision:22=!00-00-00!)  //que no hayan sido avisados
CREATE SET:C116([ACT_Cargos:173];"CargosCta")

QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Ref_Item:16=-1)
CREATE SET:C116([ACT_Cargos:173];"CargosEspeciales")

DIFFERENCE:C122("CargosCta";"CargosEspeciales";"CargosCtaSinEspeciales")
USE SET:C118("CargosCtaSinEspeciales")

KRL_RelateSelection (->[xxACT_ItemsMatriz:180]ID_Item:2;->[ACT_Cargos:173]Ref_Item:16;"")

QUERY SELECTION:C341([xxACT_ItemsMatriz:180];[xxACT_ItemsMatriz:180]ID_Matriz:1=[ACT_CuentasCorrientes:175]ID_Matriz:7)

KRL_RelateSelection (->[ACT_Cargos:173]Ref_Item:16;->[xxACT_ItemsMatriz:180]ID_Item:2;"")

CREATE SET:C116([ACT_Cargos:173];"CargosEnMatriz")

DIFFERENCE:C122("CargosCtaSinEspeciales";"CargosEnMatriz";"CargosNoMatriz")

$CargosEspeciales:=Records in set:C195("CargosEspeciales")
$CargosNoMatriz:=Records in set:C195("CargosNoMatriz")

Case of 
		
	: (($CargosEspeciales>0) & ($CargosNoMatriz>0))
		
		Case of 
				
			: (($CargosEspeciales>1) & ($CargosNoMatriz>1))
				
				$vtMsg:="Para esta cuenta existen "+String:C10($CargosEspeciales)+" cargos especiales y "
				$vtMsg:=$vtMsg+String:C10($CargosNoMatriz)+" cargos no pertenecientes a la matriz."
				$vtMsg:=$vtMsg+"\r"+"Estos cargos serán eliminados."
				
			: (($CargosEspeciales>1) & ($CargosNoMatriz=1))
				
				$vtMsg:="Para esta cuenta existen "+String:C10($CargosEspeciales)+" cargos especiales y "
				$vtMsg:=$vtMsg+String:C10($CargosNoMatriz)+" cargo no perteneciente a la matriz."
				$vtMsg:=$vtMsg+"\r"+"Estos cargos serán eliminados."
				
			: (($CargosEspeciales=1) & ($CargosNoMatriz>1))
				
				$vtMsg:="Para esta cuenta existe "+String:C10($CargosEspeciales)+" cargo especial y "
				$vtMsg:=$vtMsg+String:C10($CargosNoMatriz)+" cargos no pertenecientes a la matriz."
				$vtMsg:=$vtMsg+"\r"+"Estos cargos serán eliminados."
				
			: (($CargosEspeciales=1) & ($CargosNoMatriz=1))
				
				$vtMsg:="Para esta cuenta existe "+String:C10($CargosEspeciales)+" cargo especial y "
				$vtMsg:=$vtMsg+String:C10($CargosNoMatriz)+" cargo no perteneciente a la matriz."
				$vtMsg:=$vtMsg+"\r"+"Estos cargos serán eliminados."
				
		End case 
		
	: ($CargosEspeciales>0)
		
		If ($CargosEspeciales>1)
			
			$vtMsg:="Para esta cuenta existen "+String:C10($CargosEspeciales)+" cargos especiales."
			$vtMsg:=$vtMsg+"\r"+"Estos cargos serán eliminados."
			
		Else 
			
			$vtMsg:="Para esta cuenta existe "+String:C10($CargosEspeciales)+" cargo especial."
			$vtMsg:=$vtMsg+"\r"+"Este cargo será eliminado."
			
		End if 
		
	: ($CargosNoMatriz>0)
		
		If ($CargosNoMatriz>1)
			
			$vtMsg:="Para esta cuenta existen "+String:C10($CargosNoMatriz)+" cargos no pertenecientes a la matriz."
			$vtMsg:=$vtMsg+"\r"+"Estos cargos serán eliminados."
			
		Else 
			
			$vtMsg:="Para esta cuenta existe "+String:C10($CargosNoMatriz)+" cargo no perteneciente a la matriz."
			$vtMsg:=$vtMsg+"\r"+"Este cargo será eliminado."
			
		End if 
		
	Else 
		
		$vtMsg:=""
		
End case 

If ($borrarlos)
	
	UNION:C120("CargosEspeciales";"CargosNoMatriz";"CargosBorrar")
	USE SET:C118("CargosBorrar")
	DELETE SELECTION:C66([ACT_Cargos:173])
	
End if 

$0:=$vtMsg

CLEAR SET:C117("CargosBorrar")
CLEAR SET:C117("CargosCta")
CLEAR SET:C117("CargosEspeciales")
CLEAR SET:C117("CargosCtaSinEspeciales")
CLEAR SET:C117("CargosEnMatriz")
CLEAR SET:C117("CargosNoMatriz")
