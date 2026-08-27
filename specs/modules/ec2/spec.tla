---- MODULE spec ----
(*
학습 목적: RunInstances 하나의 AWS API 호출로
거의 끝나는, 이 저장소에서 가장 "알고리즘 한 줄"에 가까운 모듈이다 — 그래도
입력 중 하나(ami_id)가 null이면 최신 AL2023 AMI를 조회해서 대신 쓴다는
분기(conditional lookup)가 있다 — 말하자면 "기본값으로 대체하는 한 줄
if문"에 해당한다.

참고 문서:
- Amazon EC2 API: RunInstances, DescribeImages
  — https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_RunInstances.html
- modules/ec2/README.md의 공식문서 절 참고
*)
EXTENDS Naturals, Sequences, TLC

Null == "null"  \* variables.tf의 여러 optional(null 허용) 변수를 표현하는 공용 모델 값

CONSTANTS
    Name,               \* STRING
    SubnetId,           \* STRING
    AmiId,              \* STRING 또는 Null
    InstanceType,       \* STRING, 기본 "t3.micro"
    AssociatePublicIp   \* BOOLEAN

Input == [
    name                 |-> Name,
    subnet_id            |-> SubnetId,
    ami_id               |-> AmiId,
    instance_type        |-> InstanceType,
    associate_public_ip  |-> AssociatePublicIp
]

Precondition(input) ==
    /\ input.name \in STRING
    /\ input.subnet_id \in STRING /\ input.subnet_id # ""
    /\ input.ami_id \in STRING
    /\ input.instance_type \in STRING

\* 1. ami_id가 Null(=null)면: DescribeImages(최신 Amazon Linux 2023)로
\*    대체 조회 — data.aws_ami.amazon_linux가 실제로 하는 일.
\* 2. RunInstances(resolvedAmi, instance_type, subnet_id, ...)
Provision(input) ==
    LET resolvedAmi == IF input.ami_id = Null THEN "ami-latest-al2023" ELSE input.ami_id
        instanceId == "i-" \o input.name
    IN [
        instance_id  |-> instanceId,
        resolved_ami |-> resolvedAmi,
        private_ip   |-> "10.0.0.10",
        public_ip    |-> IF input.associate_public_ip THEN "203.0.113.10" ELSE Null
    ]

\* 이게 이 스펙의 핵심: ami_id를 안 정했으면(null) 반드시 뭔가로
\* 대체됐어야 하고(빈 값으로 새어나가면 안 됨), public_ip는
\* associate_public_ip를 껐으면 절대 나오면 안 된다(비용/보안 사고 방지).
Postcondition(input, output) ==
    /\ output.resolved_ami # Null
    /\ output.resolved_ami # ""
    /\ (~input.associate_public_ip => output.public_ip = Null)

VARIABLES dummy
vars == <<dummy>>
Init == dummy = TRUE
Next == UNCHANGED dummy
Spec == Init /\ [][Next]_vars

BehaviorHolds == Precondition(Input) => Postcondition(Input, Provision(Input))

====
