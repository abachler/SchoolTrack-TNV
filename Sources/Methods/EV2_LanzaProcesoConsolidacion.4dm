//%attributes = {}
  // EV2_LanzaProcesoConsolidacion()
  // Por: Alberto Bachler: 28/08/13, 12:33:08
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($1)
C_LONGINT:C283($2)
C_LONGINT:C283($3)

C_BOOLEAN:C305($b_CalcularPromedioFinal)
_O_C_INTEGER:C282($i_madres)
C_LONGINT:C283($l_IdAlumno;$l_IdAsignatura;$l_Periodo;$l_periodoSeleccionado;$l_recNum;$l_recNum_Calificaciones)
C_TEXT:C284($t_llaveCalificaciones)

ARRAY LONGINT:C221($al_IDsAsignaturasMadre;0)
If (False:C215)
	C_LONGINT:C283(EV2_LanzaProcesoConsolidacion ;$1)
	C_LONGINT:C283(EV2_LanzaProcesoConsolidacion ;$2)
	C_LONGINT:C283(EV2_LanzaProcesoConsolidacion ;$3)
End if 
$l_IdAsignatura:=$1
$l_IdAlumno:=$2
$l_Periodo:=$3

If ($l_IdAsignatura#[Asignaturas:18]Numero:1)
	KRL_FindAndLoadRecordByIndex (->[Asignaturas:18]Numero:1;->$l_IdAsignatura)
End if 
$l_recNum:=Record number:C243([Asignaturas:18])

  // CODIGO PRINCIPAL
If ([Asignaturas:18]nivel_jerarquico:107>0)
	$l_periodoSeleccionado:=atSTR_Periodos_Nombre  // conservo el periodo seleccionado (puede cambiar durante la consolidación
	Case of 
		: ([Asignaturas:18]Consolidacion_Madre_Id:7>0)  //si la asignatura consolida en todos los perÕodos en la misma madre
			$t_llaveCalificaciones:=String:C10(<>gInstitucion)+"."+String:C10(<>gYear)+"."+String:C10([Asignaturas:18]Numero_del_Nivel:6)+"."+String:C10([Asignaturas:18]Consolidacion_Madre_Id:7)+"."+String:C10($l_IdAlumno)
			  //$b_calcular:=AS_PromediosSonCalculados ([Asignaturas]Consolidacion_Madre_Id)
			  //If ($b_Calcular)
			$l_recNum_Calificaciones:=Find in field:C653([Alumnos_Calificaciones:208]Llave_principal:1;$t_llaveCalificaciones)
			If ($l_Periodo=0)
				PERIODOS_LoadData ([Asignaturas:18]Numero_del_Nivel:6)
				For ($l_Periodo;1;viSTR_Periodos_NumeroPeriodos)
					$b_CalcularPromedioFinal:=($l_Periodo=viSTR_Periodos_NumeroPeriodos)
					EV2_Calculos_ConsolidaPeriodo ($l_recNum_Calificaciones;$l_Periodo;$b_CalcularPromedioFinal)
				End for 
			Else 
				EV2_Calculos_ConsolidaPeriodo ($l_recNum_Calificaciones;$l_Periodo;True:C214)
			End if 
			  //End if
			
			  //ABK 20130618 NUEVO CODIGO :[Asignaturas]Consolidacion_Madre_Id=1 cambiado por [Asignaturas]Consolidacion_Madre_Id<0
			  // - 2 indica asignaci—n a multiples asignaturas en todos los periodos
		: ([Asignaturas:18]Consolidacion_Madre_Id:7<0)  // si la asignatura consolida en distintas asignaturas en diferentes perIodos o durante todo el a–o
			If ($l_Periodo>0)
				AScsd_LeeReferencias ([Asignaturas:18]Numero:1;$l_Periodo)
				If (Records in selection:C76([Asignaturas_Consolidantes:231])>0)
					SELECTION TO ARRAY:C260([Asignaturas_Consolidantes:231]ID_AsignaturaMadre:1;$al_IDsAsignaturasMadre)
					For ($i_madres;1;Size of array:C274($al_IDsAsignaturasMadre))
						$t_llaveCalificaciones:=String:C10(<>gInstitucion)+"."+String:C10(<>gYear)+"."+String:C10([Asignaturas:18]Numero_del_Nivel:6)+"."+String:C10($al_IDsAsignaturasMadre{$i_madres})+"."+String:C10($l_IdAlumno)
						$l_recNum_Calificaciones:=Find in field:C653([Alumnos_Calificaciones:208]Llave_principal:1;$t_llaveCalificaciones)
						If ($l_recNum_Calificaciones>=0)
							EV2_Calculos_ConsolidaPeriodo ($l_recNum_Calificaciones;$l_Periodo;True:C214)
						End if 
					End for 
				End if 
			Else 
				For ($l_Periodo;1;viSTR_Periodos_NumeroPeriodos)
					$b_CalcularPromedioFinal:=($l_Periodo=viSTR_Periodos_NumeroPeriodos)
					AScsd_LeeReferencias ([Asignaturas:18]Numero:1;$l_Periodo)
					If (Records in selection:C76([Asignaturas_Consolidantes:231])>0)
						SELECTION TO ARRAY:C260([Asignaturas_Consolidantes:231]ID_AsignaturaMadre:1;$al_IDsAsignaturasMadre)
						For ($i_madres;1;Size of array:C274($al_IDsAsignaturasMadre))
							$t_llaveCalificaciones:=String:C10(<>gInstitucion)+"."+String:C10(<>gYear)+"."+String:C10([Asignaturas:18]Numero_del_Nivel:6)+"."+String:C10($al_IDsAsignaturasMadre{$i_madres})+"."+String:C10($l_IdAlumno)
							$l_recNum_Calificaciones:=Find in field:C653([Alumnos_Calificaciones:208]Llave_principal:1;$t_llaveCalificaciones)
							If ($l_recNum_Calificaciones>=0)
								EV2_Calculos_ConsolidaPeriodo ($l_recNum_Calificaciones;$l_Periodo;$b_CalcularPromedioFinal)
							End if 
						End for 
					End if 
					KRL_GotoRecord (->[Asignaturas:18];$l_recNum)
				End for 
			End if 
	End case 
	KRL_GotoRecord (->[Asignaturas:18];$l_recNum)
	EVS_ReadStyleData ([Asignaturas:18]Numero_de_EstiloEvaluacion:39)
	atSTR_Periodos_Nombre:=$l_periodoSeleccionado  // Reestablezco el período seleccionado
End if 

