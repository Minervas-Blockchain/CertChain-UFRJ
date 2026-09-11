# CertChain UFRJ

Plataforma aberta de emissão e verificação pública de credenciais acadêmicas digitais, com evidência criptográfica ancorada em blockchain. Desenvolvida pela frente Minerv@s Blockchain, no PPGI/UFRJ.

## Meta do semestre 2026.2

Em 11/12/2026, no Demo Day do grupo, emitir certificados reais com prova ancorada em testnet L2 e validá-los numa página pública, sem intermediação da UFRJ.

## Princípios

- Zero dado pessoal on-chain: na blockchain só vão hashes agregados em Merkle root e estado de revogação.
- Credenciais no padrão Open Badges 3.0 / W3C Verifiable Credentials.
- A verificação continua funcionando mesmo que o sistema emissor saia do ar.

## Frentes

| Frente | Pergunta-guia |
| --- | --- |
| Protocolo | O que vai para a blockchain, em qual rede, e como uma credencial é revogada? |
| Verificação | Como um terceiro confirma, sem falar com a UFRJ, que o certificado é autêntico e não foi revogado? |
| Produto | Como quem organiza e quem recebe usam o CertChain sem precisar saber que existe blockchain? |
| Pesquisa | O que já existe, o que não funcionou e onde o CertChain é de fato diferente? |
| Institucional | Quem emite certificado hoje na UFRJ, como faz, e onde isso dói? |

## Marcos

| Marco | Data | Fecha quando |
| --- | --- | --- |
| M0 · Escopo congelado | 09/10 | ADRs 001 a 004 aprovados e `docs/interfaces.md` v1 revisado |
| M1 · Vertical slice | 06/11 | Hash, assinatura, root em testnet e verificação por linha de comando |
| M2 · Emissão utilizável | 27/11 | CSV vira credenciais com QR, validadas na página pública |
| Demo Day | 11/12 | Certificados reais emitidos e verificados pelos presentes |

## Estrutura

```
docs/interfaces.md      contrato entre frentes
docs/adr/               decisões registradas
docs/pesquisa/          protocolo de busca e comparativo
docs/institucional/     roteiro e sínteses anonimizadas
docs/produto/           jornadas e wireframes
contracts/              Registry.sol (Foundry)
packages/credential/    Open Badges 3.0, assinatura e Merkle
apps/issuer/            painel do emissor
apps/verifier/          verificação pública
```

Leia o [CONTRIBUTING.md](CONTRIBUTING.md) antes da primeira issue.
