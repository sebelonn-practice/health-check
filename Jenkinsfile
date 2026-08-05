pipeline {
    agent any

    environment {
        BRANCH_TYPE = "${env.BRANCH_NAME == 'ec2-development' ? 'development' :
                       env.BRANCH_NAME == 'ec2-staging' ? 'staging' :
                       env.BRANCH_NAME == 'main' ? 'production' : 'other'}"
    }

    stages {
        stage('Prepare') {
            steps {
                echo "Branch: ${env.BRANCH_NAME}"
                echo "Branch Type: ${env.BRANCH_TYPE}"
            }
        }

        stage('Validate Scripts') {
            steps {
                sh '''
                    cd scripts
                    echo "=== Script Validation for ${BRANCH_TYPE} ==="
                    for script in *.sh; do
                        if [ -f "$script" ]; then
                            bash -n "$script" && echo "OK: $script" || echo "ERROR: $script"
                        fi
                    done
                '''
            }
        }

        stage('Test Scripts') {
            steps {
                sh '''
                    cd scripts
                    chmod +x *.sh
                    echo "=== Running scripts on ${BRANCH_TYPE} ==="
                    ./system-info.sh
                    ./health-check.sh
                '''
            }
        }

        stage('Deploy to Development') {
            when {
                branch 'ec2-development'
            }
            steps {
                echo "Deploying to development environment"
            }
        }

        stage('Deploy to Staging') {
            when {
                branch 'ec2-staging'
            }
            steps {
                echo "Deploying to staging environment"
            }
        }

        stage('Deploy to Production') {
            when {
                branch 'main'
            }
            steps {
                echo "Deploying to production environment"
            }
        }
    }

    post {
        always {
            echo "Pipeline completed for branch: ${env.BRANCH_NAME}"
        }
    }
}
