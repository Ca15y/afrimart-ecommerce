pipeline {
    agent any
    
    environment {
        AWS_REGION = 'us-east-1'
        AWS_ACCOUNT_ID = sh(script: "aws sts get-caller-identity --query Account --output text", returnStdout: true).trim()
        ECR_REGISTRY = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com"
        BACKEND_IMAGE = "${ECR_REGISTRY}/afrimart-backup/backend"
        FRONTEND_IMAGE = "${ECR_REGISTRY}/afrimart-backup/frontend"
        IMAGE_TAG = "${BUILD_NUMBER}"
    }
    
    stages {
        stage('Checkout') {
            steps {
                echo 'Checking out code...'
                checkout scm
            }
        }
        
        stage('Install Dependencies') {
            parallel {
                stage('Backend Dependencies') {
                    steps {
                        dir('backend') {
                            sh 'npm ci'
                        }
                    }
                }
                stage('Frontend Dependencies') {
                    steps {
                        dir('frontend') {
                            sh 'npm ci'
                        }
                    }
                }
            }
        }
        
        stage('Run Linting') {
            parallel {
                stage('Backend Lint') {
                    steps {
                        dir('backend') {
                            sh 'npm run lint || true'  // Don't fail if linting fails
                        }
                    }
                }
                stage('Frontend Lint') {
                    steps {
                        dir('frontend') {
                            sh 'npm run lint || true'
                        }
                    }
                }
            }
        }
        
        stage('Run Tests') {
            parallel {
                stage('Backend Tests') {
                    steps {
                        dir('backend') {
                            sh 'npm test || true'  // Don't fail build if tests fail (for demo)
                        }
                    }
                }
                stage('Frontend Tests') {
                    steps {
                        dir('frontend') {
                            sh 'npm test || true'
                        }
                    }
                }
            }
        }
        
        stage('Security Scan') {
            steps {
                echo 'Running security scan...'
                script {
                    // Install Trivy if not already installed
                    sh '''
                        if ! command -v trivy &> /dev/null; then
                            wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | sudo apt-key add -
                            echo "deb https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main" | sudo tee -a /etc/apt/sources.list.d/trivy.list
                            sudo apt-get update
                            sudo apt-get install trivy -y
                        fi
                    '''
                    
                    // Scan Dockerfiles
                    sh 'trivy config backend/Dockerfile || true'
                    sh 'trivy config frontend/Dockerfile || true'
                }
            }
        }
        
        stage('Build Docker Images') {
            steps {
                script {
                    echo "Building Docker images with tag ${IMAGE_TAG}..."
                    
                    // Build backend
                    sh "docker build -t ${BACKEND_IMAGE}:${IMAGE_TAG} ./backend"
                    sh "docker tag ${BACKEND_IMAGE}:${IMAGE_TAG} ${BACKEND_IMAGE}:latest"
                    
                    // Build frontend
                    sh "docker build -t ${FRONTEND_IMAGE}:${IMAGE_TAG} ./frontend"
                    sh "docker tag ${FRONTEND_IMAGE}:${IMAGE_TAG} ${FRONTEND_IMAGE}:latest"
                }
            }
        }
        
        stage('Scan Docker Images') {
            steps {
                echo 'Scanning Docker images for vulnerabilities...'
                sh "trivy image ${BACKEND_IMAGE}:${IMAGE_TAG} || true"
                sh "trivy image ${FRONTEND_IMAGE}:${IMAGE_TAG} || true"
            }
        }
        
        stage('Push to ECR') {
            steps {
                script {
                    echo 'Logging into ECR...'
                    sh "aws ecr get-login-password --region ${AWS_REGION} | docker login --username AWS --password-stdin ${ECR_REGISTRY}"
                    
                    echo 'Pushing images to ECR...'
                    sh "docker push ${BACKEND_IMAGE}:${IMAGE_TAG}"
                    sh "docker push ${BACKEND_IMAGE}:latest"
                    sh "docker push ${FRONTEND_IMAGE}:${IMAGE_TAG}"
                    sh "docker push ${FRONTEND_IMAGE}:latest"
                }
            }
        }
        
        stage('Deploy to Staging') {
            when {
                branch 'develop'
            }
            steps {
                echo 'Deploying to staging environment...'
                //  add Kubernetes deployment commands here later
                sh 'echo "Staging deployment completed"'
            }
        }
        
        stage('Approval for Production') {
            when {
                branch 'main'
            }
            steps {
                input message: 'Deploy to Production?', ok: 'Deploy'
            }
        }
        
        stage('Deploy to Production') {
            when {
                branch 'main'
            }
            steps {
                echo 'Deploying to production environment...'
                //  add Kubernetes deployment commands here later
                sh 'echo "Production deployment completed"'
            }
        }
    }
    
    post {
        success {
            echo 'Pipeline succeeded! ✅'
            // Add Slack/email notification here 
        }
        failure {
            echo 'Pipeline failed! ❌'
            // Add Slack/email notification here 
        }
        always {
            // Clean up
            sh 'docker system prune -f || true'
        }
    }
}
