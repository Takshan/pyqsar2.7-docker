FROM ubuntu:lunar-20231128
ENV DEBIAN_FRONTEND=noninteractive

RUN  apt-get update \
  && apt-get install -y wget \
  && rm -rf /var/lib/apt/lists/*


ARG env=pyq2

RUN wget -O /tmp/anaconda.sh https://repo.anaconda.com/archive/Anaconda3-2023.09-0-Linux-x86_64.sh \
    && bash /tmp/anaconda.sh -b -p /anaconda \
    && eval "$(/anaconda/bin/conda shell.bash hook)" \
    && conda init 

ENV PATH="/anaconda/bin:${PATH}"
RUN conda  create  -n  {env}  python=2.7.18
RUN echo "source activate {env}" > ~/.bashrc
ENV PATH /anaconda/envs/{env}/bin:$PATH
RUN apt-get update  && apt -y upgrade
WORKDIR /app
SHELL ["conda", "run","--no-capture-output", "-n", "{env}", "/bin/bash", "-c"]

RUN python -m pip install --upgrade pip
RUN pip install notebook
RUN conda install -c rdkit rdkit
RUN pip  install  scikit-learn==0.18.1
RUN pip  install  scipy==0.18.1
RUN pip  install  matplotlib==2.0.2
RUN pip  install  ipywidgets==6.0.0
RUN pip  install  bokeh==0.12.5
RUN pip  install  joblib==0.11
RUN pip  install  pyqsar
