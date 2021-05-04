pipeline{
    agent any
    stages{
        stage('para'){
            parallel{
                 stage('APIServer'){
                            steps{
				    sleep(40)
                                sh 'cd spring-petclinic-rest && nohup mvn spring-boot:run &'
                            }
                }
                 stage('angular'){
                              steps{
                                    sleep(40)
                                    sh 'cd spring-petclinic-angular/static-content && curl https://jcenter.bintray.com/com/athaydes/rawhttp/rawhttp-cli/1.0/rawhttp-cli-1.0-all.jar -o rawhttp.jar && nohup java -jar ./rawhttp.jar serve . -p 4200 &'
                              }
                }
				
				
				stage('Newman') {
						steps {
						   sleep(40)
							sh 'newman run  petclinic.collection.json --environment petclinic.environment.json --reporters junit'
							}
						post {
							always {
									junit '**/*xml'
								}
							}

					}
			   	stage('Robot Framework') {
                              steps {
                                    sleep(30)
                                    sh 'robot --variable BROWSER:headlesschrome -d RobotFrameWork/Results RobotFrameWork/Tests'
                              }
                              post {
                                    always {
                                           script {
                                                  step(
                                                       [
                                                             $class              : 'RobotPublisher',
                                                              outputPath          : 'RobotFrameWork/Results',
                                                              outputFileName      : '**/output.xml',
                                                              reportFileName      : '**/report.html',
                                                              logFileName         : '**/log.html',
                                                              disableArchiveOutput: false,
                                                              passThreshold       : 50,
                                                              unstableThreshold   : 40,
                                                              otherFiles          : "**/*.png,**/*.jpg",
                                                       ]
                                                  )
                                           }
                                    }
                              }
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
