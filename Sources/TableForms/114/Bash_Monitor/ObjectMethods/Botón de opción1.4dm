AL_UpdateArrays (xALP_BashVariables;0)
vPtrBash_Tipos:=->atBash_TiposVariables
vtBash_Tipo:=atBash_TiposVariables{1}
vlBash_Pool:=<>vlBash_SizeofPool
<>abBash_TrackTextVar{0}:=False:C215
vlBash_Disponibles:=AT_SearchArray (-><>abBash_TrackTextVar;"=")
vlBash_Utilizadas:=Size of array:C274(<>abBash_TrackTextVar)-vlBash_Disponibles
ARRAY TEXT:C222(aNames;0)
ARRAY TEXT:C222(aNames;<>vlBash_SizeofPool)
For ($i;1;<>vlBash_SizeofPool)
	aNames{$i}:="<>vtBash_DSS"+String:C10($i)
End for 
ARRAY BOOLEAN:C223(aState;0)
ARRAY BOOLEAN:C223(aState;<>vlBash_SizeofPool)
ARRAY TEXT:C222(aProcess;0)
ARRAY TEXT:C222(aProcess;<>vlBash_SizeofPool)
ARRAY LONGINT:C221(aProcessID;0)
ARRAY LONGINT:C221(aProcessID;<>vlBash_SizeofPool)
COPY ARRAY:C226(<>abBash_TrackTextVar;aState)
COPY ARRAY:C226(<>atBash_TrackLPN4TextVar;aProcess)
COPY ARRAY:C226(<>alBash_TrackLP4TextVar;aProcessID)
AL_UpdateArrays (xALP_BashVariables;-2)