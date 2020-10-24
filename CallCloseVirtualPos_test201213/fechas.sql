set feedback off pages 0
set lin 5000
variable outputvar REFCURSOR;
begin
	PKG_Conciliation_postpago.SP_FECHASSIR ( :outputvar );
end;
/
print :outputvar
EXIT