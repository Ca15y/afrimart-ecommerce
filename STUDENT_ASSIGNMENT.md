# STUDENT ASSIGNMENT: End-to-End DevOps Project
## AfriMart E-Commerce Platform Deployment

**Duration**: 4 Weeks  
**Team Size**: Individual or 2-person teams  
**Instructor**: John Prexy, Bloomy Technologies LTD

---

## 📚 LEARNING OBJECTIVES

By completing this project, you will demonstrate proficiency in:
- Infrastructure as Code (Terraform)
- Configuration Management (Ansible)
- Containerization (Docker)
- Container Orchestration (Kubernetes/EKS)
- CI/CD Pipeline Design (Jenkins)
- Monitoring & Observability (Prometheus/Grafana)
- Cloud Platform Management (AWS)
- Security Best Practices
- Documentation & Communication

---

## 🎯 PROJECT PHASES

### PHASE 1: Infrastructure Provisioning (Week 1)

#### Tasks:
1. **AWS Account Setup**
   - Create/use AWS account
   - Set up IAM users with appropriate permissions
   - Configure AWS CLI and credentials

2. **Terraform Infrastructure**
   Create Terraform modules for:
   - [ ] VPC with public and private subnets across 2 AZs
   - [ ] Internet Gateway and NAT Gateways
   - [ ] Route tables and associations
   - [ ] Security groups (web, app, database layers)
   - [ ] RDS PostgreSQL instance (Multi-AZ for production)
   - [ ] ElastiCache Redis cluster
   - [ ] S3 bucket for application uploads
   - [ ] Application Load Balancer
   - [ ] Target groups
   - [ ] EC2 launch templates (for initial deployment)
   - [ ] IAM roles and policies

3. **State Management**
   - [ ] Configure S3 backend for Terraform state
   - [ ] Set up DynamoDB table for state locking
   - [ ] Implement workspaces for staging/production

#### Deliverables:
- `terraform/` directory with modular code
- `README.md` with terraform commands
- Architecture diagram (draw.io or Lucidchart)
- Cost estimation spreadsheet

#### Evaluation Criteria:
- Code organization and modularity (25%)
- Security best practices (25%)
- Documentation quality (25%)
- Resource optimization (25%)

---

### PHASE 2: Configuration Management (Week 1-2)

#### Tasks:
1. **Ansible Playbooks**
   Create playbooks for:
   - [ ] Web server configuration (Nginx)
   - [ ] Application server setup (Node.js)
   - [ ] Security hardening (firewall, fail2ban, SSH)
   - [ ] Monitoring agent installation (node_exporter)
   - [ ] Application deployment
   - [ ] Environment variable management

2. **Inventory Management**
   - [ ] Dynamic inventory using AWS EC2 plugin
   - [ ] Group variables for staging/production
   - [ ] Host variables for specific configurations

3. **Roles Organization**
   ```
   ansible/
   ├── playbooks/
   ├── roles/
   │   ├── common/
   │   ├── nginx/
   │   ├── nodejs/
   │   ├── security/
   │   └── monitoring/
   ├── inventory/
   └── group_vars/
   ```

#### Deliverables:
- Ansible playbooks and roles
- Inventory files
- Playbook execution logs
- Documentation on playbook usage

#### Evaluation Criteria:
- Idempotency of playbooks (30%)
- Error handling (20%)
- Security configurations (30%)
- Documentation (20%)

---

### PHASE 3: Containerization (Week 2)

#### Tasks:
1. **Docker Implementation**
   - [ ] Review and optimize provided Dockerfiles
   - [ ] Create docker-compose for local development
   - [ ] Implement multi-stage builds
   - [ ] Add health checks to containers
   - [ ] Configure proper logging

2. **Container Registry**
   - [ ] Set up Amazon ECR repositories
   - [ ] Implement image tagging strategy
   - [ ] Configure image scanning
   - [ ] Set up lifecycle policies

3. **Docker Best Practices**
   - [ ] Minimize image size
   - [ ] Use non-root users
   - [ ] Implement .dockerignore
   - [ ] Pin base image versions

#### Deliverables:
- Optimized Dockerfiles
- docker-compose.yml for local testing
- ECR repository documentation
- Image size comparison report

#### Evaluation Criteria:
- Image optimization (30%)
- Security practices (30%)
- Build efficiency (20%)
- Documentation (20%)

---

### PHASE 4: CI/CD Pipeline (Week 2-3)

#### Tasks:
1. **Jenkins Setup**
   - [ ] Install Jenkins (on EC2 or ECS)
   - [ ] Configure necessary plugins
   - [ ] Set up credentials management
   - [ ] Configure webhook integration with GitHub

2. **Pipeline Stages**
   Create Jenkinsfile with stages:
   ```groovy
   - Checkout
   - Install Dependencies
   - Run Tests (Unit + Integration)
   - Security Scanning (OWASP, Trivy)
   - Build Docker Images
   - Push to ECR
   - Deploy to Staging (Automatic)
   - Manual Approval Gate
   - Deploy to Production
   - Post-Deployment Tests
   - Slack/Email Notifications
   ```

3. **Testing Integration**
   - [ ] Set up unit tests
   - [ ] Configure integration tests
   - [ ] Implement code quality checks (ESLint)
   - [ ] Add test coverage reports

4. **Deployment Automation**
   - [ ] Blue-Green or Rolling deployment
   - [ ] Automated rollback on failure
   - [ ] Health check verification

#### Deliverables:
- Jenkinsfile
- Test scripts
- Pipeline execution screenshots
- Build history and metrics

#### Evaluation Criteria:
- Pipeline completeness (30%)
- Testing coverage (25%)
- Security integration (25%)
- Documentation (20%)

---

### PHASE 5: Kubernetes Deployment (Week 3)

#### Tasks:
1. **EKS Cluster Setup**
   - [ ] Create EKS cluster using Terraform/eksctl
   - [ ] Configure node groups (on-demand + spot)
   - [ ] Set up kubectl access
   - [ ] Install AWS Load Balancer Controller

2. **Kubernetes Manifests**
   Create manifests for:
   - [ ] Deployments (backend, frontend)
   - [ ] Services (LoadBalancer, ClusterIP)
   - [ ] ConfigMaps for configuration
   - [ ] Secrets for sensitive data
   - [ ] Horizontal Pod Autoscaler
   - [ ] Ingress resources
   - [ ] PersistentVolumeClaims (if needed)

3. **Helm Charts (Bonus)**
   - [ ] Create Helm charts for the application
   - [ ] Implement values files for environments
   - [ ] Use Helm for deployment

4. **Advanced Features**
   - [ ] Network policies
   - [ ] Resource limits and requests
   - [ ] Liveness and readiness probes
   - [ ] Pod disruption budgets

#### Deliverables:
- k8s/ directory with all manifests
- Helm charts (if implemented)
- Cluster architecture diagram
- Resource utilization analysis

#### Evaluation Criteria:
- Manifest completeness (30%)
- High availability design (25%)
- Resource optimization (25%)
- Documentation (20%)

---

### PHASE 6: Monitoring & Logging (Week 3-4)

#### Tasks:
1. **Prometheus Setup**
   - [ ] Deploy Prometheus in Kubernetes
   - [ ] Configure service discovery
   - [ ] Set up metrics collection
   - [ ] Create recording rules
   - [ ] Implement alerting rules

2. **Grafana Dashboards**
   Create dashboards for:
   - [ ] Application metrics (requests, latency, errors)
   - [ ] Infrastructure metrics (CPU, memory, disk)
   - [ ] Database performance
   - [ ] Redis cache statistics
   - [ ] Business metrics (orders, revenue)

3. **Logging Solution**
   Option A: ELK Stack
   - [ ] Deploy Elasticsearch
   - [ ] Configure Logstash/Fluentd
   - [ ] Set up Kibana
   
   Option B: CloudWatch Logs
   - [ ] Configure log groups
   - [ ] Set up log insights queries
   - [ ] Create CloudWatch dashboards

4. **Alerting**
   - [ ] Critical alerts (system down, database unreachable)
   - [ ] Warning alerts (high CPU, memory pressure)
   - [ ] Set up notification channels (Slack/Email)
   - [ ] Create on-call rotation

#### Deliverables:
- Prometheus configuration
- Grafana dashboard JSON exports
- Alert rule definitions
- Runbook for common alerts

#### Evaluation Criteria:
- Monitoring completeness (30%)
- Dashboard design (25%)
- Alert quality (25%)
- Documentation (20%)

---

### PHASE 7: Security & Compliance (Week 4)

#### Tasks:
1. **Security Implementation**
   - [ ] Secrets management (AWS Secrets Manager/Vault)
   - [ ] SSL/TLS certificates (ACM + cert-manager)
   - [ ] Network security (security groups, NACLs)
   - [ ] IAM best practices (least privilege)
   - [ ] Encryption at rest and in transit

2. **Security Scanning**
   - [ ] Container image scanning (Trivy/Clair)
   - [ ] Dependency scanning (OWASP Dependency Check)
   - [ ] Infrastructure scanning (tfsec)
   - [ ] Compliance checks (CIS benchmarks)

3. **Backup & DR**
   - [ ] Database backup strategy
   - [ ] Application state backup
   - [ ] Disaster recovery plan
   - [ ] RTO/RPO documentation

#### Deliverables:
- Security assessment report
- Backup/restore procedures
- Disaster recovery plan
- Compliance checklist

#### Evaluation Criteria:
- Security implementation (40%)
- DR planning (30%)
- Documentation (30%)

---

## 🎬 FINAL DELIVERABLES

### 1. Code Repository
GitHub repository with:
- All infrastructure code (Terraform, Ansible)
- Application code with Dockerfiles
- Kubernetes manifests
- CI/CD pipeline definitions
- Documentation

### 2. Documentation Package
- Architecture diagrams (network, application, data flow)
- Setup and deployment guide
- Runbooks for common operations
- Troubleshooting guide
- Cost analysis and optimization report
- Security assessment
- Disaster recovery plan

### 3. Live Demo
15-20 minute presentation demonstrating:
- Infrastructure walkthrough
- CI/CD pipeline execution
- Application functionality
- Monitoring dashboards
- Incident response simulation
- Q&A session

### 4. Video Recording
- 5-10 minute recorded demo
- Architecture explanation
- Pipeline demonstration
- Challenges and solutions discussion

---

## 📊 GRADING RUBRIC

| Component | Weight | Criteria |
|-----------|--------|----------|
| Infrastructure (Terraform) | 20% | Code quality, modularity, security |
| Configuration (Ansible) | 15% | Automation, idempotency, documentation |
| Containerization | 10% | Optimization, security, best practices |
| CI/CD Pipeline | 20% | Completeness, testing, security scanning |
| Kubernetes Deployment | 15% | HA design, resource management, scaling |
| Monitoring & Logging | 10% | Coverage, dashboard quality, alerting |
| Security | 10% | Implementation, compliance, best practices |

---

## 🚨 CHALLENGE SCENARIOS

During Week 3-4, instructor will introduce:

### Scenario 1: Requirement Change (Day 10)
"Business wants to add a new microservice for product recommendations"
- Students must: Add new service, update pipeline, deploy without downtime

### Scenario 2: Security Audit (Day 12)
"Security team found vulnerabilities"
- Students must: Implement additional security controls, rescan, document

### Scenario 3: Cost Overrun (Day 14)
"AWS bill is 30% over budget"
- Students must: Analyze costs, optimize resources, implement cost controls

### Scenario 4: Production Incident (Day 18)
"Database performance degradation"
- Students must: Investigate, resolve, create postmortem, implement preventions

---

## 💰 BUDGET CONSTRAINTS

- **AWS Budget**: $50 USD total
- Must optimize for cost while maintaining functionality
- Use t3.micro/small instances
- Consider spot instances
- Implement auto-scaling
- Document all cost-saving measures

**Tips for staying within budget:**
- Stop resources when not in use
- Use AWS Free Tier where possible
- Right-size instances
- Clean up unused resources daily
- Set up billing alerts

---

## 📅 WEEKLY CHECKPOINTS

### Week 1 Check-in (Friday)
- Terraform infrastructure deployed
- Ansible playbooks functional
- Documentation updated

### Week 2 Check-in (Friday)
- Containers built and pushed to ECR
- CI/CD pipeline running
- Initial Kubernetes deployment

### Week 3 Check-in (Friday)
- Monitoring in place
- Security controls implemented
- Load testing completed

### Week 4 Final (End of week)
- All deliverables submitted
- Live demo scheduled
- Peer review session

---

## 🏆 BONUS POINTS

Extra credit opportunities (5% each, max 15%):
- [ ] Implement GitOps with ArgoCD/Flux
- [ ] Add service mesh (Istio/Linkerd)
- [ ] Implement chaos engineering tests
- [ ] Create comprehensive API documentation (Swagger)
- [ ] Add performance testing (k6/JMeter)
- [ ] Implement feature flags
- [ ] Multi-region deployment

---

## 🤝 COLLABORATION GUIDELINES

- Work individually or in pairs
- All code must be in version control
- Document individual contributions
- Daily standup (async via Slack)
- Help others but don't share solutions
- Instructor office hours: Mon/Wed 4-6 PM

---

## 📞 SUPPORT CHANNELS

- **Slack**: #devops-project
- **Email**: john.prexy@bloomy360.com
- **Office Hours**: Monday/Wednesday 4-6 PM
- **Emergency**: +234-XXX-XXX-XXXX

---

## ✅ SUBMISSION CHECKLIST

Before final submission, ensure:
- [ ] All code pushed to GitHub with descriptive commits
- [ ] README.md in root directory with setup instructions
- [ ] All services running and accessible
- [ ] Monitoring dashboards created
- [ ] Documentation complete
- [ ] Cost analysis included
- [ ] Security checklist completed
- [ ] Demo video uploaded
- [ ] Presentation slides prepared

---

**Project Start Date**: [Insert Date]  
**Final Submission**: [Insert Date]  
**Demo Presentations**: [Insert Date]

---

## 🎓 LEARNING OUTCOMES MAPPING

This project maps to the following Bloomy Technologies curriculum outcomes:
- DevOps-301: Infrastructure as Code
- DevOps-302: Container Orchestration
- DevOps-303: CI/CD Pipelines
- DevOps-304: Cloud Platform Management
- DevOps-305: Monitoring & Observability
- DevOps-306: Security & Compliance

---

**Good luck, and remember: The goal is to learn and build something you're proud of!**

---

*Bloomy Technologies LTD - Training Tomorrow's Tech Leaders*
