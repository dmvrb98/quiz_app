FROM python:3.9-buster

RUN apt-get update && \
    apt-get install -y \
    apt-utils cmake \
    libpq-dev python-dev \
    git gcc wget && \
    rm -rf /var/lib/apt/lists/*

ENV PYTHONUNBUFFERED 1

RUN apt-get clean && rm -rf /var/lib/apt/lists/*

RUN pip install poetry

# Copy only requirements to cache them in docker layer
WORKDIR /app
COPY poetry.lock pyproject.toml /app

# Project initialization:
RUN poetry config virtualenvs.create false \
  && poetry install --no-interaction --no-ansi

# Creating folders, and files for a project:
COPY . /app
