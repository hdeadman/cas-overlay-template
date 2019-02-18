@call env.bat
docker stop %CONTAINER_NAME%
docker rm %CONTAINER_NAME%
mkdir %GITLAB_BASE%
mkdir %GITLAB_BASE%\config
mkdir %GITLAB_BASE%\config\ssl
mkdir %GITLAB_BASE%\logs
mkdir %GITLAB_BASE%\data
copy gitlab.rb %GITLAB_BASE%\config
copy %DOMAIN%.key %GITLAB_BASE%\config\ssl\gitlab.key
copy %DOMAIN%.crt %GITLAB_BASE%\config\ssl\gitlab.crt
@rem On windows we need a docker volume for the main gitlab folder b/c gitlab's chef provisioning scripts don't deal well with windows permissions
docker volume create gitlab-data
docker run --detach --name %CONTAINER_NAME% -p 8444:443 --volume %GITLAB_BASE%\config:/etc/gitlab --volume %GITLAB_BASE%\logs:/var/log/gitlab --volume gitlab-data:/var/opt/gitlab %IMAGE_NAME%
@echo Run the following to tail the logs:
@echo docker logs %CONTAINER_NAME% -f
