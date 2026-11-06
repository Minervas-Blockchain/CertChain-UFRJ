# Como trabalhamos

Versão de uma página: [COMECE-AQUI.md](COMECE-AQUI.md).

## Ritmo

- **Encontro quinzenal**, sextas às 18h: 06/11, 27/11 e 11/12. Com duas pessoas presentes, o encontro acontece.
- **Checkpoint semanal**: toda sexta às 9h abre uma issue com a etiqueta `checkpoint`. Até as 18h, uma pessoa de cada frente comenta:

  ```
  Frente:
  Feito:
  Próximo:
  Bloqueio: (ou "nenhum")
  ```

- **Bloqueio**: ponha a etiqueta `bloqueado` na tarefa travada. Isaac ou Calé combinam 15 minutos até a terça seguinte.

## Regras

1. Todo trabalho é uma tarefa (issue) com etapa e frente. Sem tarefa, não aconteceu.
2. Tamanho P: até 2 horas. Tamanho M: até 5 horas. Maior que isso, divida em mais de uma tarefa.
3. Toda entrega termina em pull request, inclusive documentos. Quem revisa é outra pessoa, de preferência de outra frente.
4. Antes de pedir revisão, marque o checklist do PR (3 itens).
5. Decisão técnica que afeta mais de uma frente vira ADR em `docs/adr/` e é aprovada em encontro.
6. Nenhum dado pessoal no repositório. Sínteses de entrevista são anonimizadas; gravações, transcrições e contatos ficam no Drive do grupo.
7. Para fechar tarefas pelo PR, use uma palavra-chave por tarefa: `Closes #12, closes #13`. Com `Closes #12, #13`, só a #12 fecha.

## Fluxo de uma tarefa

1. Escolha uma tarefa da etapa atual e coloque seu nome nela.
2. Crie uma branch: `frente/numero-descricao-curta` (ex.: `codigo/12-registry`).
3. Abra o PR cedo, como rascunho, com `Closes #12`.
4. Peça revisão.
5. Com aprovação, faça o merge. A tarefa fecha sozinha.
