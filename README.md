This is a [linuxserver.io user mod](https://github.com/linuxserver/docker-mods) to enable hardware acceleration using vaapi amdgpu for [linuxserver.io' Plex Media Server image](https://docs.linuxserver.io/images/docker-plex).

Librairies are taken from package [mesa-va-gallium](https://pkgs.alpinelinux.org/package/edge/main/x86/mesa-va-gallium) of alpine:edge because Plex is compiled with musl and using Ubuntu libs will lead to unresolved symbols.

Librairies are voluntarily located outside of plexmediaserver path, in `/vaapi-amdgpu/lib`. This allows to use `VERSION=latest` so Plex can automatically updates its version, without replacing the provided librairies.

Set the `DOCKER_MODS` environment variable to `jefflessard/plex-vaapi-amdgpu-mod` such as in the example below.


Usage example :

```
docker run -d \
       --device /dev/dri/ \
       -e DOCKER_MODS=jefflessard/plex-vaapi-amdgpu-mod \
       -e VERSION=latest \
       ...
       --name plex \
       linuxserver/plex
```

Defining LD_LIBRARY_PATH and LIBVA_DRIVERS_PATH is not required anymore. They are now exported in s6 svc-plex run command.


**You now need to remove `-e LD_LIBRARY_PATH=...` from your docker run command.**




To quickly check if hardware acceleration is working, run the following and check for vaapi errors.
```
docker exec -it -e LIBVA_DRIVERS_PATH=/vaapi-amdgpu/lib/dri -e LD_LIBRARY_PATH=/vaapi-amdgpu/lib plex \
/lib/plexmediaserver/Plex\ Transcoder -hide_banner -loglevel debug -vaapi_device /dev/dri/renderD128
```

