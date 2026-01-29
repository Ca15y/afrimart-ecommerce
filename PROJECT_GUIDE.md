# AfriMart E-Commerce - Complete DevOps Project
# Setup and Deployment Guide

## 📋 Project Overview

This is a production-ready, full-stack e-commerce application designed specifically for DevOps training. It includes all the components needed for a comprehensive CI/CD pipeline project.

## 🏗️ Architecture Components

### Backend (Node.js/Express)
- RESTful API with authentication
- PostgreSQL database with Sequelize ORM
- Redis for caching and sessions
- Bull queue for background jobs (email notifications)
- Prometheus metrics endpoint
- Structured logging with Winston
- Health check endpoints

### Frontend (React + Vite)
- Modern React 18 with Hooks
- Tailwind CSS for styling
- Axios for API communication
- Context API for state management
- Responsive design

### Infrastructure
- PostgreSQL 14
- Redis 7
- Docker & Docker Compose
- Nginx (optional reverse proxy)

## 🚀 Quick Start Guide

### Prerequisites
```bash
- Node.js 18+ and npm
- Docker and Docker Compose
- PostgreSQL 14+
- Redis 6+
- Git
```

### Option 1: Docker Compose (Recommended)

```bash
# 1. Clone/Download the project
cd afrimart-ecommerce

# 2. Create environment files
cp backend/.env.example backend/.env
cp frontend/.env.example frontend/.env

# 3. Start all services
docker-compose up -d

# 4. Run migrations and seed data (first time only)
docker-compose exec backend npm run migrate
docker-compose exec backend npm run seed

# 5. Access the application
# Frontend: http://localhost:3000
# Backend API: http://localhost:5000
# Health Check: http://localhost:5000/health
# Metrics: http://localhost:5000/metrics
```

### Option 2: Manual Setup

#### Backend Setup
```bash
cd backend

# Install dependencies
npm install

# Setup environment
cp .env.example .env
# Edit .env with your database credentials

# Run migrations
npm run migrate

# Seed sample data
npm run seed

# Start development server
npm run dev
```

#### Frontend Setup
```bash
cd frontend

# Install dependencies
npm install

# Setup environment
cp .env.example .env

# Start development server
npm run dev
```

## 📊 Sample Data

After seeding, you'll have:
- **Admin Account**: admin@afrimart.com / admin123
- **Test Customer**: customer@test.com / customer123
- **12 Sample Products** across different categories

## 🔐 API Endpoints Reference

### Authentication
- `POST /api/auth/register` - Create new user account
- `POST /api/auth/login` - Login and get JWT token
- `GET /api/auth/me` - Get current user (requires auth)
- `PUT /api/auth/profile` - Update user profile (requires auth)

### Products
- `GET /api/products` - List products (supports pagination, search, filters)
- `GET /api/products/:id` - Get single product
- `POST /api/products` - Create product (admin only)
- `PUT /api/products/:id` - Update product (admin only)
- `DELETE /api/products/:id` - Soft delete product (admin only)
- `GET /api/products/categories` - Get all categories

### Shopping Cart
- `GET /api/cart` - Get user's cart
- `POST /api/cart` - Add item to cart
- `PUT /api/cart/:id` - Update cart item quantity
- `DELETE /api/cart/:id` - Remove item from cart
- `DELETE /api/cart` - Clear entire cart

### Orders
- `POST /api/orders` - Create new order from cart
- `GET /api/orders` - Get user's orders
- `GET /api/orders/:id` - Get single order details
- `PUT /api/orders/:id/status` - Update order status (admin only)
- `GET /api/orders/admin/all` - Get all orders (admin only)

### System
- `GET /health` - Application health check
- `GET /metrics` - Prometheus metrics

## 🛠️ DevOps Integration Points

### For CI/CD Pipeline (Jenkins)

```groovy
// Example Jenkinsfile stages
pipeline {
    stages {
        stage('Test') {
            steps {
                sh 'cd backend && npm test'
                sh 'cd frontend && npm test'
            }
        }
        stage('Build Docker Images') {
            steps {
                sh 'docker build -t afrimart-backend:${BUILD_NUMBER} ./backend'
                sh 'docker build -t afrimart-frontend:${BUILD_NUMBER} ./frontend'
            }
        }
        stage('Push to ECR') {
            steps {
                // Push to Amazon ECR
            }
        }
        stage('Deploy to ECS/EKS') {
            steps {
                // Deploy containers
            }
        }
    }
}
```

### Terraform Resources Needed
- VPC with public/private subnets
- RDS PostgreSQL instance
- ElastiCache Redis cluster
- ECS/EKS cluster for containers
- Application Load Balancer
- S3 bucket for static assets
- Security groups and IAM roles

### Kubernetes Manifests
Create manifests for:
- Deployments (backend, frontend)
- Services (LoadBalancer/ClusterIP)
- ConfigMaps for configuration
- Secrets for sensitive data
- HPA for autoscaling
- Ingress for routing

### Monitoring Setup

**Prometheus Targets**:
```yaml
- job_name: 'afrimart-backend'
  static_configs:
    - targets: ['backend:5000']
  metrics_path: '/metrics'
```

**Grafana Dashboards**:
- HTTP request rates and latencies
- Database connection pool stats
- Redis cache hit rates
- Active users and sessions
- Order processing metrics

## 🧪 Testing the Application

### Backend API Tests
```bash
cd backend
npm test

# Test coverage
npm run test:coverage
```

### Frontend Tests
```bash
cd frontend
npm test
```

### Integration Testing
```bash
# Test end-to-end user flow
1. Register new user
2. Browse products
3. Add items to cart
4. Create order
5. Check order confirmation email (check logs)
```

## 📈 Performance Optimization

1. **Redis Caching**
   - Product listings cached for 5 minutes
   - Individual products cached for 10 minutes
   - Clear cache on product updates

2. **Database Indexing**
   - Product name, category indexed
   - User email indexed
   - Order status indexed

3. **CDN for Static Assets**
   - Configure S3 + CloudFront for images
   - Set appropriate cache headers

## 🔒 Security Checklist

- ✅ JWT authentication with secure secrets
- ✅ Password hashing with bcrypt
- ✅ Rate limiting on API endpoints
- ✅ Helmet.js for security headers
- ✅ CORS properly configured
- ✅ Input validation on all endpoints
- ✅ SQL injection prevention (Sequelize ORM)
- ✅ XSS protection
- ⚠️ HTTPS/TLS (configure in production)
- ⚠️ Secrets management (use AWS Secrets Manager in production)

## 📝 Environment Variables

### Backend (.env)
```
NODE_ENV=production
PORT=5000
DATABASE_URL=postgresql://user:pass@host:5432/db
REDIS_URL=redis://host:6379
JWT_SECRET=<generate-strong-secret>
AWS_ACCESS_KEY_ID=<your-key>
AWS_SECRET_ACCESS_KEY=<your-secret>
SMTP_HOST=smtp.gmail.com
SMTP_USER=<your-email>
SMTP_PASS=<app-password>
```

### Frontend (.env)
```
VITE_API_URL=https://api.yourdomain.com/api
```

## 🎯 Student Project Deliverables

Students should provide:

1. **Infrastructure Code**
   - Terraform modules for AWS resources
   - Ansible playbooks for configuration
   - Kubernetes manifests

2. **CI/CD Pipeline**
   - Jenkinsfile with all stages
   - Docker images pushed to ECR
   - Automated testing integration

3. **Documentation**
   - Architecture diagrams
   - Deployment runbook
   - Disaster recovery plan
   - Cost analysis

4. **Monitoring Setup**
   - Prometheus/Grafana dashboards
   - Alert rules configuration
   - Log aggregation (ELK/CloudWatch)

5. **Live Demo**
   - Working application in staging/production
   - Pipeline demonstration
   - Incident response simulation

## 🐛 Troubleshooting

### Database Connection Issues
```bash
# Check PostgreSQL is running
docker-compose ps postgres

# Check logs
docker-compose logs postgres

# Test connection
psql postgresql://afrimart:afrimart123@localhost:5432/afrimart
```

### Redis Connection Issues
```bash
# Check Redis is running
docker-compose ps redis

# Test connection
redis-cli ping
```

### Backend Not Starting
```bash
# Check logs
docker-compose logs backend

# Common issues:
# - Missing .env file
# - Database not ready
# - Port 5000 already in use
```

## 📚 Additional Resources

- [Express.js Documentation](https://expressjs.com/)
- [React Documentation](https://react.dev/)
- [PostgreSQL Documentation](https://www.postgresql.org/docs/)
- [Docker Documentation](https://docs.docker.com/)
- [Kubernetes Documentation](https://kubernetes.io/docs/)
- [Terraform AWS Provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)

## 🤝 Support

For Bloomy Technologies students:
- Slack channel: #devops-project-support
- Office hours: Contact your instructor
- Email: support@bloomy360.com

---

**Project maintained by Bloomy Technologies LTD**
**For educational purposes - DevOps Training Program**
