pipeline {
  agent {
    dockerfile {
      filename 'Dockerfile'
    }
    
  }
  stages {
    stage('Build') {
      steps {
        sh 'docker build -t alpine-salt-master .'
        echo 'build success'
      }
    }
  }
  environment {
    RUN = 'echo "a"'
  }
}