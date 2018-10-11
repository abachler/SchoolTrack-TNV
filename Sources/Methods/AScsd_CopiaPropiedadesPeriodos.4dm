//%attributes = {}
  // MÉTODO: `AScsd_CopiaPropiedadesPeriodos
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 28/12/11, 18:22:07
  // ----------------------------------------------------
  // DESCRIPCIÓN
  //
  //
  // PARÁMETROS
  // AScsd_SetSources()
  // ----------------------------------------------------
C_BOOLEAN:C305($0)
C_LONGINT:C283($1)
C_TEXT:C284($2)

C_BOOLEAN:C305($b_cancelarTransaccion)
C_LONGINT:C283($i;$iPeriodos;$j;$l_IdAsignaturaMadre)
C_TEXT:C284($t_llaveSubAsignatura;$t_llaveSubAsignatura;$t_NombreAsignaturaHija;$t_Periodo)

If (False:C215)
	C_BOOLEAN:C305(AScsd_CopiaPropiedadesPeriodos ;$0)
	C_LONGINT:C283(AScsd_CopiaPropiedadesPeriodos ;$1)
	C_TEXT:C284(AScsd_CopiaPropiedadesPeriodos ;$2)
End if 

  // CODIGO PRINCIPAL

  //DECLARATIONS

  //INITIALIZATION
$l_IdAsignaturaMadre:=$1
$t_NombreAsignaturaHija:=$2
$0:=False:C215
$b_cancelarTransaccion:=False:C215

  //MAIN CODE
READ WRITE:C146([Asignaturas:18])
For ($i;1;Size of array:C274(alAS_EvalPropSourceID))
	Case of 
		: (alAS_EvalPropSourceID{$i}>0)
			QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero:1=alAS_EvalPropSourceID{$i})
			If (Not:C34(KRL_IsRecordLocked (->[Asignaturas:18])))
				If (vb_CsdVariable)  //si la consolidación es variable para cada período
					
					  //se crean las referencias de consolidación en todos los períodos
					For ($j;1;Size of array:C274(aiSTR_Periodos_Numero))
						$t_Periodo:=String:C10(aiSTR_Periodos_Numero{$j})
						
						  // busco y elimino las eventuales referencias de consolidación que podían existir
						AScsd_LeeReferencias ([Asignaturas:18]Numero:1)
						QUERY SELECTION:C341([Asignaturas_Consolidantes:231];[Asignaturas_Consolidantes:231]Periodo:3;=;$t_Periodo;*)
						QUERY SELECTION:C341([Asignaturas_Consolidantes:231]; | ;[Asignaturas_Consolidantes:231]Periodo:3;="0";*)
						QUERY SELECTION:C341([Asignaturas_Consolidantes:231]; | ;[Asignaturas_Consolidantes:231]Periodo:3;="")
						KRL_DeleteSelection (->[Asignaturas_Consolidantes:231])
						
						  // creo la nueva referencia de consolidación
						CREATE RECORD:C68([Asignaturas_Consolidantes:231])
						[Asignaturas_Consolidantes:231]ID_ParentRecord:5:=alAS_EvalPropSourceID{$i}
						[Asignaturas_Consolidantes:231]ID_AsignaturaMadre:1:=$l_IdAsignaturaMadre
						[Asignaturas_Consolidantes:231]Name:2:=$t_NombreAsignaturaHija
						[Asignaturas_Consolidantes:231]Periodo:3:=$t_Periodo
						SAVE RECORD:C53([Asignaturas_Consolidantes:231])
						
					End for 
					
					  //se marca como consolidable por periodo
					[Asignaturas:18]Consolidacion_Madre_Id:7:=-1
					[Asignaturas:18]Consolidacion_Madre_nombre:8:="Varía según período"
					
				Else 
					  // elimino las eventuales referencias de consolidación que podían existir
					AScsd_EliminaReferencias ([Asignaturas:18]Numero:1)
					
					  // creo la nueva referencia de consolidación
					CREATE RECORD:C68([Asignaturas_Consolidantes:231])
					[Asignaturas_Consolidantes:231]ID_ParentRecord:5:=alAS_EvalPropSourceID{$i}
					[Asignaturas_Consolidantes:231]ID_AsignaturaMadre:1:=$l_IdAsignaturaMadre
					[Asignaturas_Consolidantes:231]Name:2:=$t_NombreAsignaturaHija
					[Asignaturas_Consolidantes:231]Periodo:3:=$t_Periodo
					SAVE RECORD:C53([Asignaturas_Consolidantes:231])
					
					[Asignaturas:18]Consolidacion_Madre_Id:7:=$l_IdAsignaturaMadre  //se inscribe el id de la asignatura madre (única)
					[Asignaturas:18]Consolidacion_Madre_nombre:8:=$t_NombreAsignaturaHija  //se inscribe el nombre de la consolidante (única)  
					
				End if 
				[Asignaturas:18]Incide_en_promedio:27:=False:C215
				[Asignaturas:18]Incluida_en_Actas:44:=False:C215
				SAVE RECORD:C53([Asignaturas:18])
				UNLOAD RECORD:C212([Asignaturas:18])
			Else 
				$i:=Size of array:C274(alAS_EvalPropSourceID)
				$b_cancelarTransaccion:=True:C214
			End if 
			
		: (alAS_EvalPropSourceID{$i}<0)
			
			For ($iPeriodos;1;Size of array:C274(atSTR_Periodos_Nombre))
				READ WRITE:C146([xxSTR_Subasignaturas:83])
				$t_llaveSubAsignatura:=String:C10(lConsID)+"."+String:C10($iPeriodos)+"."+String:C10($i)
				QUERY:C277([xxSTR_Subasignaturas:83];[xxSTR_Subasignaturas:83]Referencia:11=$t_llaveSubAsignatura)
				
				If (Records in selection:C76([xxSTR_Subasignaturas:83])=0)
					$t_llaveSubAsignatura:=String:C10(lConsID)+"."+String:C10($iPeriodos)+".0"
					QUERY:C277([xxSTR_Subasignaturas:83];[xxSTR_Subasignaturas:83]Referencia:11=$t_llaveSubAsignatura)
				End if 
				
				If (Records in selection:C76([xxSTR_Subasignaturas:83])=0)
					CREATE RECORD:C68([xxSTR_Subasignaturas:83])
					[xxSTR_Subasignaturas:83]LongID:7:=-Abs:C99([xxSTR_Subasignaturas:83]ID_Mother:6)
				End if 
				[xxSTR_Subasignaturas:83]ID_Mother:6:=lConsID
				[xxSTR_Subasignaturas:83]Periodo:12:=$iPeriodos
				[xxSTR_Subasignaturas:83]Columna:13:=$i
				[xxSTR_Subasignaturas:83]Name:2:=atAS_EvalPropSourceName{$i}
				SAVE RECORD:C53([xxSTR_Subasignaturas:83])
				UNLOAD RECORD:C212([xxSTR_Subasignaturas:83])
				READ ONLY:C145([xxSTR_Subasignaturas:83])
			End for 
			
	End case 
	
End for 
READ ONLY:C145([Asignaturas:18])
$0:=$b_cancelarTransaccion
  //END OF METHOD
