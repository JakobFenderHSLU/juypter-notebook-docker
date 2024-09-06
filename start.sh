#!/usr/bin/env bash

# Start the SSH server
/usr/sbin/sshd

# Start the Jupyter notebook
jupyter notebook \
  --notebook-dir=/data \
  --NotebookApp.token= \
  --ip=0.0.0.0 \
  --port=8888 \
  --allow-root \
  --no-browser

# Keep the container running
tail -f /dev/null
