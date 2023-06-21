// ESSE ARQUIVO É UMA REFERÊNCIA PARA QUE VOCÊ CRIE OS RECURSOS DE SUA APLICAÇÃO NO TF-PROJECTS

// Aqui na RD, criamos recursos como DNS, banco de dados, etc, através do Terraform.
// Com ele, conseguimos versionar os recursos criados através do Github e gerenciar de forma
// mais clara as coisas em nossos domínios.

// REFERÊNCIAS
// Terraform:
// Atlantis:
// GCP: https://cloud.google.com/docs/terraform
// Sobre o repositório tf-projects: https://oraculo.rdstation.com.br/estrutura/enablers/sre/verticals/computing/infra-as-code/terraform/tf-projects
// Para acessar sua nova aplicação criada pelo Backstage, você vai precisar de, pelo menos,
// DNS e banco de dados para staging e production. Caso você tenha criado sua app sem
// banco de dados, não precisa criar nenhum recurso relacionado a banco de dados.

// ATENÇÃO: Se lembre de trocar as ocorrências de "$owner" para o nome de seu time.

// DNS para a aplicação - PRODUCTION
// Esse bloco deve estar em tf-projects/domains/SEU_DOMINIO/production-230322/dns-production-rdops-systems.tf

resource "google_dns_record_set" "tech-interview-challenge-production-rdops-systems" {
  project      = var.project.id
  managed_zone = var.dns-zone.name
  name         = "tech-interview-challenge.${var.dns-zone.dns_name}"
  type         = "CNAME"
  ttl          = 300
  rrdatas      = [
    "k8s-production.rdops.systems.",
  ]
}

// DNS para a aplicação - STAGING
// Esse bloco deve estar em tf-projects/domains/SEU_DOMINIO/staging-234557/dns-staging-rdops-systems.tf

resource "google_dns_record_set" "tech-interview-challenge-staging-rdops-systems" {
  project      = var.project.id
  managed_zone = var.dns-zone.name
  name         = "tech-interview-challenge.${var.dns-zone.dns_name}"
  type         = "CNAME"
  ttl          = 300
  rrdatas      = [
    "k8s-staging.rdops.systems.",
  ]
}

// Banco de dados para a aplicação - PRODUCTION
// Esse bloco deve estar em tf-projects/domains/SEU_DOMINIO/production-230322/SEU_DOMINIO.tf

module "db-tech-interview-challenge" {
  source = "git@github.com:ResultadosDigitais/tf-modules.git//modules/gcp/cloud-sql?ref=gcp-cloud-sql/1.8.1"

  project       = var.project.id
  region        = var.region
  instance_name = "${var.project["name"]}-db-tech-interview-challenge"
  db_version    = "POSTGRES_13"
  location_preference = [{
    zone = "us-central1-b"
  }]
  db_name = ["tech-interview-challenge"]
  vpc_name          = var.vpc.name
  tier              = "db-g1-small"
  availability_type = "ZONAL"
  disk_size         = 10
  disk_autoresize   = false
  require_ssl       = false

  maintenance_window = {
    day            = 6,
    hour           = 10
    update_tracker = "stable"
  }

  extra_labels = {
    app      = "tech-interview-challenge"
    team      = "$owner"
    env       = "production"
    component = "database"
    service   = "cloudsql"
  }

  backup_configuration = [{
    enabled    = true,
    start_time = "01:00"
  }]

  authorized_networks = []
}

// Banco de dados para a aplicação - STAGING
// Esse bloco deve estar em tf-projects/domains/SEU_DOMINIO/staging-234557/SEU_DOMINIO.tf

module "db-tech-interview-challenge" {
  source = "git@github.com:ResultadosDigitais/tf-modules.git//modules/gcp/cloud-sql?ref=gcp-cloud-sql/1.8.1"

  project       = var.project.id
  region        = var.region
  instance_name = "${var.project["name"]}-db-tech-interview-challenge"
  db_version    = "POSTGRES_13"
  location_preference = [{
    zone = "us-central1-b"
  }]
  db_name = ["tech-interview-challenge"]
  vpc_name          = var.vpc.name
  tier              = "db-g1-small"
  availability_type = "ZONAL"
  disk_size         = 10
  disk_autoresize   = false
  require_ssl       = false

  maintenance_window = {
    day            = 6,
    hour           = 10
    update_tracker = "stable"
  }

  extra_labels = {
    app      = "tech-interview-challenge"
    team      = "$owner"
    env       = "staging"
    component = "database"
    service   = "cloudsql"
  }

  backup_configuration = [{
    enabled    = true,
    start_time = "01:00"
  }]

  authorized_networks = []
}

// DNS para o Banco de dados - PRODUCTION
// Esse bloco deve estar em tf-projects/domains/SEU_DOMINIO/production-230322/dns-production-rdops-systems.tf

resource "google_dns_record_set" "db-tech-interview-challenge" {
  project      = var.project.id
  managed_zone = var.dns-zone.name
  name         = "db-tech-interview-challenge.${var.dns-zone.dns_name}"
  type         = "A"
  ttl          = 5
  rrdatas = [
    "${module.db-tech-interview-challenge.instance_internal_address}"
  ]
}

// DNS para o Banco de dados - STAGING
// Esse bloco deve estar em tf-projects/domains/SEU_DOMINIO/staging-234557/dns-staging-rdops-systems.tf

resource "google_dns_record_set" "db-tech-interview-challenge" {
  project      = var.project.id
  managed_zone = var.dns-zone.name
  name         = "db-tech-interview-challenge.${var.dns-zone.dns_name}"
  type         = "A"
  ttl          = 5
  rrdatas = [
    "${module.db-tech-interview-challenge.instance_internal_address}"
  ]
}

// Endereço do Banco de dados - PRODUCTION E STAGING
// Esse bloco deve estar em tf-projects/domains/SEU_DOMINIO/$envinroment/outputs.tf
output tech-interview-challenge-db-private-ip {
  description = "The address of the db instance"
  value       = "postgres://${db-tech-interview-challenge.${var.dns-zone.dns_name}}/${module.db-tech-interview-challenge.database_name[0]}"
}

