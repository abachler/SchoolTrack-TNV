//%attributes = {}
  //AL_isNotLate

If (DateIsValid ($1))
	$0:=AL_isNotAbsent ($1)
	If ($0#!00-00-00!)
		If ((aCdtaBoolean1{vRow}=False:C215) & (aCdtaBoolean1{0}=True:C214) & (<>aCdtaDate{vRow}#<>aCdtaDate{0}))
			QUERY:C277([Alumnos_Atrasos:55];[Alumnos_Atrasos:55]Alumno_numero:1=[Alumnos:2]numero:1)
			QUERY SELECTION:C341([Alumnos_Atrasos:55];[Alumnos_Atrasos:55]Fecha:2=$1;*)
			QUERY SELECTION:C341([Alumnos_Atrasos:55]; & ;[Alumnos_Atrasos:55]EsAtrasoInterSesiones:4=False:C215)
			Case of 
				: (Records in selection:C76([Alumnos_Atrasos:55])=0)
					$0:=$1
				: ((Records in selection:C76([Alumnos_Atrasos:55])>0) & (<>gAllowMultipleLates=1))
					$0:=$1
					aCdtaBoolean1{vRow}:=True:C214
				Else 
					CD_Dlog (0;[Alumnos:2]apellidos_y_nombres:40+__ (" ya tiene atraso registrado en esta fecha."))
					$0:=!00-00-00!
			End case 
		End if 
	End if 
Else 
	$0:=!00-00-00!
End if 