# zero-trust-edge

**카테고리**: 네트워크/보안
**설명**: WAF+Shield+보안그룹 강화로 제로 트러스트에 가까운 엣지 보안.

## 상태

composed — `vpc`+`alb`+`waf-shield`(ALB에 AWS Managed Common Rule Set 연결) 조합, `terraform validate` 통과. Shield Advanced는 기본 비활성화(`waf-shield` 모듈의 `enable_shield_advanced` 참고, 구독 필요).

## 관련 모듈

vpc, alb, waf-shield

## 참고자료

- [AWS 제로 트러스트](https://aws.amazon.com/security/zero-trust/)
- 관련 모듈 문서: `vpc`, `alb`, `waf-shield`
