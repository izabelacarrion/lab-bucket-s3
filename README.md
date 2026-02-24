# 🚀 AWS Infrastructure Automation (Terraform + GitHub Actions)

Este repositório contém a automação de infraestrutura na AWS utilizando **Terraform** e **GitHub Actions**. O projeto foi desenvolvido com foco em boas práticas de mercado, utilizando ambientes isolados e autenticação segura.

---

## 🏗️ Diferenciais do Projeto

* **Autenticação via OIDC (OpenID Connect):** Não utilizamos chaves fixas (`Access Keys`). A conexão entre GitHub e AWS é feita via tokens temporários e uma IAM Role com política de confiança.
* **Ambientes Isolados (Workspaces):** Gerenciamento de múltiplos ambientes (**Staging** e **Production**) utilizando o mesmo código através de Terraform Workspaces.
* **State Remoto:** O arquivo de estado do Terraform (`.tfstate`) é armazenado de forma segura em um bucket S3, permitindo colaboração e persistência.
* **Privilégio Mínimo:** Políticas de IAM restritas aos recursos específicos do projeto.

---

## 🛠️ Fluxo de CI/CD

O fluxo de trabalho é baseado em branches:

| Branch | Ambiente (Workspace) | Ação de Deploy |
| :--- | :--- | :--- |
| `develop` | `stag` | Executa `terraform plan` para validação. |
| `main` | `prod` | Executa `terraform apply` automático após o merge. |

<img width="685" height="362" alt="Captura de tela de 2026-02-24 18-15-01" src="https://github.com/user-attachments/assets/27a492d0-f179-4cea-a22b-a84c6c1fd5df" />


---

## 🔐 Configuração de Secrets

Para que as pipelines funcionem, as seguintes **Actions Secrets** devem ser configuradas no repositório:

* `AWS_ROLE_ARN`: ARN da Role IAM (ex: `arn:aws:iam::12345678:role/GitHubActionsRole`)
* `AWS_DEFAULT_REGION`: Região da AWS (ex: `us-east-1`)
* `BACKEND_CONFIG`: Conteúdo do arquivo de configuração do backend:
    ```hcl
    bucket = "seu-bucket-de-estado"
    key    = "caminho/terraform.tfstate"
    region = "us-east-1"
    ```

---

## 📂 Estrutura de Arquivos

```text
.
├── .github/workflows/
│   ├── deploy.yml      # Pipeline de integração e deploy contínuo
│   └── destroy.yml     # Pipeline manual para destruição da infra
├── modules/
│   └── s3/             # Módulo encapsulado para criação do Bucket S3
├── main.tf             # Arquivo principal (chamada de módulos e workspaces)
├── variables.tf        # Definição das variáveis de entrada
├── provider.tf         # Configuração dos providers e Backend S3
└── README.md           # Documentação do projeto

© 2026 - Desenvolvido por Izabela Carrion para fins de estudo em Cloud & DevOps.
