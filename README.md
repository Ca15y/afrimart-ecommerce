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


