Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		vt_CuadroTextoObs:=vt_ObsAlumnoSeleccionadoAL
		vl_IDAlumnoseleccionadoAL:=aNtaIDAlumno{vl_rowseleccionAL}
		vt_ObsAlumnoSeleccionadoAL:=aNtaObs{vl_rowseleccionAL}
		vt_NombreAlumnoSeleccionadoAL:=__ ("Observaciones en ")+vt_periodo+__ (" para ")+aNtaStdNme{vl_rowseleccionAL}
		vp_FotografiaAlumno:=aFotografias{vl_rowseleccionAL}
		vt_CuadroTextoObj:=vt_ObjAlumnoSeleccionadoAL
		
		IT_SetButtonState (True:C214;->bFirst;->bPrev;->bLast;->bNext)
		Case of 
			: (Size of array:C274(aNtaObs)=0)
				IT_SetButtonState (False:C215;->bFirst;->bPrev;->bLast;->bNext)
			: (Size of array:C274(aNtaObs)=1)
				IT_SetButtonState (False:C215;->bFirst;->bPrev;->bLast;->bNext)
			: (vl_rowseleccionAL=1)
				_O_DISABLE BUTTON:C193(bFirst)
				_O_DISABLE BUTTON:C193(bPrev)
			: (vl_rowseleccionAL=Size of array:C274(aNtaObs))
				_O_DISABLE BUTTON:C193(bLast)
				_O_DISABLE BUTTON:C193(bNext)
		End case 
		If (<>vb_BloquearModifSituacionFinal)
			OBJECT SET ENTERABLE:C238(vt_CuadroTextoObs;False:C215)
			_O_DISABLE BUTTON:C193(bGuardar)
			OBJECT SET VISIBLE:C603(*;"bloqueoRegistro@";True:C214)
		Else 
			OBJECT SET VISIBLE:C603(*;"bloqueoRegistro@";False:C215)
		End if 
		
		  //Objetivos
		If ([Asignaturas:18]ObjetivosxAlumno:112)
			If ((USR_IsGroupMember_by_GrpID (-15001)) | (USR_checkRights ("M";->[Asignaturas_Objetivos:104])))
				OBJECT SET ENTERABLE:C238(*;"vt_CuadroTextoObj";True:C214)
			Else 
				OBJECT SET ENTERABLE:C238(*;"vt_CuadroTextoObj";False:C215)
			End if 
			WDW_AdjustWindowSize (480;470;10)
			OBJECT MOVE:C664(*;"Texto";0;160)
			OBJECT MOVE:C664(*;"Variable@";0;160)
			OBJECT MOVE:C664(*;"Botón@";0;160)
			OBJECT MOVE:C664(*;"vt_cuadrotextoObs";0;160)
			OBJECT MOVE:C664(*;"bloqueoRegistro2";0;160)
			
			OBJECT MOVE:C664(*;"obj_Texto";-500;0)
			OBJECT MOVE:C664(*;"vt_CuadroTextoObj";-500;0)
			
		End if 
		
	: (Form event:C388=On Clicked:K2:4)
		Case of 
			: (Size of array:C274(aNtaObs)=0)
				IT_SetButtonState (False:C215;->bFirst;->bPrev;->bLast;->bNext)
			: (Size of array:C274(aNtaObs)=1)
				IT_SetButtonState (False:C215;->bFirst;->bPrev;->bLast;->bNext)
			: (vl_rowseleccionAL=1)
				_O_DISABLE BUTTON:C193(bFirst)
				_O_DISABLE BUTTON:C193(bPrev)
				If (vl_rowseleccionAL<Size of array:C274(aNtaObs))
					_O_ENABLE BUTTON:C192(bLast)
					_O_ENABLE BUTTON:C192(bNext)
				End if 
			: (vl_rowseleccionAL=Size of array:C274(aNtaObs))
				_O_DISABLE BUTTON:C193(bLast)
				_O_DISABLE BUTTON:C193(bNext)
				If (vl_rowseleccionAL>1)
					_O_ENABLE BUTTON:C192(bFirst)
					_O_ENABLE BUTTON:C192(bPrev)
				End if 
			Else 
				_O_ENABLE BUTTON:C192(bLast)
				_O_ENABLE BUTTON:C192(bNext)
				_O_ENABLE BUTTON:C192(bFirst)
				_O_ENABLE BUTTON:C192(bPrev)
		End case 
		GOTO OBJECT:C206(vt_CuadroTextoObs)
		HIGHLIGHT TEXT:C210(vt_CuadroTextoObs;Length:C16(vt_CuadroTextoObs)+1;Length:C16(vt_CuadroTextoObs)+1)
End case 