  // [xxSTR_Constants].SR_BuscaScript.lb_informes()
  // Por: Alberto Bachler K.: 18-08-15, 18:15:08
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($b_haySeleccionados)
C_LONGINT:C283($el1;$el2;$el3;$I_idxExpresion;$j;$l_areaRef;$l_error;$l_expresionCompleta;$l_idxLineas;$l_idxMetodos)
C_LONGINT:C283($l_primerElemento;$l_ultimoElemento)
C_POINTER:C301($y_expresion;$y_expresiones;$y_IdObjetos;$y_metodos;$y_metodosSeleccionado;$y_nombreObjetos;$y_scriptObjeto;$y_scriptObjetos)
C_TEXT:C284($t_scriptCuerpo;$t_scriptFin;$t_scriptInicio;$t_scriptObjeto;$t_tipoObjeto)

ARRAY LONGINT:C221($al_idObjetos;0)
ARRAY TEXT:C222($at_Expresiones;0)

$y_IdObjetos:=OBJECT Get pointer:C1124(Object named:K67:5;"idObjeto")
$y_nombreObjetos:=OBJECT Get pointer:C1124(Object named:K67:5;"nombreObjeto")
$y_scriptObjetos:=OBJECT Get pointer:C1124(Object named:K67:5;"scriptObjeto")


$y_expresion:=OBJECT Get pointer:C1124(Object named:K67:5;"expresion")
$l_expresionCompleta:=(OBJECT Get pointer:C1124(Object named:K67:5;"expresionCompleta"))->
$y_metodosSeleccionado:=OBJECT Get pointer:C1124(Object named:K67:5;"seleccionados")
$y_metodos:=OBJECT Get pointer:C1124(Object named:K67:5;"metodos")

Case of 
	: (Form event:C388=On Double Clicked:K2:5)
		GOTO SELECTED RECORD:C245([xShell_Reports:54];Selected record number:C246([xShell_Reports:54]))
		$t_codigo:=SR_GetAllScripts 
		$t_codigo:=CODE_Get_html ($t_codigo)
		  //WA SET PAGE CONTENT(*;"codigoHTML";$t_codigo;"")
		EXE_StyleCodeText (->$t_codigo)
		FORM GOTO PAGE:C247(2)
		WA SET PAGE CONTENT:C1037(*;"codigoHTML";$t_codigo;"")
		SET WINDOW TITLE:C213(__ ("Código en: ")+[xShell_Reports:54]ReportName:26)
		
	: ((Form event:C388=On Clicked:K2:4) | (Form event:C388=On Data Change:K2:15))
		SORT ARRAY:C229($y_metodosSeleccionado->;$y_metodos->;>)
		$b_haySeleccionados:=Find in sorted array:C1333($y_metodosSeleccionado->;True:C214;>;$l_primerElemento;$l_ultimoElemento)
		If ($b_haySeleccionados)
			For ($l_idxMetodos;$l_primerElemento;$l_ultimoElemento)
				APPEND TO ARRAY:C911($at_Expresiones;$y_metodos->{$l_idxMetodos})
			End for 
		End if 
		If ($y_expresion->#"")
			If ($l_expresionCompleta=1)
				APPEND TO ARRAY:C911($at_Expresiones;$y_expresion->)
			Else 
				For ($l_idxLineas;1;ST_countlines ($y_expresion->))
					APPEND TO ARRAY:C911($at_Expresiones;ST_GetLine ($y_expresion->;$l_idxLineas))
				End for 
			End if 
		End if 
		SORT ARRAY:C229($y_metodos->;$y_metodosSeleccionado->;>)
		
		AT_Initialize ($y_IdObjetos;$y_nombreObjetos;$y_scriptObjetos)
		
		GOTO SELECTED RECORD:C245([xShell_Reports:54];Selected record number:C246([xShell_Reports:54]))
		  // busqueda en el script a ejecutar antes de iniciar impresión del informe
		For ($I_idxExpresion;1;Size of array:C274($at_expresiones))
			$el1:=Position:C15($at_expresiones{$I_idxExpresion};[xShell_Reports:54]ExecuteBeforePrinting:4)
			If ($el1#0)
				APPEND TO ARRAY:C911($y_IdObjetos->;-1)
				APPEND TO ARRAY:C911($y_nombreObjetos->;__ ("Antes de imprimir"))
				APPEND TO ARRAY:C911($y_scriptObjetos->;[xShell_Reports:54]ExecuteBeforePrinting:4)
			End if 
		End for 
		
		  // busqueda en el script a ejecutar despues de iniciar impresión del informe
		For ($I_idxExpresion;1;Size of array:C274($at_expresiones))
			$el1:=Position:C15($at_expresiones{$I_idxExpresion};[xShell_Reports:54]ExecuteAfterPrinting:30)
			If ($el1#0)
				APPEND TO ARRAY:C911($y_IdObjetos->;-1)
				APPEND TO ARRAY:C911($y_nombreObjetos->;__ ("Después de imprimir"))
				APPEND TO ARRAY:C911($y_scriptObjetos->;[xShell_Reports:54]ExecuteAfterPrinting:30)
			End if 
		End for 
		
		  // obtengo el id de los objetos
		$l_error:=SR_NewReportBLOB ($l_areaRef;[xShell_Reports:54]xReportData_:29)
		SR_GetObjects ($l_areaRef;1;SRP_ReportAllObjects;$al_idObjetos)
		
		  //busqueda en los scripts del informe SRP
		For ($j;1;Size of array:C274($al_idObjetos))
			$t_tipoObjeto:=SR_GetTextProperty ($l_areaRef;$al_idObjetos{$j};SRP_Object_Kind)
			Case of 
				: ($t_tipoObjeto="DataSource")  // scripts de inicio, cuerpo y fin del informe
					$t_scriptInicio:=SR_GetTextProperty ($l_areaRef;$al_idObjetos{$j};SRP_DataSource_StartScript)
					$t_scriptCuerpo:=SR_GetTextProperty ($l_areaRef;$al_idObjetos{$j};SRP_DataSource_BodyScript)
					$t_scriptFin:=SR_GetTextProperty ($l_areaRef;$al_idObjetos{$j};SRP_DataSource_EndScript)
					If (($t_scriptInicio+$t_scriptCuerpo+$t_scriptFin)#"")
						For ($I_idxExpresion;1;Size of array:C274($at_expresiones))
							$el1:=Position:C15($at_expresiones{$I_idxExpresion};$t_scriptInicio)
							$el2:=Position:C15($at_expresiones{$I_idxExpresion};$t_scriptCuerpo)
							$el3:=Position:C15($at_expresiones{$I_idxExpresion};$t_scriptFin)
							If ($el1>0)
								APPEND TO ARRAY:C911($y_IdObjetos->;$al_idObjetos{$j})
								APPEND TO ARRAY:C911($y_nombreObjetos->;__ ("SRP Inicio"))
								APPEND TO ARRAY:C911($y_scriptObjetos->;$t_scriptInicio)
							End if 
							If ($el2>0)
								APPEND TO ARRAY:C911($y_IdObjetos->;$al_idObjetos{$j})
								APPEND TO ARRAY:C911($y_nombreObjetos->;__ ("SRP Cuerpo"))
								APPEND TO ARRAY:C911($y_scriptObjetos->;$t_scriptCuerpo)
							End if 
							If ($el3>0)
								APPEND TO ARRAY:C911($y_IdObjetos->;$al_idObjetos{$j})
								APPEND TO ARRAY:C911($y_nombreObjetos->;__ ("SRP Fin"))
								APPEND TO ARRAY:C911($y_scriptObjetos->;$t_scriptFin)
							End if 
						End for 
					End if 
					
					
				: (($t_tipoObjeto="variable") | ($t_tipoObjeto="var") | ($t_tipoObjeto="field") | ($t_tipoObjeto="section"))  // scripts de objetos
					$t_scriptObjeto:=SR_GetTextProperty ($l_areaRef;$al_idObjetos{$j};SRP_Object_Script)
					If ($t_scriptObjeto#"")
						For ($I_idxExpresion;1;Size of array:C274($at_expresiones))
							$el1:=Position:C15($at_expresiones{$I_idxExpresion};$t_scriptObjeto)
							If ($el1#0)
								APPEND TO ARRAY:C911($y_IdObjetos->;$al_idObjetos{$j})
								Case of 
									: (($t_tipoObjeto="var") | ($t_tipoObjeto="variable"))
										APPEND TO ARRAY:C911($y_nombreObjetos->;"variable: "+SR_GetTextProperty ($l_areaRef;$al_idObjetos{$j};SRP_Field_Source))
									: ($t_tipoObjeto="field")
										$t_RefCampo:=SR_GetTextProperty ($l_areaRef;$al_idObjetos{$j};SRP_Field_Source)
										$l_numeroTabla:=Num:C11(ST_GetWord ($t_RefCampo;1;"]"))
										$l_numeroCampo:=Num:C11(ST_GetWord ($t_RefCampo;2;"]"))
										$t_campo:="["+Table name:C256($l_numeroTabla)+"]"+Field name:C257($l_numeroTabla;$l_numeroCampo)
										APPEND TO ARRAY:C911($y_nombreObjetos->;"campo: "+$t_campo)
									: ($t_tipoObjeto="section")
										APPEND TO ARRAY:C911($y_nombreObjetos->;"section: "+SR_GetTextProperty ($l_areaRef;$al_idObjetos{$j};SRP_Object_Name))
								End case 
								APPEND TO ARRAY:C911($y_scriptObjetos->;$t_scriptObjeto)
							End if 
						End for 
					End if 
			End case 
		End for 
		SR_DeleteReport ($l_areaRef)
		
		
		If (Size of array:C274($y_nombreObjetos->)>0)
			LISTBOX SELECT ROW:C912(*;"lb_objetos";1;lk replace selection:K53:1)
			$t_codigoHTML:=CODE_Get_html ($y_scriptObjetos->{$y_scriptObjetos->})
			
			EXE_StyleCodeText (->$t_codigoHTML)
			WA SET PAGE CONTENT:C1037(*;"scriptHTML";$t_codigoHTML;"")
			  //$y_script:=OBJECT Get pointer(Object named;"script")
			  //$y_scriptsObjetos:=OBJECT Get pointer(Object named;"scriptObjeto")
			  //$y_script->:=$y_scriptsObjetos->{1}
			GOTO OBJECT:C206(*;"lb_objetos")
		End if 
		
		
		
		
End case 


