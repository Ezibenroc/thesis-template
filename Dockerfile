FROM debian:buster

RUN apt update && apt install --no-install-recommends -y \
    build-essential git \
    emacs25 org-mode \
    texlive-full rubber inkscape
RUN apt install --no-install-recommends -y \
    poppler-utils
RUN apt install --no-install-recommends -y \
    r-base r-cran-ggplot2 r-cran-dplyr r-cran-tidyr r-cran-readr
RUN Rscript -e 'install.packages("patchwork", repos="https://cloud.r-project.org")'
RUN apt install --no-install-recommends -y time wget

# Installing Fira font
RUN wget https://github.com/mozilla/Fira/archive/refs/tags/4.202.zip -O fira.zip && unzip fira.zip
RUN mkdir -p /usr/share/fonts/truetype/FiraSans/ /usr/share/fonts/opentype/FiraSans/
RUN cp $(find Fira-4.202/ -name '*.ttf' | xargs) /usr/share/fonts/truetype/FiraSans/
RUN cp $(find Fira-4.202/ -name '*.otf' | xargs) /usr/share/fonts/opentype/FiraSans/
RUN fc-cache -fv
# we need this to use some functionnalities of the 'convert' tool, see https://stackoverflow.com/a/59193253/4110059
RUN sed -i '/disable ghostscript format types/,+6d' /etc/ImageMagick-6/policy.xml
