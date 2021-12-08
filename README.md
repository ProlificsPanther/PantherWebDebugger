To run Panther Web Debugger inside a preconfigured Docker container with all the require setup for debugger.

###  Panther Debugger in Docker Container
Panther Support team has built a docker image https://hub.docker.com/repository/docker/prolificspanther/mutest1 and with the help of it we can create and run a container that contains preconfigured setup to run a Panther debugger to debug your application.

#### Prerequisite
Docker should be installed on your machine. To run docker image on Windows Docker Desktop application should be installed on Windows OS.
 

### Instructions to run docker Container
  i.   To pull a Panther Debugger image use command `docker pull prolificspanther/debugger` <br>
  ii.  Create and run docker container use command `docker run --name=<name of container> -p8080:8080 -d prolificspanther/debugger` <br>
  iii. Enter in container using command `docker exec -ti <name of container> bash` <br>
  iv.  Run a browser and enter the url `localhost:8080/Gen2a/Debugger` to acces the Panther Debugger. <br>
  v.   Next add the applications’ URL to the Application URL field, .i.e. localhost:8080/PantherDemo/PantherDemo  ( for example), then press Go.
  vi.  The Application will open in the next Browser Tab

####  NOTE:

  In case if we are making any changes regarding the jars in the libararies of the TOmcat then it will require to restart Tomcat. While shutting down Tomcat it might possible that
  Docker container can also exit. TO restart docker container use command `docker start <name of container>.




Read our Documentation [here](https://docs.prolifics.com)
