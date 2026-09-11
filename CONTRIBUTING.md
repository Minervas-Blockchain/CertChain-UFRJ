# Como trabalhamos

## Ritmo

- **Encontro quinzenal**, sextas às 18h: 25/09, 09/10, 23/10, 06/11, 27/11 e 11/12. Com duas pessoas presentes, o encontro acontece.
- **Checkpoint semanal**: toda sexta às 9h abre uma issue com a label `checkpoint`. Até as 18h, o ponto focal de cada frente comenta:

  ```
  Frente:
  Feito:
  Próximo:
  Bloqueio: (ou "nenhum")
  ```

- **Sync de destrave**: se houver bloqueio, marque a label `bloqueado` na issue travada. Isaac ou Calé combinam 15 minutos com a frente até a terça seguinte.

## Regras

1. Todo trabalho é issue, com Frente, Tamanho e milestone. Sem issue, não aconteceu.
2. Tamanho `P` é até 2 horas, `M` é até 5 horas. Maior que isso, quebre em mais de uma issue.
3. Toda entrega termina em pull request, inclusive documentos. A revisão é feita por alguém de **outra** frente.
4. Decisão técnica que afeta outra frente vira ADR em `docs/adr/` e é aprovada em encontro.
5. Nenhum dado pessoal no repositório. Sínteses de entrevista são anonimizadas; gravações, transcrições e contatos ficam no Drive do grupo.

## Fluxo de uma issue

1. Pegue uma issue da coluna *Na quinzena* e atribua a você.
2. Crie uma branch: `frente/numero-descricao-curta` (ex.: `protocolo/12-adr-rede`).
3. Abra o PR cedo, como rascunho, citando `Closes #12`.
4. Peça revisão a alguém de outra frente.
5. Com aprovação, faça o merge. A issue fecha sozinha e o card vai para *Feito*.
