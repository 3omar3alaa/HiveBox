FROM python:3.13@sha256:5b6557f37abf12bfc64315bba192b342aec6dbf367aed30b7db51082aec73a1e
WORKDIR /app
COPY ./requirements.txt /app/requirements.txt
RUN pip install --no-cache-dir --upgrade -r /app/requirements.txt
COPY . /app
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]