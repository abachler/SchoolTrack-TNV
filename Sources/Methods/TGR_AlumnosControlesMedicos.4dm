//%attributes = {}
  // Método: TGR_AlumnosControlesMedicos
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 31/05/10, 09:58:25
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones
C_BOOLEAN:C305(<>vb_AvoidTriggerExecution)

  // Código principal
If (Not:C34(<>vb_ImportHistoricos_STX))
	If (Not:C34(<>vb_AvoidTriggerExecution))
		
		Case of 
			: (Trigger event:C369=On Saving New Record Event:K3:1)
				[Alumnos_ControlesMedicos:99]ID:9:=SQ_SeqNumber (->[Alumnos_ControlesMedicos:99]ID:9)
				If (([Alumnos_ControlesMedicos:99]Peso_kg:6>0) & ([Alumnos_ControlesMedicos:99]Talla_cm:5>0))
					  //$size2:=([Alumnos_ControlesMedicos]Talla_cm/100)*([Alumnos_ControlesMedicos]Talla_cm/100)
					  //$imc:=Round([Alumnos_ControlesMedicos]Peso_kg/$size2;1)
					  //Case of 
					  //: ($imc<20)
					  //[Alumnos_ControlesMedicos]IMC:=String($imc)+": Bajo Peso Normal"
					  //: ($imc<24,9)
					  //[Alumnos_ControlesMedicos]IMC:=String($imc)+": Normal"
					  //: ($imc<29,9)
					  //[Alumnos_ControlesMedicos]IMC:=String($imc)+": Sobrepeso"
					  //Else 
					  //[Alumnos_ControlesMedicos]IMC:=String($imc)+": Obsesidad"
					  //End case 
				Else 
					[Alumnos_ControlesMedicos:99]IMC:8:=""
				End if 
				
			: (Trigger event:C369=On Saving Existing Record Event:K3:2)
				If (([Alumnos_ControlesMedicos:99]Peso_kg:6>0) & ([Alumnos_ControlesMedicos:99]Talla_cm:5>0))
					  //$size2:=([Alumnos_ControlesMedicos]Talla_cm/100)*([Alumnos_ControlesMedicos]Talla_cm/100)
					  //$imc:=Round([Alumnos_ControlesMedicos]Peso_kg/$size2;1)
					  //Case of 
					  //: ($imc<20)
					  //[Alumnos_ControlesMedicos]IMC:=String($imc)+": Bajo Peso Normal"
					  //: ($imc<24,9)
					  //[Alumnos_ControlesMedicos]IMC:=String($imc)+": Normal"
					  //: ($imc<29,9)
					  //[Alumnos_ControlesMedicos]IMC:=String($imc)+": Sobrepeso"
					  //Else 
					  //[Alumnos_ControlesMedicos]IMC:=String($imc)+": Obsesidad"
					  //End case 
				Else 
					[Alumnos_ControlesMedicos:99]IMC:8:=""
				End if 
				
			: (Trigger event:C369=On Deleting Record Event:K3:3)
				
		End case 
		
	End if 
	SN3_MarcarRegistros (SN3_DTi_Salud;SN3_SDTx_ControlesMedicos)
End if 


