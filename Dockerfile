# Good practice: Use official base images
#
FROM python:3.10-slim

# Good practice: upgrade distro packages (with last security patches).

RUN apt-get update && apt-get -y upgrade \
    && apt-get install -y git \
    && pip install --upgrade pip \
    && pip --version

RUN apt-get update && apt-get install -y procps \
    && rm -rf /var/lib/apt/lists/*

# Install mlflow dependencies:
#
WORKDIR /mlflow/

COPY requirements.txt .
COPY app.py .

RUN pip install --no-cache-dir -r requirements.txt \
    && rm requirements.txt

# Expose mlflow ports
#
EXPOSE 5000

# Launch the mlflow server

# CMD ["python3", "app.py"]

CMD mlflow server --backend-store-uri ${BACKEND_STORE_URI} \
                  --default-artifact-root ${DEFAULT_ARTIFACT_ROOT} \
                  --artifacts-destination ${DEFAULT_ARTIFACTS_DESTINATION} \
                  --no-serve-artifacts \
                  --host 0.0.0.0 --port 5000

