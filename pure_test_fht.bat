@echo off

echo.
echo *************************************************************************
echo *		Pure test Fast Hartley transform			*
echo *************************************************************************
echo.

quartus_sh -t script/src.tcl
quartus_sh -t script/fht.tcl -- -cl
quartus_sh -t script/fht.tcl -- --

cd matlab
echo.
matlab -nosplash -nodesktop -r "fht('sin'); quit;"

:BEGIN_INIT
	tasklist /v | findstr /bic:"matlab.exe" >NUL 2>&1 || goto END_INIT
	timeout 5 >NUL
	echo Wait until matlab script will completed...
	goto BEGIN_INIT
:END_INIT

cd..
cd debug
echo.
rem make -f makefile clean
make -f makefile run_but
make -f makefile run_control
make -f makefile run_fht

cd..
cd matlab
echo.
matlab -nosplash -nodesktop -r "fht_analys; quit;"

:BEGIN_ANALYS
	tasklist /v | findstr /bic:"matlab.exe" >NUL 2>&1 || goto END_ANALYS
	timeout 5 >NUL
	echo Wait until matlab script will completed...
	goto BEGIN_ANALYS
:END_ANALYS

cd..
echo.
echo ************************************************************************
echo *				Complete				*
echo ************************************************************************
echo.
@pause