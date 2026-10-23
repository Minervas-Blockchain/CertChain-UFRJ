ADR-003: Subconjunto do Open Badges 3.0 e formato de assinatura

Status: proposta
Frente: Verificação
Data da aprovação: encontro de 08/10/2026

Contexto
Precisamos definir o subconjunto exato de campos do Open Badges 3.0 (OBv3) e o formato de assinatura adotados pelo projeto. Sem essa decisão, não há padronização para a construção da fixture `credencial-minima.json`, para a validação no contrato inteligente e para a suíte de testes de verificação.

Opções consideradas

Opção A: Subconjunto estrito do OBv3 (campos obrigatórios do W3C VC v2 + OBv3) assinado via prova de ancoragem em lote (Merkle Tree).
- Prós: Estrutura leve, baixa complexidade na validação on-chain, facilidade de manutenção de fixtures.
- Contras: Omite atributos opcionais detalhados (ex: `alignment`, `evidence`).
- Custo: Baixo.

Opção B: Especificação completa do OBv3 contendo metadados estendidos e assinatura individual via Data Integrity Proof.
- Prós: Suporta metadados avançados e provas criptográficas autônomas.
- Contras: Aumenta o tamanho da credencial e a carga de verificação.
- Custo: Alto.

Decisão
Adoção da Opção A: utilizar o subconjunto estrito de campos obrigatórios do OBv3 com prova de integridade baseada em ancoragem em lote via Árvore de Merkle.

Consequências
O que fica mais fácil: Validação direta, leve e previsível do JSON nos testes e no ecossistema de verificação.
O que fica mais difícil: Alterar ou incluir novos campos opcionais no futuro exigirá revisão desta decisão.
O que outras frentes precisam ajustar:
- Protocolo: Usar o subconjunto definido para calcular o hash da folha da Árvore de Merkle.
- Produto: Exibir estes campos na interface ao ler a credencial.

Evidências
- Especificação Open Badges 3.0 (1EdTech)
- Fixture de referência em `packages/credential/fixtures/credencial-minima.json`
