@echo off
REM Local wrapper: prefer project's node_modules binary if present, otherwise fall back to npx
IF EXIST "%~dp0node_modules\.bin\prisma.cmd" (
	CALL "%~dp0node_modules\.bin\prisma.cmd" %*
) ELSE (
	REM Fallback to npx which will resolve to the correct prisma package
	npx prisma %*
)
