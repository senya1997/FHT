@echo off

echo.
echo *************************************************************************
echo *		Full test Fast Hartley transform			*
echo *************************************************************************
echo.

quartus_sh -t script/src.tcl
quartus_sh -t script/fht.tcl -- -cl
quartus_sh -t script/fht.tcl -- --

cd matlab
echo.
matlab -nosplash -nodesktop -r "fht('imp'); quit;"

:BEGIN_IMP
	tasklist /v | findstr /bic:"matlab.exe" >NUL 2>&1 || goto END_IMP
	timeout 5 >NUL
	echo Wait until matlab script will completed...
	goto BEGIN_IMP
:END_IMP

cd..
cd debug
echo.
make -f makefile run_but
make -f makefile run_control
make -f makefile run_fht

cd..
cd matlab
echo.
matlab -nosplash -nodesktop -r "fht('signal'); quit;"

:BEGIN_SIGNAL
	tasklist /v | findstr /bic:"matlab.exe" >NUL 2>&1 || goto END_SIGNAL
	timeout 5 >NUL
	echo Wait until matlab script will completed...
	goto BEGIN_SIGNAL
:END_SIGNAL

cd..
cd debug
echo.
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
echo *************************************************************************
echo *				Complete				*
echo *************************************************************************
echo.
@pause