#!/usr/bin/env bash
if [ "${CONTEXT}" != "" ]; then
  pip install -r ./requirements/requirements-"${CONTEXT}".txt
fi
