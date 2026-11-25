FROM python:3.13@sha256:f25cbd3f7c73c28bdcab476c93c93a2ec90970a8f5b8a7810533654207822390
WORKDIR /app
COPY ./requirements.txt /app/requirements.txt
RUN pip install --no-cache-dir --upgrade -r /app/requirements.txt
COPY . /app
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]