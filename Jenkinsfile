pipeline {
  agent any
  stages {
     stage('para') {
           parallel {
			stage('Build Api') {
			  steps {
				   sh 'cd spring-petclinic-rest && nohup mvn spring-boot:run &'
					
				  }
				} 
			stage('Build Angular') {
				steps {
					sh 'cd spring-petclinic-angular/static-content && curl https://jcenter.bintray.com/com/athaydes/rawhttp/rawhttp-cli/1.0/rawhttp-cli-1.0-all.jar -o rawhttp.jar && nohup java -jar ./rawhttp.jar serve . -p 4200 &'
					sleep(3)
				  }
				 
			  }
    
			stage('newman') {
						steps {
						   sleep(20)
							sh 'newman run  petclinic.collection.json --environment petclinic.environment.json --reporters junit'
						}
						post {
							always {
									junit '**/*xml'
								}
							}
					}
           }
	}
 }
}
