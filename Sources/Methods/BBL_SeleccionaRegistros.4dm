//%attributes = {}
  //BBL_SeleccionaRegistros

vtBBL_LastTitle:=""
vtBBL_Title:=""
vlBBL_LastBkgColor:=0x00FFFFFF
CREATE SET:C116([BBL_Items:61];"$ItemsSeleccionados")

ORDER BY:C49([BBL_Registros:66];[BBL_Items:61]Primer_título:4;>;[BBL_Registros:66]Número_de_copia:2;>)
READ ONLY:C145([BBL_Registros:66])
SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
ORDER BY:C49([BBL_Registros:66];[BBL_Items:61]Primer_título:4;>;[BBL_Registros:66]Número_de_copia:2;>)
FORM SET OUTPUT:C54([BBL_Registros:66];"ListaRegistros")
WDW_Open (594;503;-1;-8;"Selección de registros a imprimir";"WDW_CloseDlog")
DISPLAY SELECTION:C59([BBL_Registros:66];*)

  // Modificado por: Alexis Bustamante (17-07-2017)
  //TICKET 185606 
  //cuando se hace display se pierde la seleccion de la tabla origen.
USE SET:C118("$ItemsSeleccionados")
CLEAR SET:C117("$ItemsSeleccionados")

  //WDW_OpenFormWindow (->[xxSTR_Constants];"BBL_SeleccionaRegistros";-1;4)
  //KRL_ModifyRecord (->[xxSTR_Constants];"BBL_SeleccionaRegistros")
CLOSE WINDOW:C154
SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
If (OK=1)
	Case of 
		: (bPrintSelection=1)
			If (Records in set:C195("Userset")>0)
				USE SET:C118("Userset")
				ORDER BY:C49([BBL_Registros:66];[BBL_Items:61]Primer_título:4;>;[BBL_Registros:66]Número_de_copia:2;>)
				COPY NAMED SELECTION:C331([BBL_Registros:66];"◊Editions")
			End if 
		: (bPrintAll=1)
			COPY NAMED SELECTION:C331([BBL_Registros:66];"◊Editions")
	End case 
Else 
	REDUCE SELECTION:C351([BBL_Registros:66];0)
End if 
