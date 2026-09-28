apiVersion: karpenter.k8s.aws/v1
kind: EC2NodeClass
metadata:
  name: ${name}
spec:
  instanceProfile: ${instance_profile}
  amiFamily: ${ami_family}
  amiSelectorTerms:
  - id: ${ami_id}
  securityGroupSelectorTerms:
%{ for id in security_group_ids ~}
    - id: ${id}
%{ endfor ~}
  subnetSelectorTerms:
%{ for id in subnet_ids ~}
    - id: ${id}
%{ endfor ~}
