FROM continuumio/miniconda3:4.8.3

RUN conda install --yes \
    -c conda-forge \
    python==3.7.10 \
    python-blosc==1.9.2 \
    cytoolz \
    dask==2021.4.* \
    nomkl \
    numpy==1.19.5 \
	lz4==3.1.3 \
    pandas==1.2.3 \
    tini==0.18.0 \
    joblib==1.0.1 \
    scikit-learn==0.24.1 \
	msgpack-python==1.0.2 \
    && conda clean -tipsy \
    && find /opt/conda/ -type f,l -name '*.a' -delete \
    && find /opt/conda/ -type f,l -name '*.pyc' -delete \
    && find /opt/conda/ -type f,l -name '*.js.map' -delete \
    && find /opt/conda/lib/python*/site-packages/bokeh/server/static -type f,l -name '*.js' -not -name '*.min.js' -delete \
    && rm -rf /opt/conda/pkgs

COPY prepare.sh /usr/bin/prepare.sh

RUN mkdir /opt/app

ENTRYPOINT ["tini", "-g", "--", "/usr/bin/prepare.sh"]
