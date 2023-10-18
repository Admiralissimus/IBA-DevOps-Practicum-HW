# IBA-DevOps-Practicum-HW

## 1. Подключить Windows Slave к Jenkins.

- installed jdk-17-0-7 on windows
> https://download.oracle.com/java/17/archive/jdk-17.0.7_windows-x64_bin.exe
> 
> https://www.youtube.com/watch?v=N8AQTlHoBKc
> 
> https://github.com/winsw/winsw/releases/download/v2.12.0/WinSW-x64.exe - to run as a service


- Run from agent command line: (Windows)
  
  ` curl.exe -sO http://jenkins-server:8080/jnlpJars/agent.jar `
  
  ` java -jar agent.jar -jnlpUrl http://jenkins-server:8080/computer/windows/jenkins-agent.jnlp -workDir "c:\jenkins" `


## 2. Создать джобу, которая запустит на новом слейве любой bat скрипт.

```
<?xml version='1.1' encoding='UTF-8'?>
<project>
  <description></description>
  <keepDependencies>false</keepDependencies>
  <properties/>
  <scm class="hudson.scm.NullSCM"/>
  <assignedNode>windows</assignedNode>
  <canRoam>false</canRoam>
  <disabled>false</disabled>
  <blockBuildWhenDownstreamBuilding>false</blockBuildWhenDownstreamBuilding>
  <blockBuildWhenUpstreamBuilding>false</blockBuildWhenUpstreamBuilding>
  <triggers/>
  <concurrentBuild>false</concurrentBuild>
  <builders>
    <hudson.tasks.BatchFile>
      <command>echo $WORKSPACE</command>
      <configuredLocalRules/>
    </hudson.tasks.BatchFile>
  </builders>
  <publishers/>
  <buildWrappers/>
</project>
```
