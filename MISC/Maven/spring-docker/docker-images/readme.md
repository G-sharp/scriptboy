# SpringBoot之Docker部署 # [^Bolg参考]

##  Docker 支持 ##
在利用Maven构建的Spring-Boot项目中添加POM支持

1. 在`pom.xml`中添加镜像名称

```xml
<properties>
	<docker.image.prefix>springboot</docker.image.prefix>
</properties>
```
2. 在`pom.xml`中添加Docker构建插件

```xml
<build>
	<plugins>
		<plugin>
			<groupId>org.springframework.boot</groupId>
			<artifactId>spring-boot-maven-plugin</artifactId>
		</plugin>
		<!-- Docker maven plugin -->
		<plugin>
			<groupId>com.spotify</groupId>
			<artifactId>docker-maven-plugin</artifactId>
			<version>1.0.0</version>
			<configuration>
				<imageName>${docker.image.prefix}/${project.artifactId}</imageName>
				<dockerDirectory>src/main/docker</dockerDirectory>
				<resources>
					<resource>
						<targetPath>/</targetPath>
						<directory>${project.build.directory}</directory>
						<include>${project.build.finalName}.jar</include>
					</resource>
				</resources>
			</configuration>
		</plugin>
		<!-- Docker maven plugin -->
	</plugins>
</build>
```
3. 编写Dockefile文件

在`src/main/docker`文件夹下新建`Dockerfile`文件,用来指示构建镜像
针对`jdk-8:`

```Dockerfile
FROM openjdk:8-jdk-alpine
VOLUME /tmp
ADD spring-boot-docker-1.0.jar app.jar
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/app.jar"]
```

针对`jdk-11:`

```Dockerfile
FROM openjdk:14-alpine
VOLUME /tmp
ADD spring-boot-docker-1.0.jar app.jar
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/app.jar"]
```
`spring-boot-docker-1.0.jar` 是项目生成的jar包名,按需修改.
4. 打包生成
运行`mvn package docker:build`,你会发现docker本地仓库出现了springboot/{project}镜像


##  Docker镜像迁移 ##
###镜像导出  ###
`docker save xxxx.tar image-name`
###镜像生成  ###
`docker load xxx.tar`
## References ##

[^Bolg参考]:[使用Docker部署SpringBoot](https://www.cnblogs.com/ityouknow/p/8599093.html)
