FROM zricethezav/gitleaks

LABEL "com.github.actions.name"="gitCret"
LABEL "com.github.actions.description"="Prevents pushing sensitive keys/credentials. Continuously scan your repositories, commits or pull-requests for sensitive credentials and generate alerts."
LABEL "version"="1.0"
LABEL "com.github.actions.icon"="shield"
LABEL "com.github.actions.color"="blue"
LABEL "repository"="https://github.com/CySeq/gitcret"
LABEL "homepage"="https://github.com/CySeq/gitcret"

RUN apk add --no-cache \
	bash \
	ca-certificates \
	coreutils \
	curl \
	jq

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
