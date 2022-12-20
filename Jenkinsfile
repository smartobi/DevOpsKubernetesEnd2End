node {
    
    stage("Git CheckOut Stage"){
        git branch: 'main', url: 'https://github.com/smartobi/DevOpsKubernetesEnd2End.git'
    }
    
    stage("Sending docker file to Ansible serve over SSH"){
        sshagent(['ansible_demo']) {
        sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.73.46'
        sh 'scp /var/lib/jenkins/workspace/pipeline-consultant/* ubuntu@172.31.73.46:/home/ubuntu'
         }
    }
    stage("Docker Build images"){
        sshagent(['ansible_demo']) {
        sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.73.46 cd /home/ubuntu/'
        sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.73.46 docker image build -t $JOB_NAME:v1.$BUILD_ID .'
        
        }
    }
    stage("Docker image tagging"){
        sshagent(['ansible_demo']) {
        sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.73.46 docker image tag $JOB_NAME:v1.$BUILD_ID smartcloud2022/$JOB_NAME:v1.$BUILD_ID'
        sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.73.46 docker image tag $JOB_NAME:v1.$BUILD_ID smartcloud2022/$JOB_NAME:latest'
        }
    }
    
     stage("Push Docker image to Docker Registry"){
          sshagent(['ansible_demo']) {
              withCredentials([string(credentialsId: 'dockerhub_pass', variable: 'dockerhub_pass')]) {
                sh "ssh -o StrictHostKeyChecking=no ubuntu@172.31.73.46 docker login -u smartcloud2022 -p ${dockerhub_pass}"
                sh "ssh -o StrictHostKeyChecking=no ubuntu@172.31.73.46 docker image push smartcloud2022/$JOB_NAME:v1.$BUILD_ID "
                sh "ssh -o StrictHostKeyChecking=no ubuntu@172.31.73.46 docker image push smartcloud2022/$JOB_NAME:latest"
              }
          }
     }
     stage("Delete Image from Local Repo"){
          sshagent(['ansible_demo']) {
        sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.73.46 docker rmi $JOB_NAME:v1.$BUILD_ID'
        sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.73.46 docker rmi smartcloud2022/$JOB_NAME:v1.$BUILD_ID'
        sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.73.46 docker rmi smartcloud2022/$JOB_NAME:latest' 
          }
     }
     
     stage("Copy files from ansible to Kubernetes server"){
         sshagent(['ansible_demo']) {
             sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.73.46'
             sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.73.46 kubectl apply -f Deployment.yml'
             sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.73.46 kubectl apply -f Service.yml'
             sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.73.46 kubectl get service '
             sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.73.46 kubectl get node -o wide'
         }
     }
    
   
}