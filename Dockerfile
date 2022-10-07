FROM python:3.8-slim as builder

RUN apt-get update && apt-get install gcc python3-dev --yes

RUN python -m pip install pipenv

COPY ./Pipfile* /project/
WORKDIR /project

RUN pipenv requirements > /project/requirements.txt
RUN pip wheel --no-cache-dir --no-deps --wheel-dir /usr/src/wheels -r requirements.txt

FROM python:3.8-slim as project

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

RUN addgroup --system app && adduser --system --group app


COPY --from=builder /usr/src/wheels /wheels
COPY --from=builder /project/requirements.txt /project/
RUN pip install --upgrade pip
RUN pip install --no-cache /wheels/*

WORKDIR /project

COPY app /project/app

USER app
ENTRYPOINT ["gunicorn", "--chdir", "app", "--bind", "0.0.0.0:5001", "manage:app"]
