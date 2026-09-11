# Contrato de Interfaces

Documento compartilhado por Protocolo, Verificação e Produto. Tudo o que uma frente precisa saber para trabalhar sem esperar a outra está aqui. Mudanças entram por PR com a label `interfaces` e revisão das três frentes.

**Versão:** v0 (rascunho) · **Congela em:** 09/10/2026 (M0)

## 1. Credencial

Responsável: Verificação.

- Subconjunto adotado do Open Badges 3.0: ver ADR-003.
- Exemplo canônico: `packages/credential/fixtures/credencial-minima.json`.
- Canonicalização usada antes do hash: _a definir_.
- Formato de assinatura: _a definir_.

## 2. Folha e árvore de Merkle

Responsáveis: Verificação e Protocolo.

- Entrada da folha: _a definir_ (credencial inteira canonicalizada ou só campos selecionados).
- Função de hash: _a definir_. A proposta ao Reditus cita SHA-256; a biblioteca `MerkleProof` da OpenZeppelin usa keccak256. A escolha fica registrada no ADR-002.
- Ordenação dos pares: _a definir_.
- Onde a prova fica dentro da credencial: _a definir_.

## 3. Contrato Registry

Responsável: Protocolo.

| Elemento | Assinatura | Descrição |
| --- | --- | --- |
| função | _a definir_ | ancorar a root de um lote |
| função | _a definir_ | revogar uma credencial |
| função | _a definir_ | consultar root e estado |
| evento | _a definir_ | root ancorada |
| evento | _a definir_ | credencial revogada |

- Rede: ver ADR-001.
- Endereço publicado: _preenchido no M1_.

## 4. CSV de participantes

Responsáveis: Produto e Verificação.

| Coluna | Obrigatória | Exemplo | Observação |
| --- | --- | --- | --- |
| _a definir_ | | | |

Codificação: UTF-8. Separador: _a definir_.

## 5. Verificação

Responsável: Verificação.

- Entradas aceitas: upload do JSON, leitura de QR code.
- Estados de saída: `VALIDA`, `REVOGADA`, `ADULTERADA`.
- O que cada estado exibe: _a definir_ com Produto.
