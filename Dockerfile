FROM python:3.13@sha256:f758b6ca6fd1a733d6d50584acca528421c0d86d260107ede3f14ba1928b1343
WORKDIR /app
COPY ./requirements.txt /app/requirements.txt
RUN pip install --no-cache-dir --upgrade -r /app/requirements.txt
COPY . /app
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]