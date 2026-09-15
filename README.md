# container-arch--aws-eks

Cluster EKS do projeto `ct-arch`. Instancia o módulo [`eks_cluster`](https://github.com/therenanlira/container-arch--aws-eks-modules/tree/main/eks_cluster) sobre a rede criada pelo [`container-arch--aws-eks-vpc`](https://github.com/therenanlira/container-arch--aws-eks-vpc).

## Pré-requisitos

- `container-arch--aws-eks-vpc` aplicado no mesmo ambiente
- Terraform `~> 1.13`
- Credenciais AWS da conta `150100906110`
- AWS CLI e `kubectl`, para acessar o cluster
- Repo de módulos clonado ao lado deste (o `source` é um caminho relativo):

  ```
  git/
  ├── container-arch--aws-eks-modules/
  └── container-arch--aws-eks/
  ```

## Estrutura

```
terraform/
├── assets/
│   └── chip-aula-2.yaml       # app de exemplo: Deployment, Service e HPA
├── environment/
│   └── prd/
│       ├── backend.tfvars     # bucket, key e região do state
│       └── terraform.tfvars   # valores do ambiente
├── eks_cluster.tf             # chamada do módulo eks_cluster
└── _*.tf                      # backend, providers, variáveis, locals e data sources
```

## Uso

```bash
cd terraform
terraform init -backend-config=environment/prd/backend.tfvars
terraform plan -var-file=environment/prd/terraform.tfvars -out=plan.tfplan
terraform apply plan.tfplan
```

Acesso ao cluster e deploy do app de exemplo:

```bash
aws eks update-kubeconfig --name prd-ct-arch-eks --region us-east-2
kubectl apply -f assets/chip-aula-2.yaml
```

Destrua este repo antes do `container-arch--aws-eks-vpc`.

## Como funciona

- **Rede:** lê o parâmetro SSM `/prd/us-east-2/ct-arch/vpc-network` e passa o JSON decodificado ao módulo.
- **Endpoint público:** liberado só para o IP de quem roda o `plan`, obtido em `checkip.amazonaws.com`. Se o seu IP mudar, o próximo `apply` atualiza o cluster.
- **Providers `kubernetes` e `helm`:** configurados na raiz com os outputs do módulo e o token de `aws_eks_cluster_auth`.

## Variáveis

| Nome | Descrição | `prd` |
| --- | --- | --- |
| `account_id` | Única conta aceita pelo provider | `150100906110` |
| `region` | Região do cluster | `us-east-2` |
| `environment` | Ambiente | `prd` |
| `project_name` | Nome do projeto, usado em nomes e tags | `ct-arch` |
| `auto_scale_options` | Tamanho do node group | `{ min = 1, max = 2, des = 1 }` |
| `nodes_instance_types` | Tipos de instância dos nodes | `["m7i-flex.large", "c7i-flex.large"]` |

State em `ct-arch/prd/aws-eks/terraform.tfstate`.
