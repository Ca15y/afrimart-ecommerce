# AfriMart E-Commerce Platform

A full-stack e-commerce application built for DevOps deployment practice.

## Architecture

```
┌─────────────┐     ┌──────────────┐     ┌─────────────┐
│   React     │────▶│   Node.js    │────▶│ PostgreSQL  │
│  Frontend   │     │   Backend    │     │  Database   │
└─────────────┘     └──────────────┘     └─────────────┘
                           │
                           ├────▶ Redis (Cache + Sessions)
                           │
                           └────▶ Bull Queue (Background Jobs)
                           │
                           └────▶ S3 (File Storage)
```

## Features

- User authentication & authorization
- Product catalog with search
- Shopping cart management
- Order processing
- Admin dashboard
- Email notifications
- Image upload for products
- Redis caching for performance
- Background job processing
- RESTful API

## Tech Stack

### Frontend
- React 18
- React Router
- Axios
- Tailwind CSS
- Context API for state management

### Backend
- Node.js with Express
- PostgreSQL with Sequelize ORM
- Redis for caching and sessions
- Bull for job queues
- JWT authentication
- Nodemailer for emails
- Multer for file uploads
- Winston for logging

### DevOps Requirements
- Docker & Docker Compose
- Nginx reverse proxy
- Environment-based configuration
- Health check endpoints
- Prometheus metrics endpoint
- Structured logging

## Quick Start

### Prerequisites
- Node.js 18+
- PostgreSQL 14+
- Redis 6+
- Docker & Docker Compose

### Local Development

1. Clone the repository
2. Copy environment files:
   ```bash
   cp backend/.env.example backend/.env
   cp frontend/.env.example frontend/.env
   ```

3. Start with Docker Compose:
   ```bash
   docker-compose up -d
   ```

4. Access the application:
   - Frontend: http://localhost:3000
   - Backend API: http://localhost:5000
   - API Docs: http://localhost:5000/api-docs

### Manual Setup

#### Backend
```bash
cd backend
npm install
npm run migrate
npm run seed
npm run dev
```

#### Frontend
```bash
cd frontend
npm install
npm start
```

## Environment Variables

### Backend (.env)
```
NODE_ENV=development
PORT=5000
DATABASE_URL=postgresql://user:password@localhost:5432/afrimart
REDIS_URL=redis://localhost:6379
JWT_SECRET=your-secret-key
AWS_ACCESS_KEY_ID=your-key
AWS_SECRET_ACCESS_KEY=your-secret
AWS_REGION=us-east-1
AWS_S3_BUCKET=afrimart-uploads
SMTP_HOST=smtp.gmail.com
SMTP_PORT=587
SMTP_USER=your-email
SMTP_PASS=your-password
```

### Frontend (.env)
```
REACT_APP_API_URL=http://localhost:5000/api
```

## API Endpoints

### Authentication
- POST `/api/auth/register` - Register new user
- POST `/api/auth/login` - Login user
- GET `/api/auth/me` - Get current user

### Products
- GET `/api/products` - List products
- GET `/api/products/:id` - Get product details
- POST `/api/products` - Create product (Admin)
- PUT `/api/products/:id` - Update product (Admin)
- DELETE `/api/products/:id` - Delete product (Admin)

### Cart
- GET `/api/cart` - Get cart
- POST `/api/cart` - Add to cart
- PUT `/api/cart/:id` - Update cart item
- DELETE `/api/cart/:id` - Remove from cart

### Orders
- POST `/api/orders` - Create order
- GET `/api/orders` - List user orders
- GET `/api/orders/:id` - Get order details

### Health & Metrics
- GET `/health` - Health check
- GET `/metrics` - Prometheus metrics

## Database Schema

### Users
- id, email, password_hash, first_name, last_name, role, created_at

### Products
- id, name, description, price, category, stock, image_url, created_at

### Orders
- id, user_id, total_amount, status, created_at

### OrderItems
- id, order_id, product_id, quantity, price

### Cart
- id, user_id, product_id, quantity, created_at

## Testing

```bash
# Backend tests
cd backend
npm test

# Frontend tests
cd frontend
npm test
```

## Deployment Considerations

1. **Database Migration**: Run migrations before deployment
2. **Redis**: Required for sessions and job queue
3. **File Storage**: Configure S3 or use local storage
4. **Email**: Configure SMTP for order confirmations
5. **Secrets**: Never commit .env files
6. **Scaling**: Backend is stateless and can scale horizontally

## Monitoring

- Health check: `/health`
- Metrics: `/metrics` (Prometheus format)
- Logs: JSON format via Winston

## License

MIT - Educational purposes for Bloomy Technologies LTD
