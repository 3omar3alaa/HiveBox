FROM python:3.13@sha256:6a9220edda062e9223ea0784740a535987299420b96fbfd520b89bbd3e772485
WORKDIR /app
COPY ./requirements.txt /app/requirements.txt
RUN pip install --no-cache-dir --upgrade -r /app/requirements.txt
COPY . /app
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]