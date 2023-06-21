# Primeiros passos
Este guia tem como objetivo guiar você sobre os primeiros passos necessários para executar em produção e staging a sua aplicação gerada.

* [Deploy](#deploy)
* [CI](#ci)
* [Infraestrutura](#infraestrutura)
* [Disparando o deploy](#disparando-o-deploy)
    + [Produção](#produ--o)
    + [Staging](#staging)

## Deploy
É necessário criar pipelines de *deploy* para *produção* e *staging* no [Spinnaker](https://spinnaker.rdops.systems/) para sua aplicação gerada. Para isso, você precisa, primeiro, criar uma nova aplicação no [Spinnaker](https://spinnaker.rdops.systems/) com os dados do repositório gerado pelo Backstage.

Depois, basta criar ambos os pipelines, definindo os *steps* necessários e as variáveis de ambiente usadas junto dos *secrets*. Você pode se basear [nos templates de *pipelines*](https://github.com/ResultadosDigitais/pope/tree/master/spinnaker/templates) mantidos pela RD.

Fique atento para configurar um *endpoint webhook* e seu respectivo *secret* para cada pipeline criada.

O Backstage configura variáveis de ambiente no CircleCI referenciando pipelines no Spinnaker então é necessário que você se atente a criar as urls de webhook e os secrets de acordo com o que foi configurado pelo Backstage:

    SPINNAKER_PRODUCTION_ENDPOINT= https://spinnaker-api.rdops.systems/webhooks/webhook/tech-interview-challenge-production
    SPINNAKER_PRODUCTION_SECRET= KFhGYBVsxp68qkqYAt
    SPINNAKER_STAGING_ENDPOINT= https://spinnaker-api.rdops.systems/webhooks/webhook/tech-interview-challenge-staging
    SPINNAKER_STAGING_SECRET= iF3FxMBWXBiyfxry5y

ATENÇÃO: Estes valores de secret são padrão e inseguros para serem usados definitivamente. É aconselhável gerar novos secrets para suas pipelines do Spinnaker. É necessário também alterar as variáveis de ambiente no CircleCI.

Você encontra os passos descritos nesta seção de forma detalhada no artigo [Como colocar em produção sua aplicação criada via Backstage](https://oraculo.rdstation.com.br/dev-hub/building/backstage/como-colocar-em-producao-sua-aplicacao-criada-via-backstage).

## Infraestrutura
Por último, você precisa abrir *PRs* no [*tf-projects*](https://github.com/ResultadosDigitais/tf-projects) para criar os recursos necessários para sua aplicação gerada, como DNS e bancos de dados, através do Terraform. Há um [exemplo mínimo do que precisa ser criado para rodar sua aplicação](tf-projects/example.tf) na pasta *tf-projects* dentro do repositório gerado.

## Disparando o deploy
Depois de realizar as configurações dos passos anteriores, sua aplicação está pronta para o deploy. Siga os fluxos a seguir para disparar o deploy.

### Produção
Para disparar o deploy em produção, basta fazer o *merge* na branch *main* da aplicação gerada, o que dispara o *job* de *build* da imagem Docker e também aciona o *pipeline* correspondente do [Spinnaker](https://spinnaker.rdops.systems/).

### Staging
Para disparar o deploy em *staging*, basta abrir um *PR* e, na integração do CircleCI com o GitHub, marcar como aprovado (ou "joinha") o disparo do *job* que aciona o *pipeline* correspondente do [Spinnaker](https://spinnaker.rdops.systems/).

## Acessando logs e console

Para acessar os logs de sua aplicação depois de realizado o deploy, você pode usar as ferramentas *kubectl* ou *Lens* (ou alguma outra ferramenta parecida, como *k9s*). Você pode encontrar mais informações de como instalar e usar ambas as ferramentas aqui: https://oraculo.rdstation.com.br/dev-hub/observabilidade/kubectl/como-visualizar-os-recursos-do-cluster-kubernets-usando-o-lens

Você pode configurar a variável de ambiente `RAILS_LOG_TO_STDOUT: 'true'` no pipeline de variáveis de ambiente de staging da sua aplicação para conseguir visualizar mais logs e informações sobre sua execução em tempo real.
