# ADR-002: Título da decisão

- **Status:** proposta
- **Frente:** Protocolo
- **Data da aprovação:** encontro de dd/mm/aaaa

## Contexto

Para evitar o custo e a complexidade de registrar cada credencial individualmente na blockchain, é necessário definir um modelo de ancoragem que permita comprovar a inclusão de uma credencial em um conjunto de certificados emitidos. Sem essa decisão, as frentes poderão implementar funções de hash, regras de canonicalização ou convenções de ordenação incompatíveis, impedindo a verificação cruzada entre credenciais.

## Opções consideradas

1. Árvore de Merkle com keccak-256 e pares ordenados

- Descrição: Canonicalizar cada credencial segundo uma regra determinística (JSON Canonicalization Scheme / RFC 8785), calcular o hash da credencial canonicalizada com keccak256 e utilizar esses hashes como folhas de uma Árvore de Merkle. Os nós internos serão calculados com keccak256 sobre os hashes dos filhos em ordem lexicográfica crescente. Em níveis com número ímpar de nós, o último nó sem par será promovido ao nível seguinte sem ser combinado. Ao fim, a raiz será registrada no contrato.
- Prós: Compatibilidade direta com Solidity, EVM e a biblioteca MerkleProof da OpenZeppelin; redução do número de transações por meio da ancoragem de múltiplas credenciais em um único lote; possibilidade de manter credenciais e provas fora da blockchain, registrando apenas a raiz à identificação do lote.
- Contras: A verificação depende da disponibilidade da prova de inclusão e da identificação do lote; exige consistência entre as implementações utilizadas para gerar e verificar as provas.
- Custos: Baixo, a ancoragem em lote reduz o custo on-chain por credencial.

2. Árvore de Merkle com SHA-256 e pares ordenados

- Descrição: Realizar o mesmo processo da primeira opção, mas utilizando SHA-256 quando calculando o hash.
- Prós: Amplo suporte em linguagens de programação, bibliotecas criptográficas e sistemas externos; fácil integração com ferramentas que já utilizam SHA-256 para identificar documentos.
- Contras: A verificação on-chain exige uma implementação compatível com SHA-256, em vez da integração direta com a implementação convencional de MerkleProof; maior esforço e complexidade de implementação e testes de interoperabilidade entre o contrato e ferramentas externas.
- Custos: Baixo, a ancoragem em lote reduz o custo on-chain por credencial, mas pode ter maior quantidade de hashs em comparação com a primeira opção.

## Decisão

Árvore de Merkle com keccak-256 e pares ordenados.

## Consequências

O que fica mais fácil:

- Ancorar múltiplas credenciais em uma única transação, reduzindo o número de operações on-chain em relação ao registro individual. Verificar a inclusão de uma credencial na raiz de um lote sem armazenar todas as credenciais no contrato.
- Reutilizar bibliotecas e ferramentas do ecossistema Solidity e OpenZeppelin para verificar provas de Merkle.
- Manter os documentos acadêmicos fora da blockchain, registrando apenas as raízes e os dados mínimos necessários para auditoria.
- Padronizar a comunicação entre Protocolo e Verificação por meio de uma regra comum para canonicalização, cálculo de hashes e construção das provas.
- Realizar testes automatizados de integridade, inclusão, adulteração e revogação.
- Permitir que terceiros verifiquem a inclusão de uma credencial sem depender exclusivamente de um banco de dados centralizado do projeto.

O que fica mais difícil:

- A geração e a validação das credenciais dependerá de uma implementação rigorosa da canonicalização e dos algoritmos de hash.
- Cada credencial precisará ser acompanhada de sua prova de inclusão e da identificação do lote correspondente.

O que outras frentes precisam ajustar: Implementar o cálculo de hashs com keccak256 e validar a credencial recebida a partir da raiz registrada (Verificação).

## Evidências

ADR-001, ADR-003, e [biblioteca OpenZeppelin](https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/cryptography/MerkleProof.sol).
