#  - é um caractere especial produzido apenas na linha de comando precionando
# a sequencia "Ctrl + v" e depois pressione a tecla ESC que produz o caractere
# especial ^[ na linha de comando. para adiciona-lo a um arquivo qualquer é
# necessário usar os comandos citados em um terminal e imprimir a saida gerada
# em um arquivo utilizando o comando echo.
#
# Exemplo:
# echo ' use o comando Ctrl + v" e depois pressione a tecla ESC' > nome_do_arquivo
#
# tambem é possível reproduzir os efeitos de cor utilizando o echo com o -e
# echo -e "\033[0;31;1m texto de exemplo"
ESC=
#CORES DE TEXTO
PRETO="$ESC[30m"
VERMELHO="$ESC[31m"
VERDE="$ESC[32m"
AMARELO="$ESC[33m"
AZUL="$ESC[34m"
MAGENTA="$ESC[35m"
CIANO="$ESC[36m"
BRANCO="$ESC[37m"
#CORES DE FUNDO
_PRETO="$ESC[40m"
_VERMELHO="$ESC[41m"
_VERDE="$ESC[42m"
_AMARELO="$ESC[43m"
_AZUL="$ESC[44m"
_MAGENTA="$ESC[45m"
_CIANO="$ESC[46m"
_BRANCO="$ESC[47m"
#MODOS ANSI
NORMAL="$ESC[0m"
NEGRITO="$ESC[1m"
BAIXA_INTENSID="$ESC[2m"
ITALICO="$ESC[3m"
SUBLINHADO="$ESC[4m"
PISCANDO="$ESC[5m"
PISCA_RAPIDO="$ESC[6m"
INVERSO="$ESC[7m"
INVISIVEL="$ESC[8m"

function imprimirCores {

  echo $PRETO PRETO $NORMAL
  echo $VERMELHO VERMELHO $NORMAL
  echo $VERDE VERDE $NORMAL
  echo $AMARELO AMARELO $NORMAL
  echo $AZUL AZUL $NORMAL
  echo $MAGENTA MAGENTA $NORMAL
  echo $CIANO CIANO $NORMAL
  echo $BRANCO BRANCO $NORMAL
  echo CORES DE FUNDO $NORMAL
  echo $_PRETO _PRETO $NORMAL
  echo $_VERMELHO _VERMELHO $NORMAL
  echo $PRETO $_VERDE _VERDE $NORMAL
  echo $PRETO $_AMARELO _AMARELO $NORMAL
  echo $PRETO $_AZUL _AZUL $NORMAL
  echo $PRETO $_MAGENTA _MAGENTA $NORMAL
  echo $PRETO $_CIANO _CIANO $NORMAL
  echo $PRETO $_BRANCO _BRANCO $NORMAL
  echo MODOS ANSI $NORMAL
  echo $NORMAL NORMAL $NORMAL
  echo $NEGRITO NEGRITO $NORMAL
  echo $BAIXA_INTENSID BAIXA_INTENSID $NORMAL
  echo $ITALICO ITALICO $NORMAL
  echo $SUBLINHADO SUBLINHADO $NORMAL
  echo $PISCANDO PISCANDO $NORMAL
  echo $PISCA_RAPIDO PISCA_RAPIDO $NORMAL
  echo $INVERSO INVERSO $NORMAL
  echo $INVISIVEL INVISIVEL $NORMAL

}
