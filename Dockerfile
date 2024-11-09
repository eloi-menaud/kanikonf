FROM gcr.io/kaniko-project/executor:debug

RUN wget https://github.com/mikefarah/yq/releases/download/v4.33.2/yq_linux_amd64 -O /busybox/yq && chmod +x /busybox/yq

RUN wget https://raw.githubusercontent.com/eloi-menaud/kanikonf/refs/heads/main/kanikonf.sh -O /busybox/kanikonf && chmod +x /busybox/yq

CMD ["kanikonf"]
