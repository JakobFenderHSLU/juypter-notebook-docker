# Use an official Ubuntu image
FROM python:3.9-slim

RUN mkdir /data

# Update and install necessary packages, including SSH server
RUN apt-get update && apt-get install -y \
    openssh-server \
    sudo

# Create SSH directory
RUN mkdir /var/run/sshd

# Set root password (you can modify this)
RUN echo 'root:rootpassword' | chpasswd

# Allow root login via SSH and enable password authentication
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config
RUN sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config

# Ensure SSH keys aren't used by default
RUN echo "UsePAM no" >> /etc/ssh/sshd_config

# Expose SSH port 22
EXPOSE 22

WORKDIR /app
COPY ./requirements/ /app/requirements/
RUN pip install -r /app/requirements/requirements.txt

ARG CONTEXT
RUN pip install -r /app/requirements/requirements-${CONTEXT}.txt

COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh

# Start SSH service
CMD ["./start.sh"]