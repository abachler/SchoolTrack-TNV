//%attributes = {}
  // 0xDev_BuscaScriptEnInformeSR()
  // Por: Alberto Bachler K.: 19-08-15, 12:57:59
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
  // MOD Ticket N° 209698 PA 20180615
C_TEXT:C284($0;$1)
C_LONGINT:C283($l_posicion1;$l_posicion2;$l_posicion3;$err;$i;$I_idxExpresion;$j;$l_areaRef;$l_error;$r;$l_index)
C_POINTER:C301($y_expresiones)
C_TEXT:C284($htmlEnd;$htmlStart;$t_expresion;$t_scriptCuerpo;$t_scriptFin;$t_scriptInicio;$t_scriptObjeto;$t_tipoObjeto;$vt_accion)
C_BOOLEAN:C305($b_archivar)
ARRAY TEXT:C222($at_error;0)
ARRAY INTEGER:C220($ai_mainTable;0)
ARRAY LONGINT:C221($al_idObjetos;0)
ARRAY LONGINT:C221($al_recNumsReports;0)
ARRAY LONGINT:C221($al_recNumsReportsWithScr;0)


If (False:C215)
	C_TEXT:C284(0xDev_BuscaScriptEnInformeSR ;$1)
End if 

If (Count parameters:C259>=1)
	$vt_accion:=$1
End if 
If (Count parameters:C259>=2)
	Case of 
		: (Type:C295($2->)=Text array:K8:16)
			$y_expresiones:=$2
		: (Type:C295($2->)=Is text:K8:3)
			$t_expresion:=$2->
	End case 
End if 
If (Count parameters:C259>=3)
	$b_archivar:=$3
End if 
Case of 
	: ($vt_accion="abrirForm") | (Count parameters:C259=0)
		WDW_OpenFormWindow (->[xxSTR_Constants:1];"SR_BuscaScript";-1;8;__ ("Búsqueda de código en informes"))
		DIALOG:C40([xxSTR_Constants:1];"SR_BuscaScript")
		CLOSE WINDOW:C154
		0xDev_BuscaScriptEnInformeSR ("LimpiaVarsForm")
		
	: ($vt_accion="declaraArraysForm")
		ARRAY TEXT:C222(aMethodNames;0)
		ARRAY INTEGER:C220(aMethodIDs;0)
		
	: ($vt_accion="declaraArraysALP")
		ARRAY TEXT:C222(at_NombreInforme;0)
		ARRAY TEXT:C222(at_TablaPrincipal;0)
		ARRAY TEXT:C222(at_TipoInforme;0)
		ARRAY PICTURE:C279(ap_estandar;0)
		ARRAY BOOLEAN:C223(ab_estandar;0)
		
	: ($vt_accion="declaraVarsForm")
		C_TEXT:C284(vt_valorSeleccionado)
		C_LONGINT:C283(btnOptMetodo;btnOptTexto)
		
	: ($vt_accion="InitVarsForm")
		vt_valorSeleccionado:=""
		btnOptMetodo:=1
		btnOptTexto:=0
		
	: ($vt_accion="OnLoad")
		0xDev_BuscaScriptEnInformeSR ("declaraVarsForm")
		0xDev_BuscaScriptEnInformeSR ("declaraArraysALP")
		0xDev_BuscaScriptEnInformeSR ("declaraArraysForm")
		0xDev_BuscaScriptEnInformeSR ("InitVarsForm")
		
	: ($vt_accion="LimpiaVarsForm")
		0xDev_BuscaScriptEnInformeSR ("declaraArraysForm")
		0xDev_BuscaScriptEnInformeSR ("declaraArraysALP")
		vt_valorSeleccionado:=""
		btnOptMetodo:=0
		btnOptTexto:=0
		
	: ($vt_accion="BuscaTextoEnInforme")
		If (Not:C34(Is nil pointer:C315($y_expresiones)))
			0xDev_BuscaScriptEnInformeSR ("declaraArraysALP")
			0xDev_BuscaScriptEnInformeSR ("declaraArraysForm")
			
			
			READ ONLY:C145([xShell_Reports:54])
			  // MOD Ticket N° 209698 PA 20180615
			If (Not:C34($b_archivar))
				QUERY:C277([xShell_Reports:54];[xShell_Reports:54]ReportType:2="gSR2")
			End if 
			LONGINT ARRAY FROM SELECTION:C647([xShell_Reports:54];$al_recNumsReports;"")
			$l_areaRef:=SR New Offscreen Area 
			If (Not:C34($b_archivar))
				$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Buscando el llamado a ")+ST_Qte (AT_array2text ($y_expresiones;", "))+__ (" en todos los informes de la base de datos..."))
			Else 
				$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Buscando el llamado a ")+ST_Qte (AT_array2text ($y_expresiones;", ")))
			End if 
			For ($i;1;Size of array:C274($al_recNumsReports))
				KRL_GotoRecord (->[xShell_Reports:54];$al_recNumsReports{$i})
				For ($i_expresion;1;Size of array:C274($y_expresiones->))
					If (Not:C34($b_archivar))
						$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($al_recNumsReports);__ ("Buscando el llamado a ")+ST_Qte ($y_expresiones->{$i_expresion})+__ (" en todos los informes de la base de datos..."))
					Else 
						$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($al_recNumsReports);__ ("Buscando el llamado a ")+ST_Qte ($y_expresiones->{$i_expresion}))
					End if 
					  // Cambio la anidacion de validaciones para poder capturar todas las ocurrencias de los expresiones buscadas.
					  // Esto provoca mayor tiempo de busqueda pero nos asegura encontrar todo.
					  // Busqueda sobre Propiedades
					$l_posicion1:=Position:C15($y_expresiones->{$i_expresion};[xShell_Reports:54]ExecuteBeforePrinting:4)
					If ($l_posicion1#0)
						$l_index:=Find in array:C230($al_recNumsReportsWithScr;$al_recNumsReports{$i})
						If ($l_index=-1)
							APPEND TO ARRAY:C911($al_recNumsReportsWithScr;$al_recNumsReports{$i})
						End if 
						If ($b_archivar)
							APPEND TO ARRAY:C911($at_error;"Lugar: Propiedades\tExpresion encontrada: "+$y_expresiones->{$i_expresion})
						End if 
					End if 
					  // Busqueda sobre Scripts de Inicio, Cuerpo y Fin
					xSR_ReportBlob:=[xShell_Reports:54]xReportData_:29
					$err:=SR Set Area ($l_areaRef;xSR_ReportBlob)
					$err:=SR Get Scripts ($l_areaRef;$t_scriptInicio;$t_scriptCuerpo;$t_scriptFin)
					$l_posicion1:=Position:C15($y_expresiones->{$i_expresion};$t_scriptInicio)
					$l_posicion2:=Position:C15($y_expresiones->{$i_expresion};$t_scriptCuerpo)
					$l_posicion3:=Position:C15($y_expresiones->{$i_expresion};$t_scriptFin)
					If (($l_posicion1#0) | ($l_posicion2#0) | ($l_posicion1#0))
						$l_index:=Find in array:C230($al_recNumsReportsWithScr;$al_recNumsReports{$i})
						If ($l_index=-1)
							APPEND TO ARRAY:C911($al_recNumsReportsWithScr;$al_recNumsReports{$i})
						End if 
						If ($b_archivar)
							If ($l_posicion1#0)
								APPEND TO ARRAY:C911($at_error;"Lugar: Scripts Inicio\tExpresion encontrada: "+$y_expresiones->{$i_expresion})
							End if 
							If ($l_posicion2#0)
								APPEND TO ARRAY:C911($at_error;"Lugar: Scripts Cuerpo\tExpresion encontrada: "+$y_expresiones->{$i_expresion})
							End if 
							If ($l_posicion3#0)
								APPEND TO ARRAY:C911($at_error;"Lugar: Scripts Fin \tExpresion encontrada: "+$y_expresiones->{$i_expresion})
							End if 
						End if 
					End if 
					
					  // Busqueda sobre Secciones del informe
					ARRAY LONGINT:C221($al_numerosObjetos;0)
					$err:=SR_GetObjects ($l_areaRef;1;SRP_ReportSections;$al_numerosObjetos)
					For ($j;1;Size of array:C274($al_numerosObjetos))
						$t_scriptSeccion:=""
						$r:=SR_GetPtrProperty ($l_areaRef;$al_numerosObjetos{$j};SRP_Object_Script;->$t_scriptSeccion)
						$l_posicion1:=Position:C15($y_expresiones->{$i_expresion};$t_scriptSeccion)
						If ($l_posicion1#0)
							$l_index:=Find in array:C230($al_recNumsReportsWithScr;$al_recNumsReports{$i})
							If ($l_index=-1)
								APPEND TO ARRAY:C911($al_recNumsReportsWithScr;$al_recNumsReports{$i})
							End if 
							If ($b_archivar)
								$t_nombreObjeto:=SR_GetTextProperty ($l_areaRef;$al_numerosObjetos{$j};SRP_Object_Name)
								APPEND TO ARRAY:C911($at_error;"Lugar: Seccion "+$t_nombreObjeto+"\tExpresion encontrada: "+$y_expresiones->{$i_expresion})
							End if 
						End if 
					End for 
					
					  // Busqueda sobre Objetos del informe
					ARRAY LONGINT:C221($al_idObjetos;0)
					$err:=SR Get Object IDs ($l_areaRef;0;$al_idObjetos)
					For ($j;1;Size of array:C274($al_idObjetos))
						$r:=SR Get Object Scripts ($l_areaRef;$al_idObjetos{$j};$t_scriptObjeto;$htmlStart;$htmlEnd)
						$l_posicion1:=Position:C15($y_expresiones->{$i_expresion};$t_scriptObjeto)
						If ($l_posicion1#0)
							$l_index:=Find in array:C230($al_recNumsReportsWithScr;$al_recNumsReports{$i})
							If ($l_index=-1)
								APPEND TO ARRAY:C911($al_recNumsReportsWithScr;$al_recNumsReports{$i})
							End if 
							If ($b_archivar)
								  // No fue posible capturar el nombre de los objetos tipo campo o variable.
								  //  //$error:=SR_FindObjectByID ($l_areaRef;$al_idObjetos{$j};$l_numeroObjeto)
								  //  //$error:=SR_FindObjectByID ($l_areaRef;$al_idObjetos{$j};vQR_long1)
								  //If ((SR_GetTextProperty ($l_areaRef;$al_idObjetos{$j};SRP_Object_Kind))=(SRP_ObjectKind_Field))
								  //$error:=SR_FindObjectByID ($l_areaRef;"Var_1";$l_objetoNumero)
								  //$t_nombreObjeto:="Campo "+SR_GetTextProperty ($l_areaRef;$l_objetoNumero;SRP_Object_Name)
								  //Else 
								  //$t_nombreObjeto:="Variable "+SR_GetTextProperty ($l_areaRef;$al_idObjetos{$j};SRP_Object_Name)
								  //End if 
								APPEND TO ARRAY:C911($at_error;"Lugar: Objeto \tExpresion encontrada: "+$y_expresiones->{$i_expresion})
							End if 
						End if 
					End for 
					
				End for 
			End for 
			$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
			SR DELETE OFFSCREEN AREA ($l_areaRef)
			If (Not:C34($b_archivar))
				REDUCE SELECTION:C351([xShell_Reports:54];0)
				CREATE SELECTION FROM ARRAY:C640([xShell_Reports:54];$al_recNumsReportsWithScr;"")
				ORDER BY:C49([xShell_Reports:54];[xShell_Reports:54]ReportType:2;>;[xShell_Reports:54]MainTable:3;>;[xShell_Reports:54]ReportName:26;>)
				  //SELECTION TO ARRAY([xShell_Reports]ReportName;at_NombreInforme;[xShell_Reports]MainTable;$ai_mainTable;[xShell_Reports]ReportType;at_TipoInforme;[xShell_Reports]IsStandard;ab_estandar)
				  //For ($i;1;Size of array($ai_mainTable))
				  //For ($i;1;Size of array($ai_mainTable))
				  //APPEND TO ARRAY(at_TablaPrincipal;XSvs_nombreTablaLocal_Numero ($ai_mainTable{$i};<>vtXS_CountryCode;<>vtXS_Langage))
				  //AT_Insert (0;1;->ap_estandar)
				  //If (ab_estandar{$i})
				  //GET PICTURE FROM LIBRARY("XS_EntryAccept";ap_estandar{$i})
				  //Else 
				  //GET PICTURE FROM LIBRARY("XS_EntryCancel";ap_estandar{$i})
				  //End if 
				  //End for 
				  //SORT ARRAY(at_TipoInforme;at_TablaPrincipal;at_NombreInforme;ap_estandar;>)
				  //Else 
			End if 
			If (($b_archivar) & (Size of array:C274($at_error)>0))
				$0:=AT_array2text (->$at_error;"\r")
			End if 
			
		End if 
End case 