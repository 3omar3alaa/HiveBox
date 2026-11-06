FROM python:3.13@sha256:ecbe213fb818d557fd19db4078244339e2e2e52874f9c81052d3094ea114d797
WORKDIR /app
COPY ./requirements.txt /app/requirements.txt
RUN pip install --no-cache-dir --upgrade -r /app/requirements.txt
COPY . /app
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]