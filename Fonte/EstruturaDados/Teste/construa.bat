@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul

:: Definir array de funções válidas
set funcao[0]=definicoesConvencional
set funcao[1]=limpar
set funcao_count=1

:: Verifica se foi passado um argumento
if "%~1"=="" (
    echo Digite ./construa + opcao
    echo Opções disponíveis: tudo, limpar, definicoesConvencional
    goto :EOF
)

:: Argumento passado
set "opcao=%~1"
set "opcaoValida=N"

:: Se a opção for "tudo", executa todas as funções do array
if /i "%opcao%"=="tudo" (
    set "opcaoValida=S"
    echo Executando todas as funções...
    for /L %%i in (0,1,%funcao_count%) do (
        set "funcName=!funcao[%%i]!"
        call :!funcName!
        echo.
    )
    goto :EOF
)

:: Verifica se a opção é válida e chama a função correspondente
for /L %%i in (0,1,%funcao_count%) do (
    if /i "%opcao%"=="!funcao[%%i]!" (
        set "opcaoValida=S"
        call :!funcao[%%i]!
        echo.
        goto :EOF
    )
)

:: Se nenhuma opção válida for encontrada
if /i "%opcaoValida%"=="N" (
    echo Opção inválida: %opcao%
    echo Opções válidas:
    for /L %%i in (0,1,%funcao_count%) do (
        echo - !funcao[%%i]!
    )
    goto :EOF
)

:: ================================
:: DEFINIÇÕES DAS FUNÇÕES ABAIXO
:: ================================

:definicoesConvencional
echo Executando definicoesConvencional...
ctec TesteDefinicaoConvencional.ctec -o Executavel\TesteDefinicaoConvencional.exe
Executavel\TesteDefinicaoConvencional.exe
goto :EOF

:limpar
echo Limpando a pasta Executavel...
if exist Executavel (
    del /q Executavel\*
) else (
    echo Pasta Executavel não encontrada.
)
goto :EOF
