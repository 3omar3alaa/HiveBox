FROM python:3.13@sha256:6faba2c56370992b0456e11f781f00a09b7ecc3c4e97ef3e39163d01a94aea8d
WORKDIR /app
COPY ./requirements.txt /app/requirements.txt
RUN pip install --no-cache-dir --upgrade -r /app/requirements.txt
COPY . /app
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]