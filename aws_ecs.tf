
resource "aws_ecs_task_definition" "prover_definition" {
  family                   = "prover_task_definition"
  task_role_arn            = aws_iam_role.ecs_task_role.arn
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "1024"
  requires_compatibilities = ["FARGATE"]
  container_definitions    = <<DEFINITION
[
  {
    "image": "docker.io/mattjurenka/prover-with-zkey:prover-fe-cors",
    "name": "prover-fe-cors",
    "logConfiguration": {
                "logDriver": "awslogs",
                "options": {
                    "awslogs-region" : "ap-northeast-2",
                    "awslogs-group" : "stream-to-log-prover",
                    "awslogs-stream-prefix" : "project"
               }
            },
     "portMappings": [
        {
          "containerPort": 80,
          "protocol": "tcp"
        }
      ],
    "environment": [
            {
                "name": "PROVER_URI",
                "value": "http://localhost:8080"
            },
            {
                "name": "NODE_ENV",
                "value": "production"
            },
            {
                "name": "DEBUG",
                "value": "zkLogin:info,jwks"
            }

        ]
    },
  {
    "image": "docker.io/mattjurenka/prover-with-zkey:prover",
    "name": "prover",
    "logConfiguration": {
                "logDriver": "awslogs",
                "options": {
                    "awslogs-region" : "ap-northeast-2",
                    "awslogs-group" : "stream-to-log-prover",
                    "awslogs-stream-prefix" : "project"
               }
            },
     "portMappings": [
        {
          "containerPort": 8080,
          "protocol": "tcp"
        }
      ],
    "environment": [
            {
                "name": "PROVER_URI",
                "value": "http://localhost:8080"
            },
            {
                "name": "NODE_ENV",
                "value": "production"
            },
            {
                "name": "DEBUG",
                "value": "zkLogin:info,jwks"
            }

        ]
    }
]
DEFINITION
}