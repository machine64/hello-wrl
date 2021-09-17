# inherit defined based image
FROM  registry-testing.kazan.atosworldline.com/sandbox/awl-openshift-training-centos7-python:latest

# define a mailing-list maintainer
LABEL maintainer="dl-od_am_sa@worldline.com"

# port(s) exposed (avoid privileged ports if you target openshift - >1024)
EXPOSE 8080

# labels are optional but still a good way to do
# learn more at: https://docs.openshift.com/container-platform/3.7/creating_images/metadata.html
LABEL io.k8s.description="a-training - Step 1 - Hello" \
  io.k8s.display-name="a-training - Step 1 - Hello" \
  io.openshift.expose-services="8080:http" \
  io.openshift.tags="sdco-dev,a-training"
  
# define required environment variable
ENV HOME=/opt/app-root/src PYTHONUNBUFFERED=true

# add you application artifact(s) and entrypoint script
# for interpreted languages like python, there is no build step and artifact is the source code itself
ADD src/app.py run.sh ${HOME}/

# set the image working directory and user - other than root/0
WORKDIR ${HOME}
USER 1001

# define the starting command: calling 'sh run.sh'' instead of just 'run.sh' is a good habit that prevent you from setting x right to run.sh
CMD ["sh", "/opt/app-root/src/run.sh"]
