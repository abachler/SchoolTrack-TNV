AL_UpdateArrays (xALP_BashVariables;0)
vPtrBash_Tipos:=->atBash_TiposArreglos
vtBash_Tipo:=atBash_TiposArreglos{1}
vlBash_Pool:=<>vlBash_SizeofPool
<>abBash_TrackTextAr{0}:=False:C215
vlBash_Disponibles:=AT_SearchArray (-><>abBash_TrackTextAr;"=")
vlBash_Utilizadas:=Size of array:C274(<>abBash_TrackTextAr)-vlBash_Disponibles
ARRAY TEXT:C222(aNames;0)
ARRAY TEXT:C222(aNames;<>vlBash_SizeofPool)
For ($i;1;<>vlBash_SizeofPool)
	aNames{$i}:="<>atBash_DSS"+String:C10($i)
End for 
ARRAY BOOLEAN:C223(aState;0)
ARRAY BOOLEAN:C223(aState;<>vlBash_SizeofPool)
ARRAY TEXT:C222(aProcess;0)
ARRAY TEXT:C222(aProcess;<>vlBash_SizeofPool)
ARRAY LONGINT:C221(aProcessID;0)
ARRAY LONGINT:C221(aProcessID;<>vlBash_SizeofPool)
COPY ARRAY:C226(<>abBash_TrackTextAr;aState)
COPY ARRAY:C226(<>atBash_TrackLPN4TextAr;aProcess)
COPY ARRAY:C226(<>alBash_TrackLP4TextAr;aProcessID)
AL_UpdateArrays (xALP_BashVariables;-2)