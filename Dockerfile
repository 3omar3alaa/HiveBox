FROM python:3.13@sha256:9255d1993f6d28b8a1cd611b108adbdfa38cb7ccc46ddde8ea7d734b6c845e32
WORKDIR /app
COPY ./requirements.txt /app/requirements.txt
RUN pip install --no-cache-dir --upgrade -r /app/requirements.txt
COPY . /app
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]