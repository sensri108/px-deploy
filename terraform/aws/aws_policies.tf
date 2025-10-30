data "aws_iam_policy_document" "elb_policy_doc" {
    statement {
            actions = ["iam:CreateServiceLinkedRole"]
            resources = ["*"]
            condition {
                test = "StringEquals"
                variable = "iam:AWSServiceName" 
                values = ["elasticloadbalancing.amazonaws.com"]
                }
            }
    
    statement {
            actions = [
                "ec2:DescribeAccountAttributes",
                "ec2:DescribeAddresses",
                "ec2:DescribeAvailabilityZones",
                "ec2:DescribeInternetGateways",
                "ec2:DescribeVpcs",
                "ec2:DescribeVpcPeeringConnections",
                "ec2:DescribeSubnets",
                "ec2:DescribeSecurityGroups",
                "ec2:DescribeInstances",
                "ec2:DescribeNetworkInterfaces",
                "ec2:DescribeTags",
                "ec2:GetCoipPoolUsage",
                "ec2:DescribeCoipPools",
                "ec2:GetSecurityGroupsForVpc",
                "ec2:DescribeIpamPools",
                "ec2:DescribeRouteTables",
                "elasticloadbalancing:DescribeLoadBalancers",
                "elasticloadbalancing:DescribeLoadBalancerAttributes",
                "elasticloadbalancing:DescribeListeners",
                "elasticloadbalancing:DescribeListenerCertificates",
                "elasticloadbalancing:DescribeSSLPolicies",
                "elasticloadbalancing:DescribeRules",
                "elasticloadbalancing:DescribeTargetGroups",
                "elasticloadbalancing:DescribeTargetGroupAttributes",
                "elasticloadbalancing:DescribeTargetHealth",
                "elasticloadbalancing:DescribeTags",
                "elasticloadbalancing:DescribeTrustStores",
                "elasticloadbalancing:DescribeListenerAttributes",
                "elasticloadbalancing:DescribeCapacityReservation"
            ]
            resources = ["*"]
        }
    statement {
            actions = [
                "cognito-idp:DescribeUserPoolClient",
                "acm:ListCertificates",
                "acm:DescribeCertificate",
                "iam:ListServerCertificates",
                "iam:GetServerCertificate",
                "waf-regional:GetWebACL",
                "waf-regional:GetWebACLForResource",
                "waf-regional:AssociateWebACL",
                "waf-regional:DisassociateWebACL",
                "wafv2:GetWebACL",
                "wafv2:GetWebACLForResource",
                "wafv2:AssociateWebACL",
                "wafv2:DisassociateWebACL",
                "shield:GetSubscriptionState",
                "shield:DescribeProtection",
                "shield:CreateProtection",
                "shield:DeleteProtection"
            ]
            resources = ["*"]
        }
    statement {
            actions = [
                "ec2:AuthorizeSecurityGroupIngress",
                "ec2:RevokeSecurityGroupIngress"
            ]
            resources = ["*"]
        }
    statement {
            actions = [
                "ec2:CreateSecurityGroup"
            ]
            resources = ["*"]
        }
    statement {
            actions = [
                "ec2:CreateTags"
            ]
            resources = ["arn:aws:ec2:*:*:security-group/*"]
            condition {
                test = "StringEquals"
                variable = "ec2:CreateAction"
                values = ["CreateSecurityGroup"]
                }
            condition {
                test = "Null"
                variable = "aws:RequestTag/elbv2.k8s.aws/cluster"
                values = ["false"]
                }
            }
    statement {
            actions = [
                "ec2:CreateTags",
                "ec2:DeleteTags"
            ]
            resources = ["arn:aws:ec2:*:*:security-group/*"]
            condition {
                test = "Null"
                variable = "aws:RequestTag/elbv2.k8s.aws/cluster"
                values =  ["true"]
                }
            condition {
                test = "Null"
                variable = "aws:ResourceTag/elbv2.k8s.aws/cluster"
                values = ["false"]
                }
        }
    statement {
            actions = [
                "ec2:AuthorizeSecurityGroupIngress",
                "ec2:RevokeSecurityGroupIngress",
                "ec2:DeleteSecurityGroup"
            ]
            resources = ["*"]
            condition {
                test = "Null"
                variable = "aws:ResourceTag/elbv2.k8s.aws/cluster"
                values = ["false"]
                }
        }
    statement {
            actions = [
                "elasticloadbalancing:CreateLoadBalancer",
                "elasticloadbalancing:CreateTargetGroup"
            ]
            resources = ["*"]
            condition {
                test = "Null"
                variable = "aws:RequestTag/elbv2.k8s.aws/cluster"
                values = ["false"]
            }
        }
    statement {
            actions = [
                "elasticloadbalancing:CreateListener",
                "elasticloadbalancing:DeleteListener",
                "elasticloadbalancing:CreateRule",
                "elasticloadbalancing:DeleteRule"
            ]
            resources = ["*"]
        }
    statement {
            actions = [
                "elasticloadbalancing:AddTags",
                "elasticloadbalancing:RemoveTags"
            ]
            resources = [
                "arn:aws:elasticloadbalancing:*:*:targetgroup/*/*",
                "arn:aws:elasticloadbalancing:*:*:loadbalancer/net/*/*",
                "arn:aws:elasticloadbalancing:*:*:loadbalancer/app/*/*"
            ]
            condition {
                test = "Null"
                variable = "aws:RequestTag/elbv2.k8s.aws/cluster"
                values = ["true"]
            }
            condition {
                test = "Null"
                variable = "aws:ResourceTag/elbv2.k8s.aws/cluster"
                values = ["false"]
            }
        }
    statement {
             actions = [
                "elasticloadbalancing:AddTags",
                "elasticloadbalancing:RemoveTags"
            ]
            resources = [
                "arn:aws:elasticloadbalancing:*:*:listener/net/*/*/*",
                "arn:aws:elasticloadbalancing:*:*:listener/app/*/*/*",
                "arn:aws:elasticloadbalancing:*:*:listener-rule/net/*/*/*",
                "arn:aws:elasticloadbalancing:*:*:listener-rule/app/*/*/*"
            ]
        }
    statement {
            actions = [
                "elasticloadbalancing:ModifyLoadBalancerAttributes",
                "elasticloadbalancing:SetIpAddressType",
                "elasticloadbalancing:SetSecurityGroups",
                "elasticloadbalancing:SetSubnets",
                "elasticloadbalancing:DeleteLoadBalancer",
                "elasticloadbalancing:ModifyTargetGroup",
                "elasticloadbalancing:ModifyTargetGroupAttributes",
                "elasticloadbalancing:DeleteTargetGroup",
                "elasticloadbalancing:ModifyListenerAttributes",
                "elasticloadbalancing:ModifyCapacityReservation",
                "elasticloadbalancing:ModifyIpPools"
            ]
            resources = ["*"]
            condition {
                test = "Null"
                variable = "aws:ResourceTag/elbv2.k8s.aws/cluster"
                values = ["false"]
            }
        }
    statement {
            actions = [
                "elasticloadbalancing:AddTags"
            ]
            resources = [
                "arn:aws:elasticloadbalancing:*:*:targetgroup/*/*",
                "arn:aws:elasticloadbalancing:*:*:loadbalancer/net/*/*",
                "arn:aws:elasticloadbalancing:*:*:loadbalancer/app/*/*"
            ]
            condition {
                test = "StringEquals"
                variable = "elasticloadbalancing:CreateAction"
                values =  ["CreateTargetGroup","CreateLoadBalancer"]
                }
            condition {
                test = "Null"
                variable = "aws:RequestTag/elbv2.k8s.aws/cluster"
                values = ["false"]
                }
        }
    statement {
            actions = [
                "elasticloadbalancing:RegisterTargets",
                "elasticloadbalancing:DeregisterTargets"
            ]
            resources = ["arn:aws:elasticloadbalancing:*:*:targetgroup/*/*"]
        }
    statement {
            actions = [
                "elasticloadbalancing:SetWebAcl",
                "elasticloadbalancing:ModifyListener",
                "elasticloadbalancing:AddListenerCertificates",
                "elasticloadbalancing:RemoveListenerCertificates",
                "elasticloadbalancing:ModifyRule",
                "elasticloadbalancing:SetRulePriorities"
            ]
            resources = ["*"]
        }
}