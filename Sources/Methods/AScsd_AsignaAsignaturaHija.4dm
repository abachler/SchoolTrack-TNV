//%attributes = {}
  // MƒTODO: AScsd_AsignaAsignaturaHija
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creaci—n: 26/12/11, 12:29:58
  // ----------------------------------------------------
  // DESCRIPCIîN
  // Asigna la asignatura pasada en $3 como hija de la asignatura madre pasada en $1
  // en la columna pasada en $4 
  // si la configuracion de propiedades de consolidacion de la asignatura madre varia segun periodo
  // si se utiliza el argumento opcional $5 (string del numero de periodo) la asignacion se hara solo para ese periodo
  // Para la asignatura hija se crean las referencias de consolidacion en la tabla [Asignaturas_Consolidantes]
  //
  // PARçMETROS
  // AScsd_AsignaAsignaturaHija(ID_AsignaturaMadre;nombreAsignaturaHija;ID_asignaturaHija;numeroColumna{;periodo})
  // $1: ID_AsignaturaMadre: longint
  // $2: nombreAsignaturaHija: texto
  // $3: ID_asignaturaHija: longint
  // $4: numeroColumna: longint
  // $5: periodo: texto (opcional)
  // ----------------------------------------------------


  // DECLARACIONES E INICIALIZACIONES
C_BOOLEAN:C305($0)
C_LONGINT:C283($1)
C_TEXT:C284($2)
C_LONGINT:C283($3)
C_LONGINT:C283($4)
C_TEXT:C284($5)

C_BOOLEAN:C305($b_cancelTrans)
C_LONGINT:C283($l_IdAsignaturaHija;$l_IdAsignaturaMadre;$l_numeroColumna;$l_Periodo;$l_recNum;$l_RegistrosEvaluados;$l_OtrasMadres)
C_TEXT:C284($t_destName;$t_Periodo;$t_ReferenciaSubasignatura)

If (False:C215)
	C_BOOLEAN:C305(AScsd_AsignaAsignaturaHija ;$0)
	C_LONGINT:C283(AScsd_AsignaAsignaturaHija ;$1)
	C_TEXT:C284(AScsd_AsignaAsignaturaHija ;$2)
	C_LONGINT:C283(AScsd_AsignaAsignaturaHija ;$3)
	C_LONGINT:C283(AScsd_AsignaAsignaturaHija ;$4)
	C_TEXT:C284(AScsd_AsignaAsignaturaHija ;$5)
End if 



  //CUERPO
$l_IdAsignaturaMadre:=$1
$l_IdAsignaturaHija:=$3
$t_destName:=$2
$l_numeroColumna:=$4
If (Count parameters:C259=5)
	$t_Periodo:=$5
Else 
	$t_Periodo:=String:C10(aiSTR_Periodos_Numero{atSTR_Periodos_Nombre})
End if 
$0:=False:C215
$b_cancelTrans:=False:C215


READ WRITE:C146([Asignaturas:18])

Case of 
	: ($l_IdAsignaturaHija>0)
		QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero:1=$l_IdAsignaturaHija)
		If (Not:C34(KRL_IsRecordLocked (->[Asignaturas:18])))
			If (vb_CsdVariable)  //si la consolidaci—n segœn per’odo
				
				  // busco y elimino las eventuales referencias de consolidaci—n que pod’an existir
				  //AScsd_LeeReferencias ([Asignaturas]Numero)
				  //20121128 ASM
				AScsd_LeeReferencias ([Asignaturas:18]Numero:1;Num:C11($t_Periodo))
				CREATE SET:C116([Asignaturas_Consolidantes:231];"SPeriodo")
				AScsd_LeeReferencias ([Asignaturas:18]Numero:1)
				CREATE SET:C116([Asignaturas_Consolidantes:231];"General")
				UNION:C120("SPeriodo";"General";"Eliminar")
				USE SET:C118("Eliminar")
				
				QUERY SELECTION:C341([Asignaturas_Consolidantes:231];[Asignaturas_Consolidantes:231]Periodo:3;=;$t_Periodo;*)
				QUERY SELECTION:C341([Asignaturas_Consolidantes:231]; | ;[Asignaturas_Consolidantes:231]Periodo:3;="0";*)
				QUERY SELECTION:C341([Asignaturas_Consolidantes:231]; | ;[Asignaturas_Consolidantes:231]Periodo:3;="")
				KRL_DeleteSelection (->[Asignaturas_Consolidantes:231])
				
				  // creo la nueva referencia de consolidaci—n
				CREATE RECORD:C68([Asignaturas_Consolidantes:231])
				[Asignaturas_Consolidantes:231]ID_ParentRecord:5:=$l_IdAsignaturaHija
				[Asignaturas_Consolidantes:231]ID_AsignaturaMadre:1:=$l_IdAsignaturaMadre
				[Asignaturas_Consolidantes:231]Name:2:=$t_destName
				[Asignaturas_Consolidantes:231]Periodo:3:=$t_Periodo
				SAVE RECORD:C53([Asignaturas_Consolidantes:231])
				
				  //se marca como consolidable por periodo
				[Asignaturas:18]Consolidacion_Madre_Id:7:=-1
				[Asignaturas:18]Consolidacion_Madre_nombre:8:="Varía según período"
				
				SET_ClearSets ("SPeriodo";"General";"Eliminar")
			Else 
				
				  //ABK 20130618 NUEVO CODIGO
				  // creo la nueva referencia de consolidaci—n
				SET QUERY DESTINATION:C396(Into variable:K19:4;$l_OtrasMadres)  // determino si hay otras madres
				QUERY:C277([Asignaturas_Consolidantes:231];[Asignaturas_Consolidantes:231]ID_ParentRecord:5;=;$l_IdAsignaturaHija;*)
				QUERY:C277([Asignaturas_Consolidantes:231]; & ;[Asignaturas_Consolidantes:231]ID_AsignaturaMadre:1;#;$l_IdAsignaturaMadre)
				SET QUERY DESTINATION:C396(Into current selection:K19:1)
				
				QUERY:C277([Asignaturas_Consolidantes:231];[Asignaturas_Consolidantes:231]ID_ParentRecord:5;=;$l_IdAsignaturaHija;*)
				QUERY:C277([Asignaturas_Consolidantes:231]; & ;[Asignaturas_Consolidantes:231]ID_AsignaturaMadre:1;=;$l_IdAsignaturaMadre;*)
				QUERY:C277([Asignaturas_Consolidantes:231]; & ;[Asignaturas_Consolidantes:231]Periodo:3;=;"")
				If (Records in selection:C76([Asignaturas_Consolidantes:231])=0)
					CREATE RECORD:C68([Asignaturas_Consolidantes:231])
					[Asignaturas_Consolidantes:231]ID_ParentRecord:5:=$l_IdAsignaturaHija
					[Asignaturas_Consolidantes:231]ID_AsignaturaMadre:1:=$l_IdAsignaturaMadre
					[Asignaturas_Consolidantes:231]Name:2:=$t_destName
					[Asignaturas_Consolidantes:231]Periodo:3:=""
					SAVE RECORD:C53([Asignaturas_Consolidantes:231])
				End if 
				  // si hay otras madres  asigno -2 al campo [Asignaturas]Consolidacion_Madre_Id para indicar que tiene varias madres durante el a–o completo
				If ($l_OtrasMadres=0)
					[Asignaturas:18]Consolidacion_Madre_Id:7:=$l_IdAsignaturaMadre  //se inscribe el id de la asignatura madre (œnica)
					[Asignaturas:18]Consolidacion_Madre_nombre:8:=$t_destName  //se inscribe el nombre de la consolidante (œnica)       
				Else 
					[Asignaturas:18]Consolidacion_Madre_Id:7:=-2  // asigno -2 para indicar que tiene varias madres
					[Asignaturas:18]Consolidacion_Madre_nombre:8:="Consolida en mas de 1 asignatura durante todo el año"
				End if 
				  //. ABK NUEVO CODIGO
				
			End if 
			  // como la asignatura consolida sus evaluaciones en otra asignatura pongo en False los campos necesarios
			[Asignaturas:18]IncideEnPromedioInterno:64:=False:C215
			[Asignaturas:18]Incide_en_promedio:27:=False:C215
			[Asignaturas:18]Incide_en_Asistencia:45:=False:C215
			[Asignaturas:18]Incluida_en_Actas:44:=False:C215
			SAVE RECORD:C53([Asignaturas:18])
			
			  // busco  evaluaciones registradas en la asignatura de origen (source)
			SET QUERY DESTINATION:C396(Into variable:K19:4;$l_RegistrosEvaluados)
			SET QUERY LIMIT:C395(1)
			QUERY:C277([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]ID_Asignatura:5;=;$l_IdAsignaturaHija;*)
			QUERY:C277([Alumnos_Calificaciones:208]; & [Alumnos_Calificaciones:208]P01_Final_Real:112>=vrNTA_MinimoEscalaReferencia;*)
			QUERY:C277([Alumnos_Calificaciones:208]; & [Alumnos_Calificaciones:208]P02_Final_Real:187>=vrNTA_MinimoEscalaReferencia;*)
			QUERY:C277([Alumnos_Calificaciones:208]; & [Alumnos_Calificaciones:208]P03_Final_Real:262>=vrNTA_MinimoEscalaReferencia;*)
			QUERY:C277([Alumnos_Calificaciones:208]; & [Alumnos_Calificaciones:208]P04_Final_Real:337>=vrNTA_MinimoEscalaReferencia;*)
			QUERY:C277([Alumnos_Calificaciones:208]; & [Alumnos_Calificaciones:208]P05_Final_Real:412>=vrNTA_MinimoEscalaReferencia)
			SET QUERY DESTINATION:C396(Into current selection:K19:1)
			SET QUERY LIMIT:C395(0)
			
			  // si hay registros de evaluaci—n pongo vbRecalcPromedios en true para el recalculo de promedios en la asignatura madre
			vbRecalcPromedios:=($l_RegistrosEvaluados>0)
			
		Else 
			$b_cancelTrans:=True:C214
		End if 
		
	: ($l_IdAsignaturaHija<0)
		
		  // manejo de subasignaturas
		If (Not:C34(vb_CsdVariable))
			QUERY:C277([xxSTR_Subasignaturas:83];[xxSTR_Subasignaturas:83]ID_Mother:6=$l_IdAsignaturaMadre;*)
			QUERY:C277([xxSTR_Subasignaturas:83]; & [xxSTR_Subasignaturas:83]Name:2=atAS_EvalPropSourceName{vRow})
			ARRAY LONGINT:C221($al_LongintArray;Records in selection:C76([xxSTR_Subasignaturas:83]))
			AT_Populate (->$al_LongintArray;->$l_numeroColumna)
			OK:=KRL_Array2Selection (->$al_LongintArray;->[xxSTR_Subasignaturas:83]Columna:13)
			If (OK=0)
				$b_cancelTrans:=True:C214
			End if 
		Else 
			$l_Periodo:=Num:C11($t_Periodo)
			$t_ReferenciaSubasignatura:=String:C10($l_IdAsignaturaMadre)+"."+$t_Periodo+"."+String:C10($l_numeroColumna)
			$l_recNum:=Find in field:C653([xxSTR_Subasignaturas:83]Referencia:11;$t_ReferenciaSubasignatura)
			If ($l_recNum<0)
				READ WRITE:C146([xxSTR_Subasignaturas:83])
				QUERY:C277([xxSTR_Subasignaturas:83];[xxSTR_Subasignaturas:83]ID_Mother:6=$l_IdAsignaturaMadre;*)
				QUERY:C277([xxSTR_Subasignaturas:83]; & [xxSTR_Subasignaturas:83]Periodo:12=$l_Periodo;*)
				QUERY:C277([xxSTR_Subasignaturas:83]; & [xxSTR_Subasignaturas:83]Name:2=atAS_EvalPropSourceName{vRow})
				
				If ([xxSTR_Subasignaturas:83]Columna:13=0)
					[xxSTR_Subasignaturas:83]Columna:13:=$l_numeroColumna
					SAVE RECORD:C53([xxSTR_Subasignaturas:83])
				End if 
				$t_ReferenciaSubasignatura:=String:C10($l_IdAsignaturaMadre)+"."+$t_Periodo+"."+String:C10($l_numeroColumna)
				$l_recNum:=Find in field:C653([xxSTR_Subasignaturas:83]Referencia:11;$t_ReferenciaSubasignatura)
			End if 
			If ($l_recNum>=0)
				KRL_GotoRecord (->[xxSTR_Subasignaturas:83];$l_recNum;True:C214)
				[xxSTR_Subasignaturas:83]ID_Mother:6:=lConsID
				[xxSTR_Subasignaturas:83]Periodo:12:=$l_Periodo
				[xxSTR_Subasignaturas:83]Columna:13:=$l_numeroColumna
				SAVE RECORD:C53([xxSTR_Subasignaturas:83])
				UNLOAD RECORD:C212([xxSTR_Subasignaturas:83])
			Else 
				$b_cancelTrans:=True:C214
			End if 
		End if 
End case 
READ ONLY:C145([Asignaturas:18])
$0:=$b_cancelTrans
  //END OF METHOD
