FROM python:3.13@sha256:220d07595f288567bbf07883576f6591dad77d824dce74f0c73850e129fa1f46
WORKDIR /app
COPY . /app
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "80"]