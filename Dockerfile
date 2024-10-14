FROM cgr.dev/chainguard/python:latest-dev as building
WORKDIR /app
RUN python -m venv venv
ENV PATH="/app/venv/bin":$PATH
COPY requirements.txt requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

FROM cgr.dev/chainguard/python:latest 
WORKDIR /app
COPY app.py app.py
COPY static/ static/
COPY templates/ templates/
COPY tailwind.config.js tailwind.config.js
COPY --from=building /app/venv /app/venv
ENV PATH="/app/venv/bin:$PATH"
EXPOSE 5000
ENTRYPOINT ["flask"]
CMD ["run", "--host=0.0.0.0"]
