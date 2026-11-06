#!/usr/bin/env bash
# Reorganiza o GitHub do CertChain em 3 etapas e 3 frentes.
#
#   bash scripts/reorganizar-github.sh             mostra o que faria (não muda nada)
#   APLICAR=1 bash scripts/reorganizar-github.sh   aplica de verdade
#
# Requer o gh autenticado (gh auth status).
# Não fecha, não apaga e não reescreve nenhuma entrega.
# Pode rodar mais de uma vez: pula o que já existe.
# Depois de aplicar, confira se as tarefas novas entraram no Project.

set -euo pipefail

R="Minervas-Blockchain/CertChain-UFRJ"
APLICAR="${APLICAR:-0}"

if [ "$APLICAR" = "1" ]; then
  echo "MODO: aplicando"
else
  echo "MODO: simulação (nada muda). Use APLICAR=1 para aplicar."
fi
echo

executa() {
  if [ "$APLICAR" = "1" ]; then
    "$@" > /dev/null
  fi
}

TITULOS="$(gh issue list --repo "$R" --state all --limit 300 --json title --jq '.[].title')"

existe() {
  case $'\n'"$TITULOS"$'\n' in
    *$'\n'"$1"$'\n'*) return 0 ;;
    *) return 1 ;;
  esac
}

tem_comentario() {
  local corpo
  corpo="$(gh issue view "$1" --repo "$R" --json comments --jq '.comments[].body')"
  case "$corpo" in
    *"Estado em 06/11"*) return 0 ;;
    *) return 1 ;;
  esac
}

# ---------------------------------------------------------------- etiquetas
echo "== Etiquetas"
rotulo() {
  echo "etiqueta: $1"
  executa gh label create "$1" --repo "$R" --color "$2" --description "$3" --force
}
rotulo "frente:codigo"   "0B7D70" "Contrato, credencial, comandos e página de verificação"
rotulo "frente:telas"    "7B4FB0" "Como as pessoas usam, sem saber que existe blockchain"
rotulo "frente:pesquisa" "9C6410" "O que já existe e como é hoje a emissão na UFRJ (inclui entrevistas)"
rotulo "tamanho:P"       "C5DEF5" "Até 2 horas"
rotulo "tamanho:M"       "5319E7" "Até 5 horas"
rotulo "se-sobrar-tempo" "FBCA04" "Fora da meta de 11/12; só se houver tempo"
echo

# ------------------------------------------------------------------ etapas
echo "== Etapas (milestones)"
numero_marco() {
  gh api "repos/$R/milestones?state=all&per_page=100" --jq ".[] | select(.title==\"$1\") | .number"
}
renomeia_marco() {
  local n
  n="$(numero_marco "$1")"
  if [ -z "$n" ]; then
    echo "etapa '$1': não encontrada (talvez já renomeada)"
    return 0
  fi
  echo "etapa #$n: '$1' -> '$2' (até $3)"
  executa gh api -X PATCH "repos/$R/milestones/$n" -f title="$2" -f due_on="${3}T12:00:00Z" -f description="$4"
}
renomeia_marco "M0 · Escopo congelado"   "1 · Decidido"          "2026-11-13" "Stack, folha Merkle e Registry definidos."
renomeia_marco "M1 · Vertical slice"     "2 · Roda no terminal"  "2026-11-27" "Emitir e verificar um certificado por comando, ao vivo."
renomeia_marco "M2 · Emissão utilizável" "3 · Roda no celular"   "2026-12-11" "Demo Day: página pública + QR, o certificado aparece como VÁLIDO."
n="$(numero_marco "Demo Day")"
if [ -n "$n" ]; then
  echo "etapa #$n 'Demo Day': fechar (agora é a etapa 3)"
  executa gh api -X PATCH "repos/$R/milestones/$n" -f state=closed
fi
echo

# ------------------------------------------------- tarefas que já existem
echo "== Tarefas existentes (novo nome, etapa e estado atual; nada é fechado)"
ajusta() { # numero  novo_titulo  etapa  etiqueta  comentario
  echo "tarefa #$1: $2  [$3]"
  executa gh issue edit "$1" --repo "$R" --title "$2" --milestone "$3" --add-label "$4"
  if tem_comentario "$1"; then
    echo "   (comentário de estado já existe)"
  else
    executa gh issue comment "$1" --repo "$R" --body "$5"
  fi
}
E1="1 · Decidido"; E2="2 · Roda no terminal"; E3="3 · Roda no celular"

ajusta 3  "Código · ADR-002 Modelo de ancoragem e interface do Registry" "$E1" "frente:codigo" \
"Estado em 06/11: o ADR-002 está escrito (keccak256, ancoragem em lote). Falta para fechar: a seção 3 do docs/interfaces.md (funções, eventos e erros do Registry) e a revisão de outra pessoa."
ajusta 6  "Código · Folha Merkle e prova embutida na credencial" "$E1" "frente:codigo" \
"Estado em 06/11: as seções 1 e 2 do docs/interfaces.md estão preenchidas, menos a \"entrada da folha\" (a definir). Falta para fechar: definir a entrada da folha e a revisão de outra pessoa."
ajusta 16 "Código · ADR-004 Stack do MVP" "$E1" "frente:codigo" \
"Estado em 06/11: sem arquivo ainda. Falta para fechar: docs/adr/0004-stack.md aprovado, partindo do PRD e do TASKS.md, reduzido ao que cabe até 11/12."
ajusta 4  "Código · Credencial Open Badges 3.0 mínima montada à mão" "$E2" "frente:codigo" \
"Estado em 06/11: a fixture foi entregue. Falta para fechar: listar no PR os campos obrigatórios da especificação. Vale conferir também o ano do validFrom na fixture (está 2024)."
ajusta 5  "Código · ADR-003 Subconjunto do Open Badges 3.0 e formato de assinatura" "$E2" "frente:codigo" \
"Estado em 06/11: o ADR-003 está escrito. Falta para fechar: a lista fechada de campos adotados e a aprovação em encontro (o status ainda é \"proposta\")."
ajusta 7  "Telas · Telas mínimas de emissor, participante e verificador" "$E2" "frente:telas" \
"Estado em 06/11: sem arquivo ainda. Falta para fechar: docs/produto/telas-minimas.md com as telas de cada perfil e uma frase sobre o objetivo de cada uma."
ajusta 8  "Telas · Jornadas de emissor, participante e verificador" "$E2" "frente:telas" \
"Estado em 06/11: sem arquivo ainda. Falta para fechar: docs/produto/jornadas.md com as três jornadas passo a passo, revisado por alguém de Pesquisa."
ajusta 10 "Pesquisa · Bases de busca e dez trabalhos candidatos" "$E2" "frente:pesquisa" \
"Estado em 06/11: o PR #26 entregou 8 plataformas. Falta para fechar: as bases acadêmicas consultadas e dez trabalhos candidatos com link, ou a decisão de que 8 bastam. Sugestão: o arquivo do PR se chama protocolo-de-pesquisa.md e o README da pasta espera protocolo-de-busca.md; alinhar um dos dois."
ajusta 12 "Pesquisa · Tabela comparativa v1" "$E2" "frente:pesquisa" \
"Estado em 06/11: o PR #26 traz uma tabela com 8 plataformas. Falta para fechar: OpenCerts e POAP, e as colunas do critério (padrão, ancoragem, privacidade, revogação, verificação independente, custo)."
ajusta 13 "Pesquisa · Mapa de cinco emissores de certificado na UFRJ" "$E2" "frente:pesquisa" \
"Estado em 06/11: sem arquivo ainda. Falta para fechar: docs/institucional/mapa-emissores.md com cinco emissores por unidade e papel, sem nomes nem contatos (esses ficam na planilha do Drive)."
ajusta 14 "Pesquisa · Roteiro de entrevista semiestruturada" "$E2" "frente:pesquisa" \
"Estado em 06/11: sem arquivo ainda. Falta para fechar: docs/institucional/roteiro-entrevista.md validado por Isaac e pela Profa. Maria Luiza, com o texto de consentimento."
ajusta 9  "Telas · Wireframes da página de verificação" "$E3" "frente:telas" \
"Estado em 06/11: sem arquivo ainda. Escopo ajustado: wireframes de baixa fidelidade da página pública de verificação, em docs/produto/wireframes/. O formato do CSV virou uma tarefa \"se sobrar tempo\"."
ajusta 11 "Pesquisa · Protocolo de busca e evento-alvo" "$E3" "frente:pesquisa" \
"Estado em 06/11: sem arquivo ainda. Falta para fechar: critérios de inclusão e exclusão fechados e evento-alvo escolhido, com o prazo de submissão registrado."
ajusta 15 "Pesquisa · Duas entrevistas agendadas" "$E3" "frente:pesquisa" \
"Estado em 06/11: depende do roteiro de entrevista. Falta para fechar: duas entrevistas com data e horário confirmados, registradas na planilha do Drive."
echo

# ----------------------------------------------------------- tarefas novas
echo "== Tarefas novas"
nova() { # titulo  etapa(ou vazio)  etiquetas  o_que_fazer  pronto_quando
  if existe "$1"; then
    echo "já existe: $1"
    return 0
  fi
  echo "nova: $1  [${2:-sem etapa}]"
  local corpo
  corpo="**O que fazer**"$'\n'"$4"$'\n\n'"**Pronto quando**"$'\n'"$5"
  if [ "$APLICAR" = "1" ]; then
    if [ -n "$2" ]; then
      gh issue create --repo "$R" --title "$1" --body "$corpo" --label "$3" --milestone "$2" > /dev/null
    else
      gh issue create --repo "$R" --title "$1" --body "$corpo" --label "$3" > /dev/null
    fi
  fi
}

# Etapa 1
nova "Código · Aprovar ADR-001, ADR-002 e ADR-003" "$E1" "frente:codigo,tamanho:P" \
"Marcar como aprovadas as decisões dos três ADRs já escritos e preencher a data de aprovação. No ADR-002, preencher também o título." \
"Os 3 arquivos em docs/adr/ estão com status \"aprovada\", data de aprovação preenchida e o ADR-002 tem título."
nova "Pesquisa · Revisar o PR #26" "$E1" "frente:pesquisa,tamanho:P" \
"Alguém de outra frente revisa o PR #26 (pesquisa de plataformas de certificação)." \
"O PR #26 tem uma revisão registrada: aprovado ou com ajustes pedidos."

# Etapa 2
nova "Código · Registry mínimo publicado em Arbitrum Sepolia" "$E2" "frente:codigo,tamanho:M" \
"Escrever o contrato que ancora e consulta a raiz de um lote, e publicar em Arbitrum Sepolia." \
"Os testes passam (forge test), o contrato está verificado no Arbiscan e o endereço está na seção 3 do docs/interfaces.md."
nova "Código · Folha Merkle em código (JCS + keccak256)" "$E2" "frente:codigo,tamanho:M" \
"Gerar a raiz e a prova de inclusão a partir da fixture de credencial." \
"Um teste automático confirma que a prova de uma credencial bate com a raiz do lote."
nova "Código · Assinatura da credencial" "$E2" "frente:codigo,tamanho:M" \
"Assinar a credencial e validar a assinatura." \
"A credencial assinada passa na validação e a mesma credencial com um campo alterado falha."
nova "Código · Comando emitir" "$E2" "frente:codigo,tamanho:M" \
"Um comando que recebe os dados de um participante, monta a credencial, assina, ancora a raiz na testnet e salva o JSON." \
"Rodar o comando gera o arquivo JSON e imprime o hash da transação."
nova "Código · Comando verificar" "$E2" "frente:codigo,tamanho:M" \
"Um comando que lê o JSON e responde VALIDA ou ADULTERADA, consultando a testnet." \
"A credencial emitida dá VALIDA e a mesma com um campo alterado dá ADULTERADA."
nova "Código · Demonstração ao vivo em 27/11" "$E2" "frente:codigo,tamanho:P" \
"Emitir e verificar um certificado ao vivo no encontro." \
"A demonstração roda do início ao fim no encontro de 27/11, sem ajuda fora da tela."

# Etapa 3
nova "Código · Página pública de verificação" "$E3" "frente:codigo,tamanho:M" \
"Página que recebe o JSON (upload) e mostra VÁLIDA ou ADULTERADA, consultando a testnet." \
"Abre no celular, mostra o resultado em até 10 segundos e funciona sem login."
nova "Código · QR code na credencial" "$E3" "frente:codigo,tamanho:P" \
"Gerar um QR que leva à página de verificação com a credencial." \
"Ler o QR com a câmera do celular abre a página e mostra VÁLIDA."
nova "Código · Emitir os certificados do Demo Day" "$E3" "frente:codigo,tamanho:M" \
"Emitir um certificado para cada pessoa presente, a partir de uma lista simples (a lista fica no Drive, não no repositório)." \
"Cada pessoa da lista tem um certificado com QR, ancorado na testnet."
nova "Código · Ensaio completo em 04/12" "$E3" "frente:codigo,tamanho:P" \
"Rodar o fluxo inteiro como será no Demo Day e anotar o que falhar." \
"O fluxo roda até o fim e cada falha virou uma tarefa."
nova "Pesquisa · Resumo de trabalhos relacionados" "$E3" "frente:pesquisa,tamanho:M" \
"Texto curto com o que já existe e onde o CertChain é diferente." \
"docs/pesquisa/trabalhos-relacionados.md tem de 1 a 2 páginas, com referências."
nova "Pesquisa · Entrevistas realizadas e sintetizadas" "$E3" "frente:pesquisa,tamanho:M" \
"Fazer de 3 a 5 entrevistas com quem emite certificado na UFRJ e sintetizar em requisitos para Telas." \
"As sínteses anonimizadas estão em docs/institucional/, sem nomes nem contatos."

# Se sobrar tempo (sem etapa)
nova "Código · Importar participantes por CSV" "" "frente:codigo,se-sobrar-tempo,tamanho:M" \
"Definir o formato do CSV de participantes (seção 4 do docs/interfaces.md) e importar a lista para emitir em lote." \
"Um CSV de exemplo vira credenciais com QR, todas verificáveis."
nova "Código · Revogar uma credencial" "" "frente:codigo,se-sobrar-tempo,tamanho:M" \
"Revogar uma credencial emitida e refletir isso na verificação." \
"Uma credencial revogada aparece como REVOGADA na página pública."
nova "Telas · Painel do emissor" "" "frente:telas,se-sobrar-tempo,tamanho:M" \
"Tela onde quem organiza o evento cadastra a atividade e emite os certificados." \
"Uma pessoa sem conhecimento técnico emite um certificado sozinha, só pela tela."

echo
if [ "$APLICAR" = "1" ]; then
  echo "Pronto. Confira: https://github.com/$R/issues"
  echo "Depois, veja se as tarefas novas entraram no Project (se o auto-add estiver desligado, adicione)."
else
  echo "Simulação concluída. Para aplicar: APLICAR=1 bash scripts/reorganizar-github.sh"
fi
