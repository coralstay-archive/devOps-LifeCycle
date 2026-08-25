# private-vpc-only

**카테고리**: 네트워크/보안
**설명**: 퍼블릭 서브넷 없이 PrivateLink/VPN으로만 통신하는 완전 사설 VPC.

## 상태

composed — `vpc`(NAT 게이트웨이 비활성화)+`vpc-endpoints`(S3/DynamoDB 게이트웨이 + ECR/CloudWatch Logs 인터페이스) 조합, `terraform validate` 통과. 이 조합만으로는 인터넷 아웃바운드가 전혀 없다 — 필요하면 VPN/Transit Gateway를 별도로 추가할 것(아직 모듈 없음).

## 관련 모듈

vpc, vpc-endpoints

## 참고자료

- [AWS PrivateLink 개요](https://docs.aws.amazon.com/vpc/latest/privatelink/what-is-privatelink.html)
- 관련 모듈 문서: `vpc`, `vpc-endpoints`
