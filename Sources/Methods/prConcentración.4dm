//%attributes = {}
  // prConcentración()
  //
  //
  // creado por: Alberto Bachler Klein: 28-03-16, 20:15:33
  // -----------------------------------------------------------
C_TEXT:C284($1)
C_TEXT:C284($2)

C_BLOB:C604($x_preferencias)
C_BOOLEAN:C305($b_unaTareaImpresion)
C_LONGINT:C283($i;$l_numeroEgresados)
C_TEXT:C284($t_destinoImpresion;$t_formulaNombreDocumento;$t_formulario;$t_refPreferencia)

ARRAY TEXT:C222($at_otrasOptativas;0)
ARRAY TEXT:C222($at_otrasOptativasHistoricas;0)



If (False:C215)
	C_TEXT:C284(prConcentración ;$1)
	C_TEXT:C284(prConcentración ;$2)
End if 

$t_destinoImpresion:=$1

If (Count parameters:C259=2)
	$t_formulaNombreDocumento:=$2
End if 

  // especial Grange
QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero_del_Nivel:6;>=;9;*)
QUERY:C277([Asignaturas:18]; & ;[Asignaturas:18]Numero_del_Nivel:6;<=;12;*)
QUERY:C277([Asignaturas:18]; & ;[Asignaturas:18]Asignatura:3;#;"Religion";*)
QUERY:C277([Asignaturas:18]; & ;[Asignaturas:18]Es_Optativa:70;=;True:C214;*)
QUERY:C277([Asignaturas:18]; & ;[Asignaturas:18]Incluida_en_Actas:44;=;True:C214)
DISTINCT VALUES:C339([Asignaturas:18]Asignatura:3;$at_otrasOptativas)


QUERY:C277([Asignaturas_Historico:84];[Asignaturas_Historico:84]Nivel:4;>=;9;*)
QUERY:C277([Asignaturas_Historico:84]; & ;[Asignaturas:18]Numero_del_Nivel:6;<=;12;*)
QUERY:C277([Asignaturas_Historico:84]; & ;[Asignaturas:18]Asignatura:3;#;"Religion";*)
QUERY:C277([Asignaturas_Historico:84]; & ;[Asignaturas:18]Es_Optativa:70;=;True:C214;*)
QUERY:C277([Asignaturas_Historico:84]; & ;[Asignaturas:18]Incluida_en_Actas:44;=;True:C214;*)
QUERY:C277([Asignaturas_Historico:84]; & ;[Asignaturas_Historico:84]Año:5;>=;<>gYear-4;*)
QUERY:C277([Asignaturas_Historico:84]; & ;[Asignaturas_Historico:84]Año:5;<=;<>gYear)
DISTINCT VALUES:C339([Asignaturas:18]Asignatura:3;$at_otrasOptativasHistoricas)
For ($i;1;Size of array:C274($at_otrasOptativasHistoricas))
	If (Find in array:C230($at_otrasOptativas;$at_otrasOptativasHistoricas{$i})=0)
		APPEND TO ARRAY:C911($at_otrasOptativas;$at_otrasOptativasHistoricas{$i})
	End if 
End for 
Case of 
	: (Size of array:C274($at_otrasOptativas)=0)
		vt_nombreOptativa2:=""
	: (Size of array:C274($at_otrasOptativas)=1)
		vt_nombreOptativa2:=$at_otrasOptativas{1}
	: (Size of array:C274($at_otrasOptativas)>1)
		AT_array2text (->$at_otrasOptativas;" o ")
End case 


  // Modificado por: Alexis Bustamante (05/08/2017)
  //185285 
  //al imprimir Solicitar impresora y hoja
Case of 
	: (vt_PLConfigMessage="carta")
		If (vt_nombreOptativa2#"")
			$t_formulario:="rep_CL_Concentracion_carta2"
		Else 
			$t_formulario:="rep_CL_Concentracion_carta"
		End if 
		QR_AjustesImpresion (Letter_Portrait)
		
	: (vt_PLConfigMessage="oficio")
		$t_formulario:="rep_CL_Concentracion_oficio"
		QR_AjustesImpresion (Legal_Portrait)
		
End case 

SET_ClearSets ("Historico")

QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]nivel_numero:29>=10;*)
QUERY SELECTION:C341([Alumnos:2]; | [Alumnos:2]nivel_numero:29=Nivel_Egresados)

If (Records in selection:C76([Alumnos:2])>0)
	CREATE SET:C116([Alumnos:2];"Concentracion")
	SET QUERY DESTINATION:C396(Into variable:K19:4;$l_numeroEgresados)
	QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]nivel_numero:29>=Nivel_Egresados)
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	
	ARRAY INTEGER:C220(al_AgnosConcentracion;0)
	Case of 
		: (($l_numeroEgresados>0) & ($l_numeroEgresados=Records in set:C195("Concentracion")))
			KRL_RelateSelection (->[Alumnos_Historico:25]Alumno_Numero:1;->[Alumnos:2]numero:1;"")
			AT_DistinctsFieldValues (->[Alumnos:2]AgnoEgreso:91;->al_AgnosConcentracion)
			SORT ARRAY:C229(al_AgnosConcentracion;<)
		: (($l_numeroEgresados>0) & ($l_numeroEgresados#Records in set:C195("Concentracion")))
			KRL_RelateSelection (->[Alumnos_Historico:25]Alumno_Numero:1;->[Alumnos:2]numero:1;"")
			AT_DistinctsFieldValues (->[Alumnos:2]AgnoEgreso:91;->al_AgnosConcentracion)
			INSERT IN ARRAY:C227(al_AgnosConcentracion;1;1)
			al_AgnosConcentracion{1}:=<>gYear
			SORT ARRAY:C229(al_AgnosConcentracion;<)
		: ($l_numeroEgresados=0)
			INSERT IN ARRAY:C227(al_AgnosConcentracion;1;1)
			al_AgnosConcentracion{1}:=<>gYear
			SORT ARRAY:C229(al_AgnosConcentracion;<)
	End case 
	al_AgnosConcentracion:=1
	vl_UltimoAgno:=al_AgnosConcentracion{1}
	
	
	ARRAY TEXT:C222(aPEAsgName;0)
	ARRAY INTEGER:C220(aPEAsgPos;0)
	ARRAY TEXT:C222(aPCAsgName;0)
	ARRAY INTEGER:C220(aPCAsgPos;0)
	For ($i;1;Size of array:C274(al_AgnosConcentracion))
		$t_refPreferencia:="ConcentraciónNotas.cl."+String:C10(al_AgnosConcentracion{$i})
		$x_preferencias:=PREF_fGetBlob (0;$t_refPreferencia;$x_preferencias)
		If (BLOB size:C605($x_preferencias)=0)
			AL_AsignaturasConcentracion (al_AgnosConcentracion{$i})
			$i:=Size of array:C274(al_AgnosConcentracion)
		Else 
			BLOB_Blob2Vars (->$x_preferencias;0;->aPCAsgName;->aPCAsgPos;->aPEAsgName;->aPEAsgPos)
			If (Size of array:C274(aPCAsgName)=0)
				AL_AsignaturasConcentracion (al_AgnosConcentracion{$i})
				$i:=Size of array:C274(al_AgnosConcentracion)
			End if 
		End if 
	End for 
	
	
	WDW_OpenFormWindow (->[Alumnos:2];"Concentracion_dlog";-1;8;__ ("Certificados de Concentración de Calificaciones"))
	DIALOG:C40([Alumnos:2];"Concentracion_dlog")
	CLOSE WINDOW:C154
	CLEAR SET:C117("Histórico")
	
	If (ok=1)
		vl_CurrentSelectedRecord:=1
		If (<>shift)
			ORDER BY:C49([Alumnos:2])
		Else 
			ORDER BY:C49([Alumnos:2];[Alumnos:2]apellidos_y_nombres:40;>;[Alumnos:2]nivel_numero:29;>;[Alumnos:2]curso:20;>)
		End if 
		
		$b_unaTareaImpresion:=False:C215
		QR_ImprimeFormularioSeleccion (->[Alumnos:2];$t_formulario;$t_destinoImpresion;$t_formulaNombreDocumento;$b_unaTareaImpresion)
	End if 
	
Else 
	CD_Dlog (0;__ ("No hay nada para imprimir. Las concentraciones de notas sólo pueden imprimirse para alumnos de 2 año de Enseñanza media o superiores."))
End if 



