FROM alpine:edge AS source

RUN apk add mesa-va-gallium --no-cache --update-cache

RUN mkdir -p "/source/vaapi-amdgpu/lib/dri" \
 && cp -a /usr/lib/dri/*.so /source/vaapi-amdgpu/lib/dri \
 && cd /lib \
 && cp -a \
    ld-musl-x86_64.so.1* \
    libc.musl-x86_64.so.1* \
    libz.so.1* \
    /source/vaapi-amdgpu/lib \
 && cd /usr/lib \
 && cp -a \
    libLLVM-15*.so* \
    libX11-xcb.so.1* \
    libXau.so.6* \
    libXdmcp.so.6* \
    libdrm.so.2* \
    libdrm_amdgpu.so.1* \
    libdrm_nouveau.so.2* \
    libdrm_radeon.so.1* \
    libelf-*.so* \
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
    libbsd.so.0* \
    libmd.so.0* \
    libzstd.so.1* \
    libffi.so.8* \
    liblzma.so.5* \
    /source/vaapi-amdgpu/lib \
 && mkdir -p /source/usr/share/libdrm \
 && cp -a /usr/share/libdrm/amdgpu.ids /source/usr/share/libdrm/ \
 && mkdir -p /source/etc/s6-overlay/s6-rc.d/svc-plex/ 

COPY run /source/etc/s6-overlay/s6-rc.d/svc-plex/ 

FROM scratch

#ENV LIBVA_DRIVERS_PATH="/vaapi-amdgpu/lib/dri" \

COPY --from=source "/source/" "/"

