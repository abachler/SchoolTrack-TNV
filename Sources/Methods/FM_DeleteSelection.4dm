//%attributes = {}
  //FM_DeleteSelection

C_LONGINT:C283($alumnos;$familias)
$0:=0
If (False:C215)
	  //============================== IDENTIFICACION ==============================
	  // Procédure : fm_Delete
	  //Autor: Alberto Bachler
	  //Creada el 21/8/96 a 8:39 PM
	  //============================== DESCRIPCION ==============================
	  //Package:
	  //Descripción:
	  //Sintaxis:
	  //============================== MODIFICACIONES ==============================
	  //Fecha: 
	  //Autor:
	  //Descripción:
	  // Fecha: 20110518
	  // Autor: RCH
	  //Descripción: Se llama a este metodo para eliminar selecciones de familias, se es
End if 

$r:=CD_Dlog (0;__ ("Desea Ud. realmente eliminar todas las familias seleccionadas?\r(solo serán elimin"+"adas las familias sin alumnos en el colegio)");__ ("");__ ("No");__ ("Eliminar"))
If ($r=2)
	$r:=CD_Dlog (0;"Esta operación es irreversible. ¿Eliminar las familias seleccionadas?";"";"No";"Eliminar")
	If ($r=2)
		$pID:=IT_UThermometer (1;0;__ ("Eliminando familias..."))
		
		ARRAY LONGINT:C221($al_idPersonas;0)
		ARRAY LONGINT:C221($al_recNumFamilias;0)
		
		LONGINT ARRAY FROM SELECTION:C647([Familia:78];$al_recNumFamilias;"")
		
		CREATE EMPTY SET:C140([Personas:7];"setPersonas")
		CREATE EMPTY SET:C140([Familia:78];"setfamilias")
		For ($j;1;Size of array:C274($al_recNumFamilias))
			GOTO RECORD:C242([Familia:78];$al_recNumFamilias{$j})
			SET QUERY DESTINATION:C396(Into variable:K19:4;$alumnos)
			QUERY:C277([Alumnos:2];[Alumnos:2]Familia_Número:24=[Familia:78]Numero:1)
			SET QUERY DESTINATION:C396(0)
			
			If ($alumnos=0)
				ADD TO SET:C119([Familia:78];"setfamilias")
				$recNum:=Record number:C243([Familia:78])
				
				ARRAY LONGINT:C221($al_idPersonas;0)
				READ ONLY:C145([Familia_RelacionesFamiliares:77])
				QUERY:C277([Familia_RelacionesFamiliares:77];[Familia_RelacionesFamiliares:77]ID_Familia:2=[Familia:78]Numero:1;*)
				QUERY:C277([Familia_RelacionesFamiliares:77]; & [Personas:7]No:1#0)
				SELECTION TO ARRAY:C260([Familia_RelacionesFamiliares:77]ID_Persona:3;$al_idPersonas)
				fm_BuscaPersonasAEliminar ("setPersonas";->$al_idPersonas)
			End if 
		End for 
		
		If (Records in set:C195("setfamilias")>0)
			USE SET:C118("setfamilias")
			USE SET:C118("setPersonas")
			START TRANSACTION:C239
			ok:=KRL_DeleteSelection (->[Personas:7])
			If (ok=1)
				KRL_RelateSelection (->[Familia_RelacionesFamiliares:77]ID_Familia:2;->[Familia:78]Numero:1)
				ok:=KRL_DeleteSelection (->[Familia_RelacionesFamiliares:77])
				If (ok=1)
					ok:=KRL_DeleteSelection (->[Familia:78])
				End if 
			End if 
			If (ok=1)
				VALIDATE TRANSACTION:C240
				$0:=1
			Else 
				CANCEL TRANSACTION:C241
			End if 
			KRL_UnloadReadOnly (->[Personas:7])
			KRL_UnloadReadOnly (->[Familia:78])
			KRL_UnloadReadOnly (->[Familia_RelacionesFamiliares:77])
		End if 
		$pID:=IT_UThermometer (-2;$pID)
	End if 
End if 


