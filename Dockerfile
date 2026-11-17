FROM python:3.13@sha256:9ffe84122ce74ebdffe2e0e6b946c9dd95d0bf3463f6eb1006b4dc6fefe36d01
WORKDIR /app
COPY ./requirements.txt /app/requirements.txt
RUN pip install --no-cache-dir --upgrade -r /app/requirements.txt
COPY . /app
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]