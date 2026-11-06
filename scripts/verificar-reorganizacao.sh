#!/usr/bin/env bash
# Confere se a reorganização do GitHub foi aplicada.
# Saída: "OK" e código 0, ou a lista de falhas e código 1.
# Rode logo depois de APLICAR=1 bash scripts/reorganizar-github.sh
# (as contagens assumem o estado inicial + o que o script cria).
# Requer o gh autenticado. Só lê; não muda nada.

set -euo pipefail

R="Minervas-Blockchain/CertChain-UFRJ"
FALHAS=0
falha() { echo "FALHA: $*"; FALHAS=$((FALHAS + 1)); }

# ------------------------------------------------------------------ etapas
MARCOS="$(gh api "repos/$R/milestones?state=all&per_page=100" --jq '.[] | "\(.title)|\(.state)|\(.open_issues)"')"

confere_marco() { # titulo  estado_esperado  abertas_esperadas(ou vazio)
  local linha estado abertas
  linha="$(printf '%s\n' "$MARCOS" | awk -F'|' -v t="$1" '$1 == t')"
  if [ -z "$linha" ]; then
    falha "etapa '$1' não existe"
    return 0
  fi
  estado="$(printf '%s' "$linha" | cut -d'|' -f2)"
  abertas="$(printf '%s' "$linha" | cut -d'|' -f3)"
  if [ "$estado" != "$2" ]; then
    falha "etapa '$1' está '$estado' (esperado '$2')"
  fi
  if [ -n "$3" ] && [ "$abertas" != "$3" ]; then
    falha "etapa '$1' tem $abertas tarefas abertas (esperado $3)"
  fi
}
confere_marco "1 · Decidido"         open   5
confere_marco "2 · Roda no terminal" open   14
confere_marco "3 · Roda no celular"  open   9
confere_marco "Demo Day"             closed ""

# --------------------------------------------------------------- etiquetas
ROTULOS="$(gh api "repos/$R/labels?per_page=100" --paginate --jq '.[].name')"
for r in frente:codigo frente:telas frente:pesquisa tamanho:P tamanho:M se-sobrar-tempo; do
  case $'\n'"$ROTULOS"$'\n' in
    *$'\n'"$r"$'\n'*) ;;
    *) falha "etiqueta '$r' não existe" ;;
  esac
done

# ---------------------------------------------------------------- tarefas
ISSUES="$(gh api "repos/$R/issues?state=open&per_page=100" --paginate \
  --jq '.[] | select(.pull_request | not) | select(([.labels[].name] | index("checkpoint")) | not) | "\(.number)|\(.title)"')"

TOTAL="$(printf '%s\n' "$ISSUES" | awk 'NF' | wc -l | tr -d ' ')"
if [ "$TOTAL" != "31" ]; then
  falha "há $TOTAL tarefas abertas (esperado 31: 5 + 14 + 9 + 3 sem etapa)"
fi

SEM_PREFIXO="$(printf '%s\n' "$ISSUES" | awk -F'|' 'NF && $2 !~ /^(Código|Telas|Pesquisa) · /')"
if [ -n "$SEM_PREFIXO" ]; then
  falha "tarefas sem prefixo de frente: $(printf '%s' "$SEM_PREFIXO" | tr '\n' ' ')"
fi

# ------------------------------------------------------------------ saída
if [ "$FALHAS" -eq 0 ]; then
  echo "OK: reorganização aplicada ($TOTAL tarefas abertas)."
  exit 0
fi
echo "$FALHAS falha(s)."
exit 1
