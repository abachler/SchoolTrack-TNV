Case of 
	: (Form event:C388=On Clicked:K2:4)
		C_LONGINT:C283($ref)
		C_TEXT:C284($text)
		GET LIST ITEM:C378(*;"sige_opc";Selected list items:C379(*;"sige_opc");$ref;$text)
		$lineas_visibles_por_linea:=2
		
		If (($ref>0) & ($ref#vl_CurrentTab))
			
			  //  //limpieza de los arrays de despliegue
			Case of 
				: (vl_CurrentTab=1)
					
					  ////controlado por la ultima fecha de consulta
					  //ARRAY TEXT(at_alumno;0)
					  //ARRAY TEXT(at_cur;0)
					  //ARRAY TEXT(at_problema_alu;0)
					
				: (vl_CurrentTab=2)
					ARRAY TEXT:C222(at_CodTipoEns_P;0)
					ARRAY TEXT:C222(at_RolBD_P;0)
					ARRAY TEXT:C222(at_detalle_P;0)
					
				: (vl_CurrentTab=3)
					ARRAY TEXT:C222(at_curso_P;0)
					ARRAY TEXT:C222(at_cod_ejec_curso_P;0)
					
				: (vl_CurrentTab=4)
					
			End case 
			
			  //set de objetos de la pagina del formaulario
			Case of 
				: ($ref=1)
					ta_1:=1
					ta_2:=0
					OBJECT SET ENABLED:C1123(*;"bti_blockAL";True:C214)
					
				: ($ref=2)
					te_1:=1
					te_2:=0
					OBJECT SET ENABLED:C1123(*;"bti_blockAL";True:C214)
					
				: ($ref=3)
					cu_1:=1
					cu_2:=0
					OBJECT SET ENABLED:C1123(*;"bti_blockAL";True:C214)
					
				: ($ref=4)
					
					pc_1:=1
					pc_2:=0
					opt1:=1
					opt2:=0
					opt3:=0
					OBJECT SET VISIBLE:C603(pc_1;True:C214)
					OBJECT SET VISIBLE:C603(pc_2;True:C214)
					OBJECT SET VISIBLE:C603(*;"Texto_dias";False:C215)
					OBJECT SET VISIBLE:C603(*;"Texto_mes";True:C214)
					OBJECT SET VISIBLE:C603(*;"btn_enviar_asist";True:C214)
					
					OBJECT SET VISIBLE:C603(*;"Nivel_txt";False:C215)
					OBJECT SET VISIBLE:C603(*;"vt_nivel";False:C215)
					OBJECT SET VISIBLE:C603(*;"btni_nivel";False:C215)
					OBJECT SET VISIBLE:C603(*;"pic_triangulo_nivel";False:C215)
					
					OBJECT SET TITLE:C194(*;"btn_enviar_asist";"Enviar Asistencias")
					OBJECT SET ENABLED:C1123(*;"bti_blockAL";True:C214)
					
			End case 
			
			SIGE_LoadDataArrays ($ref;1;vi_MesNum)
			SIGE_LoadDisplayLB ($ref)
			FORM GOTO PAGE:C247($ref)
			
			vl_CurrentTab:=$ref
			
		End if 
		
End case 