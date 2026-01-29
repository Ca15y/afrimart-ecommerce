# 🚀 QUICK START GUIDE
## Get AfriMart Running in 5 Minutes

### Prerequisites Check
```bash
# Verify installations
node --version  # Should be v18 or higher
docker --version
docker-compose --version
git --version
```

### Step 1: Get the Code
```bash
# If you have the ZIP file
unzip afrimart-ecommerce.zip
cd afrimart-ecommerce

# Or clone from repository
git clone <your-repo-url>
cd afrimart-ecommerce
```

### Step 2: Environment Setup
```bash
# Backend environment
cp backend/.env.example backend/.env

# Frontend environment  
cp frontend/.env.example frontend/.env

# No need to edit for local development - defaults work!
```

### Step 3: Start Everything
```bash
# Start all services with Docker Compose
docker-compose up -d

# Wait 30 seconds for services to be healthy
```

### Step 4: Initialize Database
```bash
# Run migrations
docker-compose exec backend npm run migrate

# Seed sample data
docker-compose exec backend npm run seed
```

### Step 5: Access the Application

✅ **Frontend**: http://localhost:3000  
✅ **Backend API**: http://localhost:5000  
✅ **Health Check**: http://localhost:5000/health  
✅ **Metrics**: http://localhost:5000/metrics  

### Test Login Credentials

**Admin Account**
- Email: `admin@afrimart.com`
- Password: `admin123`

**Customer Account**
- Email: `customer@test.com`
- Password: `customer123`

### Verify Everything is Working

```bash
# Check all containers are running
docker-compose ps

# Should see:
# ✓ afrimart-postgres (healthy)
# ✓ afrimart-redis (healthy)
# ✓ afrimart-backend (healthy)
# ✓ afrimart-frontend (healthy)

# Test the API
curl http://localhost:5000/health

# Should return: {"status":"healthy",...}
```

### Common Commands

```bash
# View logs
docker-compose logs -f backend
docker-compose logs -f frontend

# Stop all services
docker-compose down

# Start services
docker-compose up -d

# Rebuild after code changes
docker-compose up -d --build

# Remove everything (including data)
docker-compose down -v
```

### Troubleshooting

**Database connection error?**
```bash
# Reset the database
docker-compose down -v
docker-compose up -d
# Wait 30 seconds
docker-compose exec backend npm run migrate
docker-compose exec backend npm run seed
```

**Port already in use?**
```bash
# Change ports in docker-compose.yml
# Frontend: "3001:80" instead of "3000:80"
# Backend: "5001:5000" instead of "5000:5000"
```

**Cannot connect to API?**
```bash
# Check backend logs
docker-compose logs backend

# Verify backend is running
curl http://localhost:5000/health
```

### Next Steps

1. ✅ Explore the API endpoints (see PROJECT_GUIDE.md)
2. ✅ Review the code structure
3. ✅ Read the STUDENT_ASSIGNMENT.md
4. ✅ Start working on your DevOps tasks!

### Need Help?

- 📚 Read the full PROJECT_GUIDE.md
- 📋 Check STUDENT_ASSIGNMENT.md for detailed tasks
- 💬 Ask in Slack: #devops-project
- 📧 Email: john.prexy@bloomy360.com

---

**Happy Learning! 🎓**
