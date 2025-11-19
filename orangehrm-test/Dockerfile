FROM python:3.13-slim

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /app

RUN apt-get update && apt-get install -y \
    curl \
    gnupg \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /etc/apt/keyrings && \
    curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg && \
    echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_20.x nodistro main" > /etc/apt/sources.list.d/nodesource.list && \
    apt-get update && apt-get install -y nodejs && rm -rf /var/lib/apt/lists/*

COPY robot /app/robot
COPY .github/workflows /app/.github/workflows
COPY README.md /app/README.md

RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir robotframework robotframework-browser && \
    rfbrowser init && \
    npx playwright install-deps

ENV BASE_URL=https://opensource-demo.orangehrmlive.com/web/index.php/auth/login
ENV ADMIN_USER=Admin
ENV ADMIN_PASS=admin123
ENV HEADLESS=True

CMD ["robot", "-d", "robot/reports", "robot/tests"]