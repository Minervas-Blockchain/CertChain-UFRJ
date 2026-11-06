# Relatório de Pesquisa: Emissores de Certificados com Blockchain

## Introdução

A **CertChain** é uma aplicação para validação e emissão de certificados utilizando a tecnologia *Blockchain*. A proposta inicial deste projeto é integrar a plataforma à estrutura atual de produção e distribuição de certificados acadêmicos na Universidade Federal do Rio de Janeiro (UFRJ).

Os requisitos funcionais e operacionais foram identificados a partir desta pesquisa de mercado, que analisou plataformas de escopo semelhante ao da CertChain para compreender suas características principais, funcionalidades distintivas e modos de operação. O levantamento reuniu soluções e artigos de referência para balizar o desenvolvimento do sistema.

## Critérios de busca

### 1. Busca via Google

Utilizando a *string* de busca `"blockchain certificate generator"`, foram selecionadas as seguintes aplicações a partir dos primeiros resultados relevantes:

* [Blockchain Cert](https://www.blockchaincert.com/)

* [DynaPictures Auto-Generator](https://dynapictures.com/online-certificates/free-online-blockchain-certificate-auto-generator)

Os demais resultados obtidos nessa consulta se referem à artigos acadêmicos sobre implementação de *blockchain* em sistemas de certificação.

### 2. Busca via Perplexity AI

Com a mesma *string* de busca `"blockchain certificate generator"`, foram mapeados os seguintes repositórios e serviços:

* [Blockchain Certificates (PyPI)](https://pypi.org/project/blockchain-certificates/)

* [BCDiploma](https://www.bcdiploma.com/en/lp-sign-up-badges)

Utilizando a variação `"certificate creator with blockchain"`:

* [Verix](https://www.verix.io/)

### 3. Busca via DuckDuckGo

Através da *string* `"blockchain certificate generator"`:

* [Ethereum Certificate Generator (DevUTL)](https://devutl.com/ethereum-certificate-generator/)

* [Blockcerts](https://www.blockcerts.org/)

Através da *string* `"certificate creator with blockchain"`:

* [Klever / ABCripto (Artigo Educacional)](https://klever.org/pt-br/blog/emissao-certificados-blockchain-klever-abcripto/)

## Análise Comparativa das Plataformas

A tabela a seguir busca resumir os diferenciais  competitivos e semelhanças entre as aplicações encontras na busca realizada anteriormente, bem como seu ano de lançamento para avaliar o grau de tecnologia implementado na época, de forma que seja possível fazer a escolha de alguns como base de estudo principal para o desenvolvimento de nosso trabalho.

| Fonte | Diferenciais | Similaridades | Período de criação | 
| ----- | ----- | ----- | ----- | 
| **Blockchain Certificates (PyPI)**  `pypi.org` | Biblioteca empacotada em Python, voltada para desenvolvedores integrarem fluxos de verificação e árvores de Merkle diretamente em rotinas de código. | Foco na arquitetura *open-source* baseada no padrão Blockcerts para registro imutável de dados. | Jan/2022 | 
| **BCDiploma**  `bcdiploma.com` | Especializado em microcredenciais, *badges* e diplomas para o ensino superior europeu, com integração nativa via contratos inteligentes. | Emissão em lote (*batch*), imutabilidade de dados e verificação autônoma diretamente na blockchain. | Nov/2017 | 
| **Ethereum Certificate Generator**  `devutl.com` | Interface simples voltada exclusivamente à rede Ethereum; atua como gerador rápido para testes locais e projetos educacionais. | Geração de certificados digitais indexados a endereços e transações em rede descentralizada. | Entre 2020–2022 | 
| **Blockcerts**  `blockcerts.org` | Padrão aberto global (desenvolvido pelo MIT Media Lab e Learning Machine) focado em identidade autossoberana e carteiras digitais. | Validação baseada em *Merkle Trees* registradas em redes públicas (Bitcoin/Ethereum). | 2016 | 
| **Blockchain Cert (Malaysia)**  `blockchaincert.com` | Foco na redução de burocracia governamental e acadêmica na Malásia (ex.: certificação de esportes e treinamentos públicos). | Painel *drag-and-drop*, importação de dados via planilhas e eliminação da necessidade de papel. | Entre 2019–2020 | 
| **DynaPictures**  `dynapictures.com` | Foco em geração dinâmica de imagens e automação visual de certificados em massa conectados a planilhas ou APIs. | Criação automatizada de modelos gráficos para emissão e lote de documentos digitais. | Entre 2020–2021 | 
| **Verix**  `verix.io` | Integração de criptografia em blockchain com ferramentas de Inteligência Artificial generativa e métricas de engajamento. | Credenciais invioláveis, leitura rápida via QR Code e compartilhamento social simplificado. | 2022 | 
| **Klever (Artigo ABCripto)**  `klever.org` | Estudo de caso/artigo institucional abordando o uso da infraestrutura de carteira descentralizada para certificação no Brasil. | Uso de criptografia e registros distribuídos para atestar a autenticidade de cursos e formações. | 2021–2022 | 

De acordo com os resultados obtidos, as aplicações que serão avaliadas tecnicamente são BCDiploma, por conta da sua aplicação voltada ao ensino superior assim com o foco da CertChain, Verix, dado a implementação de esquema de compartilhamento simplificado, e Blockcerts, devido à sua base com carteiras digitais.