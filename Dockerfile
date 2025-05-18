FROM debian:trixie-slim

ENV USERNAME='royman'
ENV PASSWORD='royman'
ENV NEOVIM_VERSION='v0.11.1'
ENV ARCH='x86_64'
ENV RC_FILE='.bashrc'
ENV PYTHON_VERSION='3.12'

RUN apt update && apt upgrade -y
RUN apt install -y \
	curl \
	wget \
	sudo \
	build-essential \
	gcc \
	git \
	zlib1g-dev \
	libssl-dev \
	liblzma-dev \
	sqlite3 \
	libreadline-dev \
	unzip \
	lbzip2 \
	libssl-dev \
	libsqlite3-dev \
	libffi-dev \
	tk-dev \
	libbz2-dev \
	libreadline-dev

RUN useradd royman -G sudo -m
RUN "${USERNAME}:${PASSWORD}" | chpasswd

WORKDIR /tmp

# Neovim - Installation
RUN wget https://github.com/neovim/neovim/releases/download/${NEOVIM_VERSION}/nvim-linux-${ARCH}.tar.gz
RUN gunzip nvim-linux-${ARCH}.tar.gz
RUN tar xf nvim-linux-${ARCH}.tar
RUN mkdir -p /usr/local/share/nvim
RUN mv nvim-linux-${ARCH} /usr/local/share/nvim/${NEOVIM_VERSION}
RUN ln -s /usr/local/share/nvim/${NEOVIM_VERSION} /usr/local/share/nvim/current
RUN ln -s /usr/local/share/nvim/current/bin/nvim /usr/local/bin/nvim
RUN echo 'alias vim=/usr/local/bin/nvim' >> /home/${USERNAME}/${RC_FILE}

USER ${USERNAME}

# nvm - Installation
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
RUN echo 'export NVM_DIR="$HOME/.nvm"' >> /home/${USERNAME}/${RC_FILE}
RUN echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"' >> /home/${USERNAME}/${RC_FILE}
# Node - Installation
RUN /home/${USERNAME}/.nvm/nvm.sh install --lts

# Pyenv - Installation
RUN curl https://pyenv.run | bash
RUN echo "export PYENV_ROOT=/home/${USERNAME}/.pyenv" >> /home/${USERNAME}/${RC_FILE}
RUN echo '[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"' >> /home/${USERNAME}/${RC_FILE} 
RUN echo 'eval "$(pyenv init - sh)"' >> /home/${USERNAME}/${RC_FILE}
RUN echo 'eval "$(pyenv virtualenv-init -)"' >> /home/${USERNAME}/${RC_FILE}
RUN /home/${USERNAME}/.pyenv/bin/pyenv init - sh
RUN /home/${USERNAME}/.pyenv/bin/pyenv virtualenv-init -

# Python 3.12 - Installation
RUN /home/${USERNAME}/.pyenv/bin/pyenv install ${PYTHON_VERSION}
RUN /home/${USERNAME}/.pyenv/bin/pyenv global ${PYTHON_VERSION}

USER root
COPY entrypoint.sh /tmp/entrypoint.sh
RUN chmod +x entrypoint.sh
ENTRYPOINT ["./entrypoint.sh"]
