# 使用官方 Python 基底映像
FROM python:3.9-slim

# 設定工作目錄
WORKDIR /app

# 安裝必要的系統套件
RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev \
    --no-install-recommends && rm -rf /var/lib/apt/lists/*

# 安裝 Python 套件
RUN pip install --no-cache-dir \
    mlflow==2.20.0 \
    psycopg2 \
    boto3

# 將容器的執行指令設為 /bin/bash
CMD ["/bin/bash"]
