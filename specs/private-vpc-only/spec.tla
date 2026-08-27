---- MODULE spec ----
(*
학습 목적: private-vpc-only 시나리오는 vpc 모듈을 퍼블릭 서브넷/인터넷
게이트웨이 없이 구성하고, 외부 접근은 오직 VPC 엔드포인트(PrivateLink)나
VPN을 통해서만 이뤄지게 한다. Terraform이 "IGW 리소스를 안 만든다"고 선언은
하지만, 운영 중에 라우팅 테이블이 실수로 바뀌어 인터넷 경로가 생기는 걸
막는다는 보장은 코드 리뷰/정책(Conftest)의 영역이다 — 그 불변 조건을
여기서 명세한다.

핵심 안전 속성: 어떤 라우팅 테이블도 인터넷 게이트웨이로 가는 경로
(0.0.0.0/0 -> igw)를 절대 갖지 않는다 — private-only라는 이름의 약속.
*)
EXTENDS Naturals

VARIABLES hasInternetRoute, hasVpcEndpointRoute

vars == <<hasInternetRoute, hasVpcEndpointRoute>>

Init ==
    /\ hasInternetRoute = FALSE
    /\ hasVpcEndpointRoute = FALSE

\* PrivateLink용 VPC 엔드포인트를 라우팅 테이블에 추가한다 — 이건 허용되는
\* 유일한 "외부로 나가는" 경로다(실제로는 AWS 서비스로만 나간다).
AddVpcEndpointRoute ==
    /\ hasVpcEndpointRoute = FALSE
    /\ hasVpcEndpointRoute' = TRUE
    /\ UNCHANGED hasInternetRoute

\* 의도적으로 Next에 포함하지 않은 "버그" 액션 — 누군가 실수로(또는 악의적
\* 변경으로) 인터넷 게이트웨이 라우트를 추가하는 경로. Conftest의
\* s3_public_access.rego류 정책이나 이 스펙의 불변식이 이런 변경을 잡아내야
\* 한다는 걸 보여주기 위해 정의만 해둔다.
\* AddInternetRoute ==
\*     /\ hasInternetRoute' = TRUE
\*     /\ UNCHANGED hasVpcEndpointRoute

Next == AddVpcEndpointRoute

Spec == Init /\ [][Next]_vars

TypeInvariant ==
    /\ hasInternetRoute \in BOOLEAN
    /\ hasVpcEndpointRoute \in BOOLEAN

\* 이게 이 스펙의 핵심: 인터넷 게이트웨이로 가는 라우트는 이 VPC의 생애
\* 주기 동안 절대 존재해서는 안 된다.
NoInternetRoute == hasInternetRoute = FALSE

====
