FROM ubuntu:20.04

LABEL maintainer="Chandresh Rajkumar Manonmani <cs1193@gmail.com>"

ARG USERNAME=vscode
ARG USER_ID=1000
ARG GROUP_ID=$USER_ID

ENV DEBIAN_FRONTEND noninteractive

# added user - vscode
RUN groupadd -g ${GROUP_ID} ${USERNAME}
RUN useradd -r -u ${USER_ID} -g ${GROUP_ID} -d /home/${USERNAME} -m ${USERNAME}
RUN chown ${USERNAME}:${USERNAME} /home/${USERNAME}

RUN apt update -y
RUN apt install -y \
  sudo \
  wget \
  curl \
  bash \
  git \
  unzip \
  jq \
  gnupg

RUN apt install -y \
  texlive-full

# clean
RUN apt clean \
  && rm -rf /var/lib/apt/lists/*

# added user to sudoers - vscode
RUN echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME
RUN chmod 0440 /etc/sudoers.d/$USERNAME

# user vscode
USER ${USERNAME}
WORKDIR /home/${USERNAME}

SHELL ["/bin/bash"]
