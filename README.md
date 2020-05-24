Jekins
======
### Overview

[Jenkins official site](https://www.jenkins.io/)<br>
[official guide](https://www.jenkins.io/doc/book/)<br>
[official tutorial ](https://www.jenkins.io/doc/tutorials/)<br>

### Troubleshoots

1. 도커 설치하고 컨테이커가 종료된 후 로그가 아래와 같을때  <br>

error : Can not write to /var/jenkins_home/copy_reference_file.log. Wrong volume permissions

volume을 사용할 시 호스트의 경로 /var/jenkins_home 에 권한이 없는 문제이다.

해결 
```shell
# mkdir /var/jenkins_home
# sudo chown 1000 /var/jeknins_home
```

#### Reference: [[docker] jenkins — Can not write to /var/jenkins_home/copy_reference_file.log. Wrong volume permissions](https://medium.com/@logan.81k/docker-jenkins-can-not-write-to-var-jenkins-home-copy-reference-file-log-7a969991845a)


### References

[[Jenkins] 젠킨스란 무엇인가](https://ict-nroo.tistory.com/31) <br>
[Jenkins Pipeline 구성](https://medium.com/@jyson88/jenkins-pipeline-%EA%B5%AC%EC%84%B1-d4d0a4c074c5) <br>
[https://kingbbode.tistory.com/35](https://kingbbode.tistory.com/35) <br>
[젠킨스 사용하여 자동 배포환경 만들어보기](https://kingbbode.tistory.com/35) <br>
[젠킨스 jenkins / Jenkinsfile 작성법 (gradle build, github 연동)](https://umbum.dev/868) <br>
[]()
[]()
[]()
