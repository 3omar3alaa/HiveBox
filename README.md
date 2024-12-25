# HiveBox
[![Dynamic DevOps Roadmap](https://devopshive.net/badges/dynamic-devops-roadmap.svg)](https://github.com/DevOpsHiveHQ/dynamic-devops-roadmap) [![OpenSSF Scorecard](https://api.scorecard.dev/projects/github.com/3omar3alaa/HiveBox/badge)](https://scorecard.dev/viewer/?uri=github.com/3omar3alaa/HiveBox)

This repo is the implementation of the hands-on project [HiveBox](
https://devopsroadmap.io/projects/hivebox/) provided by the [Dynamic DevOps Roadmap](https://devopsroadmap.io/getting-started/).

The HiveBox project is divided into phases where each phase contains incremental steps to complete the full project

## Phases
### Phase 2
The features implemented in this phase
1. Create a function that print current app version
2. Create a Dockerfile, build the Docker image and run it locally

### Phase 3
The features implemented in this phase
1. Implement using FastAPI
2. Add Version API
3. Add Temperature API that returns the avg temperature of three sensors
4. Add Unit tests
5. Add linting job in the CI pipeline
6. Build Docker image and push to Github Container Registry (GHCR) in the CI/CD pipeline. Refer to this [link](https://docs.github.com/en/actions/use-cases-and-examples/publishing-packages/publishing-docker-images) for more details
7. Integrate OpenSSF scorecard

Use the following commands to run the code
**Linux**
```
python3 -m uvicorn main:app --reload
```
**Windows**
```
python.exe -m uvicorn main:app --reload
```
### Phase 4
This phase includes prometheus, Kind and integration tests
1. Add /metrics API to return default prometheus metrics through the [Prometheus FastAPI Instrumentator](https://github.com/trallnag/prometheus-fastapi-instrumentator?tab=readme-ov-file) package