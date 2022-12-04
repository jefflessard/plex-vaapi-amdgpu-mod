FROM alpine:edge AS source

RUN apk add mesa-va-gallium --no-cache --update-cache

RUN mkdir -p "/vaapi-amdgpu/lib/dri" \
 && cp /usr/lib/dri/radeonsi_drv_video.so "/vaapi-amdgpu/lib/dri" \
 && cd /lib \
 && cp -a ld-musl-x86_64.so.1* \
    libz.so.1* \
    "/vaapi-amdgpu/lib" \
 && cd /usr/lib \
 && cp -a libLLVM-15.0.6.so* \
    libLLVM-15.so* \
    libX11-xcb.so.1* \
    libXau.so.6* \
    libXdmcp.so.6* \
    libdrm_amdgpu.so.1* \
    libdrm_nouveau.so.2* \
    libdrm_radeon.so.1* \
    libelf-0.188.so* \
    libelf.so.1* \
    libexpat.so.1* \
    libgcc_s.so.1* \
    libstdc++.so.6* \
    libva-drm.so.2* \
    libva.so.2* \
    libxcb-dri2.so.0* \
    libxcb-dri3.so.0* \
    libxcb-present.so.0* \
    libxcb-sync.so.1* \
    libxcb-xfixes.so.0* \
    libxcb.so.1* \
    libxml2.so.2* \
    libxshmfence.so.1* \
    "/vaapi-amdgpu/lib"


FROM scratch

ENV LIBVA_DRIVERS_PATH="/vaapi-amdgpu/lib/dri" \
    LD_LIBRARY_PATH=/vaapi-amdgpu/lib:/lib/plexmediaserver/lib:/lib/x86_64-linux-gnu/:/lib

COPY --from=source "/vaapi-amdgpu/" "/vaapi-amdgpu/"


