  //[Asignaturas].TextoObjetivos

Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		vt_CuadroTextoObj:=vt_ObjAlumnoSeleccionadoAL
		vl_IDAlumnoseleccionadoAL:=aNtaIDAlumno{vl_rowseleccionAL}
		vt_ObjAlumnoSeleccionadoAL:=aNtaObj{vl_rowseleccionAL}
		vt_NombreAlumnoSeleccionadoAL:=__ ("Objetivos en ")+sPeriodo+__ (" para ")+aNtaStdNme{vl_rowseleccionAL}
		vp_FotografiaAlumno:=aFotografias{vl_rowseleccionAL}
		
		IT_SetButtonState (True:C214;->bFirst;->bPrev;->bLast;->bNext)
		Case of 
			: (Size of array:C274(aNtaObj)=0)
				IT_SetButtonState (False:C215;->bFirst;->bPrev;->bLast;->bNext)
			: (Size of array:C274(aNtaObj)=1)
				IT_SetButtonState (False:C215;->bFirst;->bPrev;->bLast;->bNext)
			: (vl_rowseleccionAL=1)
				_O_DISABLE BUTTON:C193(bFirst)
				_O_DISABLE BUTTON:C193(bPrev)
			: (vl_rowseleccionAL=Size of array:C274(aNtaObj))
				_O_DISABLE BUTTON:C193(bLast)
				_O_DISABLE BUTTON:C193(bNext)
		End case 
		If (<>vb_BloquearModifSituacionFinal)
			OBJECT SET ENTERABLE:C238(vt_CuadroTextoObj;False:C215)
			_O_DISABLE BUTTON:C193(bGuardar)
			OBJECT SET VISIBLE:C603(*;"bloqueoRegistro@";True:C214)
		Else 
			OBJECT SET VISIBLE:C603(*;"bloqueoRegistro@";False:C215)
		End if 
		
	: (Form event:C388=On Clicked:K2:4)
		Case of 
			: (Size of array:C274(aNtaObj)=0)
				IT_SetButtonState (False:C215;->bFirst;->bPrev;->bLast;->bNext)
			: (Size of array:C274(aNtaObj)=1)
				IT_SetButtonState (False:C215;->bFirst;->bPrev;->bLast;->bNext)
			: (vl_rowseleccionAL=1)
				IT_SetButtonState (True:C214;->bFirst;->bPrev;->bLast;->bNext)
				_O_DISABLE BUTTON:C193(bFirst)
				_O_DISABLE BUTTON:C193(bPrev)
			: (vl_rowseleccionAL=Size of array:C274(aNtaObs))
				IT_SetButtonState (True:C214;->bFirst;->bPrev;->bLast;->bNext)
				_O_DISABLE BUTTON:C193(bLast)
				_O_DISABLE BUTTON:C193(bNext)
			Else 
				IT_SetButtonState (True:C214;->bFirst;->bPrev;->bLast;->bNext)
		End case 
		GOTO OBJECT:C206(vt_CuadroTextoObj)
		HIGHLIGHT TEXT:C210(vt_CuadroTextoObj;Length:C16(vt_CuadroTextoObj)+1;Length:C16(vt_CuadroTextoObj)+1)
		
	: (Form event:C388=On Data Change:K2:15)
		Spell_CheckSpelling 
		
End case 