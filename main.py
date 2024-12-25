"""

Main 

"""

from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from prometheus_fastapi_instrumentator import Instrumentator
import toml
from controllers import open_sense

# Load the pyproject.toml file
with open("pyproject.toml", "r", encoding="utf-8") as f:
    pyproject_data = toml.load(f)

# Extract the version
app_version = pyproject_data["project"]["version"]

app = FastAPI(
    title="HiveBox",
    description="HiveBox Project",
    version=app_version,
)


@app.get("/version")
async def get_version():
    """
    Version API
    """
    return {"version": app_version}


app.include_router(open_sense.router)
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_methods=["*"],
    allow_headers=["*"],
)

Instrumentator().instrument(app).expose(app)


def main():
    """
    Main function
    """
    __version__ = "1.0.0"
    print(__version__)


if __name__ == "__main__":
    main()
