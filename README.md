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
| Código | O que vai para a blockchain, como a credencial é montada e como um terceiro confirma, sem falar com a UFRJ, que ela é autêntica? |
| Telas | Como quem organiza e quem recebe usam o CertChain sem precisar saber que existe blockchain? |
| Pesquisa | O que já existe, onde o CertChain é diferente e como é hoje a emissão de certificados na UFRJ? |

## Etapas

| Etapa | Até | Pronto quando |
| --- | --- | --- |
| 1. Decidido | 13/11 | ADR-004, folha Merkle e Registry definidos |
| 2. Roda no terminal | 27/11 | Emitir e verificar um certificado por comando, ao vivo |
| 3. Roda no celular | 11/12 | Página pública + QR: o certificado do Demo Day aparece como VÁLIDO |

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

Leia o [COMECE-AQUI.md](COMECE-AQUI.md) antes da primeira tarefa.
