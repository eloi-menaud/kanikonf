

[ -z "$KANIKONF_PATH" ] && FILE="/kanikonf.yaml" ||  FILE="$KANIKONF_PATH"


[ $(yq --version) ] && { echo "$0: 'yq' must be available"; exit 1; }
[ ! -f "$FILE" ] && { echo "$0: can't retrieve '$FILE'. Use the 'KANIKONF_PATH' env var to overrite default 'kaniko.yaml' path"; exit 1; }


flag(){
	flag="$1"
	arg=$(yq eval ".flags.$flag // \"\"" $FILE)
	[ -z $arg ] && arg="$2"
	[ ! -z $arg ] && echo " --$flag=$arg"
}


flags(){
	flag=$1
	yq eval ".flags.$flag[]" $FILE | while read -r value; do
		echo -n " --$flag='$value'"
	done
}


echo "$0 : using '$FILE'"

echo "$0 : writing docker.config to /kaniko/.docker/config.json"
yq eval '.docker.config' -o=json $FILE > /kaniko/.docker/config.json

echo "$0 : executing /kaniko/executor by parsing '.flags'"

/kaniko/executor \
$(flag  cache false                                  ) \
$(flag  cache-copy-layers                 false      ) \
$(flag  cache-dir                         /cache     ) \
$(flag  cache-repo                                   ) \
$(flag  cache-run-layers                  true       ) \
$(flag  cache-ttl                         336h0m0s   ) \
$(flag  cleanup                           false      ) \
$(flag  compressed                                   ) \
$(flag  compression                                  ) \
$(flag  context                           /workspace/) \
$(flags destination                                  ) \
$(flag  digest-file                       false      ) \
$(flag  dockerfile                        Dockerfile ) \
$(flag  git                               branch=,single-branch=false,recurse-submodules=false,insecure-skip-tls=false) \
$(flags ignore-path                                  ) \
$(flag  ignore-var-run                    true       ) \
$(flag  image-download-retry              0          ) \
$(flag  image-fs-extract-retry            0          ) \
$(flag  image-name-tag-with-digest-file              ) \
$(flag  image-name-with-digest-file                  ) \
$(flag  insecure                          false      ) \
$(flag  insecure-pull                     false      ) \
$(flags insecure-registry                            ) \
$(flag  kaniko-dir                                   ) \
$(flags label                                        ) \
$(flag  log-format                        color      ) \
$(flag  log-timestamp                     false      ) \
$(flag  no-push                           false      ) \
$(flag  no-push-cache                     false      ) \
$(flag  oci-layout-path                              ) \
$(flag  push-ignore-immutable-tag-errors  false      ) \
$(flag  push-retry                        0          ) \
$(flags registry-certificate                         ) \
$(flags registry-client-cert                         ) \
$(flags registry-map                                 ) \
$(flags registry-mirror                              ) \
$(flag  reproducible                      false      ) \
$(flag  single-snapshot                   false      ) \
$(flag  skip-default-registry-fallback   false       ) \
$(flag  skip-push-permission-check        false      ) \
$(flag  skip-tls-verify                   false      ) \
$(flag  skip-tls-verify-pull                         ) \
$(flags skip-tls-verify-registry                     ) \
$(flags skip-unused-stages                           ) \
$(flag  snapshot-mode full                           ) \
$(flag  tar-path                                     ) \
$(flag  target                                       ) \
$(flag  use-new-run                                  ) \
$(flag  verbosity info                               ) \

