Case of 
	: (Form event:C388=On Load:K2:1)
		Case of 
			: (vRefExtraPublication="Calificaciones")
				cbOcultarPeriodo1_1:=cbOcultarPeriodo1
				cbOcultarPeriodo2_1:=cbOcultarPeriodo2
				cbOcultarPeriodo3_1:=cbOcultarPeriodo3
				cbOcultarPeriodo4_1:=cbOcultarPeriodo4
				cbOcultarPeriodo5_1:=cbOcultarPeriodo5
				vdHastaPeriodo1_1:=vdHastaPeriodo1
				vdHastaPeriodo2_1:=vdHastaPeriodo2
				vdHastaPeriodo3_1:=vdHastaPeriodo3
				vdHastaPeriodo4_1:=vdHastaPeriodo4
				vdHastaPeriodo5_1:=vdHastaPeriodo5
			: (vRefExtraPublication="Aprendizajes")
				cbOcultarPeriodo1_1:=cbOcultarPeriodo1_Ap
				cbOcultarPeriodo2_1:=cbOcultarPeriodo2_Ap
				cbOcultarPeriodo3_1:=cbOcultarPeriodo3_Ap
				cbOcultarPeriodo4_1:=cbOcultarPeriodo4_Ap
				cbOcultarPeriodo5_1:=cbOcultarPeriodo5_Ap
				vdHastaPeriodo1_1:=vdHastaPeriodo1_Ap
				vdHastaPeriodo2_1:=vdHastaPeriodo2_Ap
				vdHastaPeriodo3_1:=vdHastaPeriodo3_Ap
				vdHastaPeriodo4_1:=vdHastaPeriodo4_Ap
				vdHastaPeriodo5_1:=vdHastaPeriodo5_Ap
			: (vRefExtraPublication="Observaciones")
				cbOcultarPeriodo1_1:=cbOcultarPeriodo1_Obs
				cbOcultarPeriodo2_1:=cbOcultarPeriodo2_Obs
				cbOcultarPeriodo3_1:=cbOcultarPeriodo3_Obs
				cbOcultarPeriodo4_1:=cbOcultarPeriodo4_Obs
				cbOcultarPeriodo5_1:=cbOcultarPeriodo5_Obs
				vdHastaPeriodo1_1:=vdHastaPeriodo1_Obs
				vdHastaPeriodo2_1:=vdHastaPeriodo2_Obs
				vdHastaPeriodo3_1:=vdHastaPeriodo3_Obs
				vdHastaPeriodo4_1:=vdHastaPeriodo4_Obs
				vdHastaPeriodo5_1:=vdHastaPeriodo5_Obs
		End case 
		GET WINDOW RECT:C443($l;$t;$r;$b)
		$new:=0
		PERIODOS_LoadData (vlSN3_CurrConfigLevel)
		For ($i;1;Size of array:C274(atSTR_Periodos_Nombre))
			$ptr:=Get pointer:C304("vNombrePeriodo"+String:C10($i))
			$ptr->:=atSTR_Periodos_Nombre{$i}
			$ptr:=Get pointer:C304("cbOcultarPeriodo"+String:C10($i))
			OBJECT SET ENTERABLE:C238(*;"periodo"+String:C10($i)+"_3";($ptr->=1))
		End for 
		If (Size of array:C274(atSTR_Periodos_Nombre)<5)
			For ($i;Size of array:C274(atSTR_Periodos_Nombre)+1;5)
				OBJECT SET VISIBLE:C603(*;"periodo"+String:C10($i)+"@";False:C215)
				$new:=$new+23
			End for 
		End if 
		SET WINDOW RECT:C444($l;$t;$r;$b-$new)
		OBJECT MOVE:C664(*;"cerrar@";0;-$new)
	: (Form event:C388=On Unload:K2:2)
		Case of 
			: (vRefExtraPublication="Calificaciones")
				cbOcultarPeriodo1:=cbOcultarPeriodo1_1
				cbOcultarPeriodo2:=cbOcultarPeriodo2_1
				cbOcultarPeriodo3:=cbOcultarPeriodo3_1
				cbOcultarPeriodo4:=cbOcultarPeriodo4_1
				cbOcultarPeriodo5:=cbOcultarPeriodo5_1
				vdHastaPeriodo1:=vdHastaPeriodo1_1
				vdHastaPeriodo2:=vdHastaPeriodo2_1
				vdHastaPeriodo3:=vdHastaPeriodo3_1
				vdHastaPeriodo4:=vdHastaPeriodo4_1
				vdHastaPeriodo5:=vdHastaPeriodo5_1
			: (vRefExtraPublication="Aprendizajes")
				cbOcultarPeriodo1_Ap:=cbOcultarPeriodo1_1
				cbOcultarPeriodo2_Ap:=cbOcultarPeriodo2_1
				cbOcultarPeriodo3_Ap:=cbOcultarPeriodo3_1
				cbOcultarPeriodo4_Ap:=cbOcultarPeriodo4_1
				cbOcultarPeriodo5_Ap:=cbOcultarPeriodo5_1
				vdHastaPeriodo1_Ap:=vdHastaPeriodo1_1
				vdHastaPeriodo2_Ap:=vdHastaPeriodo2_1
				vdHastaPeriodo3_Ap:=vdHastaPeriodo3_1
				vdHastaPeriodo4_Ap:=vdHastaPeriodo4_1
				vdHastaPeriodo5_Ap:=vdHastaPeriodo5_1
			: (vRefExtraPublication="Observaciones")
				cbOcultarPeriodo1_Obs:=cbOcultarPeriodo1_1
				cbOcultarPeriodo2_Obs:=cbOcultarPeriodo2_1
				cbOcultarPeriodo3_Obs:=cbOcultarPeriodo3_1
				cbOcultarPeriodo4_Obs:=cbOcultarPeriodo4_1
				cbOcultarPeriodo5_Obs:=cbOcultarPeriodo5_1
				vdHastaPeriodo1_Obs:=vdHastaPeriodo1_1
				vdHastaPeriodo2_Obs:=vdHastaPeriodo2_1
				vdHastaPeriodo3_Obs:=vdHastaPeriodo3_1
				vdHastaPeriodo4_Obs:=vdHastaPeriodo4_1
				vdHastaPeriodo5_Obs:=vdHastaPeriodo5_1
		End case 
End case 