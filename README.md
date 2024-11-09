![](./rsc/banner.png)

## A kaniko image wrapper to use 'kaniko as config'

kanikonf is wrapper allowing you to call kaniko using only a `.yaml` file.
This is particularly useful for cicd chains, where you can create a kanikonf configuration file in your 'pre-build' so that you can have no logic/configuration in the 'build' step.

<br><br>


# how it works
> ⚠️ you must have `yq` installed on the kaniko container

#### with a `/kanikonf.yaml` :
```yaml
# kanikonf.yaml
flags:
  destination:
    - registry/image:latest
    - registry/image:1.0.0
  context: /my_dir
  ...
```
> 💡 see `help.yaml` to see all the configuration fields

> 💡 you can specify the default path of the configuration file (default `/kanikonf.yaml`) by providing the `KANIKONF_PATH` env variable


#### playing `kanikonf.sh` will call :
```
/kaniko/executor --context=/mydir --destination=registry/image:latest --destination=registry/image:1.0.0 ...
```

<br><br>

# use it
- method 1 : build a custom `kanikonf` image,  look `Dockerfile` to see an exemple
- method 2 : just install le script with
```bash
wget https://raw.githubusercontent.com/eloi-menaud/kanikonf/refs/heads/main/kanikonf.sh && chmod +x kanikonf.sh
```

