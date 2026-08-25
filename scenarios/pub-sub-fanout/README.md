# pub-sub-fanout

**카테고리**: 이벤트/메시징
**설명**: SNS로 여러 SQS 큐에 팬아웃하는 패턴.

## 상태

composed — 1개 토픽이 `queue_names` 변수(기본값: orders, notifications) 개수만큼 큐로 팬아웃. `terraform validate` 통과. `sns-sqs` 모듈은 1:1 구조라 여기서는 쓰지 않고 원시 리소스로 직접 구성했다 (이유는 `main.tf` 주석 참고).

## 관련 모듈

(모듈 미사용 — 원시 aws_sns_topic/aws_sqs_queue 리소스로 직접 구성)

## 참고자료

- [Amazon SNS: 팬아웃 시나리오](https://docs.aws.amazon.com/sns/latest/dg/sns-common-scenarios.html)
