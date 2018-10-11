//%attributes = {}
  // MÉTODO: xALP_CB_Aprendizajes
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 14/03/12, 13:17:31
  // ----------------------------------------------------
  // DESCRIPCIÓN
  //
  //
  // PARÁMETROS
  // xALP_CB_Aprendizajes()
  // ----------------------------------------------------
C_LONGINT:C283($0)
C_LONGINT:C283($1)
C_LONGINT:C283($2)
C_LONGINT:C283($3)
C_LONGINT:C283($4)
C_LONGINT:C283($5)
C_LONGINT:C283($6)
_O_C_STRING:C293(255;$7)
_O_C_STRING:C293(255;$8)

C_LONGINT:C283($l_columa;$l_eventoAreaList;$l_fila;$l_IdEstiloEvaluacion;$l_itemSeleccionadoPopup;$l_modificadores;$l_modificadorEvento;$l_recordNumber;$l_referenciaArea)
C_TEXT:C284($t_nombreAreaList;$t_opcionesPopup)
_O_C_STRING:C293(255;$t_nombreArea;$t_tip)

If (False:C215)
	C_LONGINT:C283(xALP_CB_Aprendizajes ;$0)
	C_LONGINT:C283(xALP_CB_Aprendizajes ;$1)
	C_LONGINT:C283(xALP_CB_Aprendizajes ;$2)
	C_LONGINT:C283(xALP_CB_Aprendizajes ;$3)
	C_LONGINT:C283(xALP_CB_Aprendizajes ;$4)
	C_LONGINT:C283(xALP_CB_Aprendizajes ;$5)
	C_LONGINT:C283(xALP_CB_Aprendizajes ;$6)
	_O_C_STRING:C293(xALP_CB_Aprendizajes ;255;$7)
	_O_C_STRING:C293(xALP_CB_Aprendizajes ;255;$8)
End if 


  // CODIGO PRINCIPAL
$l_referenciaArea:=$1
$l_eventoAreaList:=$2
$l_modificadorEvento:=$3
$l_columa:=$4
$l_fila:=$5
$l_modificadores:=$6
$t_tip:=$7
$t_nombreAreaList:=$8

Case of 
	: ($l_eventoAreaList=AL Single click event)
		
	: ($l_eventoAreaList=AL Single Control Click)
		If ((alEVLG_TipoObjeto{$l_fila}=Logro_Aprendizaje) & ($l_columa=4))
			Case of 
				: (alEVLG_TipoEvaluación{$l_fila}=1)  //indicadores de logro
					KRL_GotoRecord (->[Alumnos_EvaluacionAprendizajes:203];alEVLG_RecNum{$l_fila})
					$l_recordNumber:=Find in field:C653([MPA_DefinicionCompetencias:187]ID:1;[Alumnos_EvaluacionAprendizajes:203]ID_Competencia:7)
					KRL_GotoRecord (->[MPA_DefinicionCompetencias:187];$l_recordNumber)
					WDW_OpenFormWindow (->[MPA_DefinicionCompetencias:187];"Indicadores";7;1)
					DIALOG:C40([MPA_DefinicionCompetencias:187];"Indicadores")
					CLOSE WINDOW:C154
					
				: (alEVLG_TipoEvaluación{$l_fila}=3)  //indicadores de logro
					$l_IdEstiloEvaluacion:=alEVLG_RefEstiloEvaluacion{$l_fila}
					EVS_ReadStyleData ($l_IdEstiloEvaluacion)
					$t_opcionesPopup:=AT_array2text (->aSymbDesc;";")
					$l_itemSeleccionadoPopup:=Pop up menu:C542($t_opcionesPopup)
					If ($l_itemSeleccionadoPopup>0)
						atEVLG_Indicador{$l_fila}:=aSymbol{$l_itemSeleccionadoPopup}
						atEVLG_Observacion{$l_fila}:=aSymbDesc{$l_itemSeleccionadoPopup}
						arEVLG_Indicador{$l_fila}:=aSymbPctEqu{$l_itemSeleccionadoPopup}
						AL_UpdateArrays ($l_referenciaArea;-1)
					End if 
			End case 
		End if 
End case 