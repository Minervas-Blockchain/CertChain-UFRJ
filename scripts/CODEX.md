# Tarefa para o Codex: reorganizar o GitHub do CertChain

Execute os passos abaixo na ordem, sem fazer perguntas. Pare e reporte só se um passo falhar.

## Regras

- Não faça commit nem push.
- Não feche, apague nem edite tarefas além do que `scripts/reorganizar-github.sh` faz.
- Não altere `docs/`, `packages/` nem `contracts/`.
- Não use GraphQL nem o Project (o script não mexe nele).

## Passos

1. `gh auth status`. Precisa estar logado com permissão de escrita em `Minervas-Blockchain/CertChain-UFRJ`. Se falhar, pare e diga o erro.
2. `bash scripts/reorganizar-github.sh` (simulação). A saída deve terminar com "Simulação concluída". Se não terminar, pare e mostre o erro.
3. `APLICAR=1 bash scripts/reorganizar-github.sh`
4. `bash scripts/verificar-reorganizacao.sh`
5. Responda com: a última linha do passo 4 (OK ou a lista de falhas) e o link https://github.com/Minervas-Blockchain/CertChain-UFRJ/issues

## Se algo falhar

- Rodar de novo é seguro: o script pula o que já existe.
- Erro de permissão: pare e diga qual comando falhou.
- Falha do verificador: mostre as linhas de FALHA. Não tente corrigir sozinho.

---

## Como chamar o Codex (na raiz do repositório)

O sandbox `workspace-write` do Codex deixa a rede desligada por padrão, e o `gh` precisa dela:

```
codex exec --full-auto -c sandbox_workspace_write.network_access=true "Leia scripts/CODEX.md e execute os passos, sem fazer perguntas."
```

Se a flag mudou na sua versão, confira com `codex exec --help`. Alternativa: pôr no `~/.codex/config.toml`:

```
[sandbox_workspace_write]
network_access = true
```

## Sem o Codex

Com o `gh` logado, os mesmos passos rodam direto no terminal:

```
bash scripts/reorganizar-github.sh
APLICAR=1 bash scripts/reorganizar-github.sh
bash scripts/verificar-reorganizacao.sh
```
