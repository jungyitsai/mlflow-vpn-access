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

# 將 artifact_repo.py 中的 encoding="utf-8" 修改為 encoding="big5"
RUN sed -i 's/encoding="utf-8"/encoding="big5"/' \
    $(python -c "import mlflow; import os; print(os.path.join(os.path.dirname(mlflow.__file__), 'store', 'artifact', 'artifact_repo.py'))")

# 驗證修改是否成功（選擇性）
RUN grep "open(trace_data_path, encoding=\"big5\")" \
    $(python -c "import mlflow; import os; print(os.path.join(os.path.dirname(mlflow.__file__), 'store', 'artifact', 'artifact_repo.py'))")


# 將容器的執行指令設為 /bin/bash
CMD ["/bin/bash"]
