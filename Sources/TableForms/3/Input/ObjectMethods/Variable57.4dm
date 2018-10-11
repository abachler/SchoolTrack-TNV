If \
(\
False:C215\
)\

	<>ST_v461\
		:=\
		False:C215\
		  //10/8/98 at 16:53:36 by: Alberto Bachler\
		
	  //implementación de bimestres\
		
End if \


If \
(\
atSTR_Periodos_Nombre\
>\
0\
)\

	If \
		(\
		CUv_mEvVal\
		)\
		
		READ WRITE:C146\
			(\
			[Alumnos_EvaluacionValorica:23]\
			)\
			
		USE NAMED SELECTION:C332\
			(\
			"SEL Ntas"\
			)\
			
		ARRAY TO SELECTION:C261\
			(\
			aNtaArrPtr\
			{\
			1\
			}\
			->\
			;\
			aNtaFldPtr\
			{\
			1\
			}\
			->\
			;\
			aNtaArrPtr\
			{\
			2\
			}\
			->\
			;\
			aNtaFldPtr\
			{\
			2\
			}\
			->\
			;\
			aNtaArrPtr\
			{\
			3\
			}\
			->\
			;\
			aNtaFldPtr\
			{\
			3\
			}\
			->\
			;\
			aNtaArrPtr\
			{\
			4\
			}\
			->\
			;\
			aNtaFldPtr\
			{\
			4\
			}\
			->\
			;\
			aNtaArrPtr\
			{\
			5\
			}\
			->\
			;\
			aNtaFldPtr\
			{\
			5\
			}\
			->\
			;\
			aNtaArrPtr\
			{\
			6\
			}\
			->\
			;\
			aNtaFldPtr\
			{\
			6\
			}\
			->\
			)\
			
		READ ONLY:C145\
			(\
			[Alumnos_EvaluacionValorica:23]\
			)\
			
		CUv_mEvVal\
			:=\
			False:C215\
			
	End if \
		
	CU_PgEvValores \
		(\
		atSTR_Periodos_Nombre\
		)\
		
End if \
