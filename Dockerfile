FROM bitnami/minideb:jessie

RUN install_packages \
		cython \
		python-dev \
		python-numpy \
		python-scipy \
		python-matplotlib \
		python-tk \
		libgsl0-dev \
		gcc \
		wget

WORKDIR /fstr
RUN wget --no-check-certificate \
	https://github.com/rajanil/fastStructure/archive/master.tar.gz && \
	tar --strip-components=1 -xvzf master.tar.gz && \
	cd /fstr/vars && \
	python setup.py build_ext --inplace && \
	cd /fstr/ && \
	python setup.py build_ext --inplace && \
	sed -i '1s/^/import matplotlib\nmatplotlib.use("Agg")\n/' distruct.py 

CMD ["python", "structure.py"]
