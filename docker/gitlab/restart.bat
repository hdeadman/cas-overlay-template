@call env.bat
@rem You could call run.bat and rm the container each time to restart but this just stops, updates config and starts
@rem One advantage of removing the container is reseting the container log output
docker stop %CONTAINER_NAME%
copy gitlab.rb %GITLAB_BASE%\config
docker start %CONTAINER_NAME%
@echo Run "docker logs --since 2m -f %CONTAINER_NAME%" to tail container stdout (which is a combined tail of many internal logs files)
@echo Run "docker ps -a" to see status of containers
@echo Run "docker stop %CONTAINER_NAME%" to stop the container