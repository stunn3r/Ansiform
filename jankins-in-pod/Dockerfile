FROM jenkins/jenkins:lts

RUN \
        /usr/local/bin/install-plugins.sh ansicolor && \
        /usr/local/bin/install-plugins.sh greenballs && \
        /usr/local/bin/install-plugins.sh pipeline-utility-steps pipeline-config-history pipeline-github pipeline-stage-view build-pipeline-plugin && \
        /usr/local/bin/install-plugins.sh docker rebuild neuvector-vulnerability-scanner anchore-container-scanner && \
        /usr/local/bin/install-plugins.sh kubernetes kubernetes-pipeline-steps readonly-parameters

USER jenkins
