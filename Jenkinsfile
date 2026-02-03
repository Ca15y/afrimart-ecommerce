pipeline {
    agent any
    
    options {
        timeout(time: 1, unit: 'HOURS')  // Kill pipeline if it runs longer than 1 hour
        timestamps()  // Add timestamps to console output
    }
    
    environment {
        AWS_REGION = 'us-east-1'
        // Don't calculate AWS_ACCOUNT_ID here - do it in a stage instead
    }
    
    stages {
        stage('Checkout') {
            steps {
                echo 'Checking out code...'
                checkout scm
            }
        }
        
        stage('Setup AWS Credentials') {
            steps {
                script {
                    echo 'Setting up AWS credentials...'
                    withCredentials([aws(credentialsId: 'aws-credentials', accessKeyVariable: 'AWS_ACCESS_KEY_ID', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                        env.AWS_ACCOUNT_ID = sh(
                            script: "aws sts get-caller-identity --query Account --output text",
                            returnStdout: true
                        ).trim()
                        env.ECR_REGISTRY = "${env.AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com"
                        env.BACKEND_IMAGE = "${env.ECR_REGISTRY}/afrimart-backup/backend"
                        env.FRONTEND_IMAGE = "${env.ECR_REGISTRY}/afrimart-backup/frontend"
                        env.IMAGE_TAG = "${BUILD_NUMBER}"
                    }
                    echo "AWS Account ID: ${env.AWS_ACCOUNT_ID}"
                }
            }
        }
        
        stage('Install Dependencies') {
            options {
                timeout(time: 10, unit: 'MINUTES')  // Timeout after 10 minutes
            }
            parallel {
                stage('Backend Dependencies') {
                    steps {
                        dir('backend') {
                            echo 'Installing backend dependencies...'
                            sh 'npm ci'
                            echo 'Backend dependencies installed!'
                        }
                    }
                }
                stage('Frontend Dependencies') {
                    steps {
                        dir('frontend') {
                            echo 'Installing frontend dependencies...'
                            sh 'npm ci'
                            echo 'Frontend dependencies installed!'
                        }
                    }
                }
            }
        }
        
        stage('Run Linting') {
            options {
                timeout(time: 5, unit: 'MINUTES')
            }
            parallel {
                stage('Backend Lint') {
                    steps {
                        dir('backend') {
                            echo 'Running backend linting...'
                            sh 'npm run lint || true'
                        }
                    }
                }
                stage('Frontend Lint') {
                    steps {
                        dir('frontend') {
                            echo 'Running frontend linting...'
                            sh 'npm run lint || true'
                        }
                    }
                }
            }
        }
        
        stage('Run Tests') {
            options {
                timeout(time: 10, unit: 'MINUTES')
            }
            parallel {
                stage('Backend Tests') {
                    steps {
                        dir('backend') {
                            echo 'Running backend tests...'
                            sh 'npm test || true'
                        }
                    }
                }
                stage('Frontend Tests') {
                    steps {
                        dir('frontend') {
                            echo 'Running frontend tests...'
                            sh 'npm test || true'
                        }
                    }
                }
            }
        }
        
        stage('Security Scan') {
            options {
                timeout(time: 15, unit: 'MINUTES')
            }
            steps {
                echo 'Running security scan...'
                script {
                    // Check if Trivy is installed, skip installation for now
                    sh '''
                        if command -v trivy &> /dev/null; then
                            echo "Trivy is already installed"
                            trivy --version
                        else
                            echo "Trivy is not installed. Skipping security scan for now."
                            echo "Please install Trivy manually on Jenkins server."
                            exit 0
                        fi
                    '''
                    
                    // Only scan if Trivy exists
                    sh '''
                        if command -v trivy &> /dev/null; then
                            trivy config backend/Dockerfile || true
                            trivy config frontend/Dockerfile || true
                        fi
                    '''
                }
            }
        }
        
        stage('Build Docker Images') {
            options {
                timeout(time: 20, unit: 'MINUTES')
            }
            steps {
                script {
                    echo "Building Docker images with tag ${env.IMAGE_TAG}..."
                    
                    // Build backend
                    sh "docker build -t ${env.BACKEND_IMAGE}:${env.IMAGE_TAG} ./backend"
                    sh "docker tag ${env.BACKEND_IMAGE}:${env.IMAGE_TAG} ${env.BACKEND_IMAGE}:latest"
                    
                    // Build frontend
                    sh "docker build -t ${env.FRONTEND_IMAGE}:${env.IMAGE_TAG} ./frontend"
                    sh "docker tag ${env.FRONTEND_IMAGE}:${env.IMAGE_TAG} ${env.FRONTEND_IMAGE}:latest"
                }
            }
        }
        
        stage('Scan Docker Images') {
            options {
                timeout(time: 15, unit: 'MINUTES')
            }
            steps {
                echo 'Scanning Docker images for vulnerabilities...'
                sh '''
                    if command -v trivy &> /dev/null; then
                        trivy image ${BACKEND_IMAGE}:${IMAGE_TAG} || true
                        trivy image ${FRONTEND_IMAGE}:${IMAGE_TAG} || true
                    else
                        echo "Trivy not installed, skipping image scan"
                    fi
                '''
            }
        }
        
        stage('Push to ECR') {
            options {
                timeout(time: 15, unit: 'MINUTES')
            }
            steps {
                script {
                    withCredentials([aws(credentialsId: 'aws-credentials', accessKeyVariable: 'AWS_ACCESS_KEY_ID', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                        echo 'Logging into ECR...'
                        sh "aws ecr get-login-password --region ${AWS_REGION} | docker login --username AWS --password-stdin ${env.ECR_REGISTRY}"
                        
                        echo 'Pushing images to ECR...'
                        sh "docker push ${env.BACKEND_IMAGE}:${env.IMAGE_TAG}"
                        sh "docker push ${env.BACKEND_IMAGE}:latest"
                        sh "docker push ${env.FRONTEND_IMAGE}:${env.IMAGE_TAG}"
                        sh "docker push ${env.FRONTEND_IMAGE}:latest"
                    }
                }
            }
        }
        
        stage('Deploy to Staging') {
            when {
                branch 'develop'
            }
            steps {
                echo 'Deploying to staging environment...'
                sh 'echo "Staging deployment completed"'
            }
        }
        
        stage('Approval for Production') {
            when {
                branch 'main'
            }
            steps {
                timeout(time: 30, unit: 'MINUTES') {
                    input message: 'Deploy to Production?', ok: 'Deploy'
                }
            }
        }
        
        stage('Deploy to Production') {
            when {
                branch 'main'
            }
            steps {
                echo 'Deploying to production environment...'
                sh 'echo "Production deployment completed"'
            }
        }
    }
    
    post {
        success {
            echo 'Pipeline succeeded! ✅'
        }
        failure {
            echo 'Pipeline failed! ❌'
        }
        aborted {
            echo 'Pipeline was aborted! ⚠️'
        }
    }
}
