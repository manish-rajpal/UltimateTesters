pipeline {
  agent any
  stages {
     stage('parallel') {
           parallel {
			stage('Build Rest Api') {
			  steps {
				   sh 'cd spring-petclinic-rest && nohup mvn spring-boot:run &'
					
				  }
				} 
			stage('Build Angular Server') {
				steps {
					sh 'cd spring-petclinic-angular/static-content && curl https://jcenter.bintray.com/com/athaydes/rawhttp/rawhttp-cli/1.0/rawhttp-cli-1.0-all.jar -o rawhttp.jar && nohup java -jar ./rawhttp.jar serve . -p 4200 &'
					sleep(3)
				  }
				 
			  }
		   	stage('Robot') {
					steps {
						sleep(60)
						sh 'robot --variable BROWSER:headlesschrome -d /RobotFrameWork/Results RobotFrameWork/Tests/Veterinarians.robot RobotFrameWork/Tests/owner.robot RobotFrameWork/Tests/special-types.robot'
						   
							
						}
						post {
							always {
								script {
									step(
										[
											$class                  :   'RobotPublisher',
											outputPath              :   'RobotFrameWork/Results',
											outputFileName          :   '**/output.xml',
											reportFileName          :   '**/report.html',
											logFileName             :   '**/log.html',
											disableArchiveOutput    :   false,
											passThreshold           :   100,
											unstableThreshold       :   40,
											otherFiles              :   "**/*.png,**/*.jpg",
										]
									)
								}
							}
						}
				 }
    
			stage('Newman') {
						steps {
						   sleep(20)
							sh 'newman run  petclinic.collection.json --environment petclinic.environment.json --reporters junit'
							sh 'newman run  petclinic.collection.json --environment petclinic.environment.json '
						}
						post {
							always {
									junit '**/*xml'
								}
							}

					}
			   
			   
		   
		   
		   
           }
	post {
        failure {
            script {
                mail (to: 'manish.rajpal@iths.se',
                        subject: "Job '${env.JOB_NAME}' (${env.BUILD_NUMBER}) failed",
                        body: "Please visit ${env.BUILD_URL} for further information"
                );
                }
            }
         success {
             script {
                mail (to: 'manish.rajpal@iths.se',
                        subject: "Job '${env.JOB_NAME}' (${env.BUILD_NUMBER}) success.",
                        body: "Please visit ${env.BUILD_URL} for further information.",


                  );
                }
          }      
    }     
	}
 }
}
